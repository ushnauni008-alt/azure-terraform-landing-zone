$excelPath  = Join-Path $PSScriptRoot "..\requirements\client_requirements.xlsx"
$csvPath    = Join-Path $PSScriptRoot "..\requirements\infrastructure.csv"
$outputPath = Join-Path $PSScriptRoot "..\Terraform\terraform.tfvars.json"

# Step 1: Read Excel and generate CSV
$excelData = Import-Excel -Path $excelPath

$excelData | Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8

Write-Host "CSV generated:"
Write-Host $csvPath

# Step 2: Read CSV
$data = Import-Csv $csvPath

$resourceGroups = @{}
$virtualNetworks = @{}
$subnets = @{}

foreach ($row in $data) {

    switch ($row.ResourceType) {

        "ResourceGroup" {
            $resourceGroups[$row.Key] = @{
                name     = $row.Name
                location = $row.Location
            }
        }

        "VNet" {
            $virtualNetworks[$row.Key] = @{
                name               = $row.Name
                resource_group_key = $row.ParentKey
                location           = $row.Location
                address_space      = @($row.AddressSpace)
            }
        }

        "Subnet" {
            $subnets[$row.Key] = @{
                name                = $row.Name
                virtual_network_key = $row.ParentKey
                address_prefixes    = @($row.AddressSpace)
            }
        }
    }
}

$terraformInput = @{
    resource_groups  = $resourceGroups
    virtual_networks = $virtualNetworks
    subnets          = $subnets
}

$terraformInput |
    ConvertTo-Json -Depth 10 |
    Set-Content $outputPath

Write-Host "Terraform tfvars generated:"
Write-Host $outputPath