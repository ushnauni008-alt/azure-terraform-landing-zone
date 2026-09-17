$excelPath = Join-Path $PSScriptRoot "..\requirements\client_infrastructure_requirements.xlsx"
$csvPath = Join-Path $PSScriptRoot "..\requirements\infrastructure.csv"
$outputPath = Join-Path $PSScriptRoot "..\terraform\terraform.tfvars.json"

# Read Excel
$excelData = Import-Excel -Path $excelPath

# Generate CSV
$excelData |
    Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8

Write-Host "CSV generated:"
Write-Host $csvPath


# Read generated CSV
$data = Import-Csv $csvPath

$resourceGroups = @{}
$virtualNetworks = @{}
$subnets = @{}
$networkSecurityGroups = @{}
$networkSecurityRules = @{}
$applicationSecurityGroups = @{}
$publicIPs = @{}
$networkInterfaces = @{}


foreach ($row in $data) {

    switch ($row.ResourceType) {

        "ResourceGroup" {

            $resourceGroups[$row.Key] = @{
                name     = $row.Name
                location = $row.Location
            }
        }


        "VirtualNetwork" {

            $virtualNetworks[$row.Key] = @{
                name               = $row.Name
                location           = $row.Location
                resource_group_name = $resourceGroups[$row.ParentKey].name
                address_space      = @($row.AddressSpace)
            }
        }


        "Subnet" {

            $subnets[$row.Key] = @{
                name                = $row.Name
                resource_group_name = $virtualNetworks[$row.ParentKey].resource_group_name
                virtual_network_name = $virtualNetworks[$row.ParentKey].name                
                address_prefixes    = @($row.AddressSpace)
            }
        }


        "NetworkSecurityGroup" {

            $networkSecurityGroups[$row.Key] = @{
                name               = $row.Name
                location           = $row.Location
                resource_group_name = $resourceGroups[$row.ParentKey].name
            }
        }
        "NetworkSecurityRule" {

            $networkSecurityRules[$row.Key] = @{
               name                       = $row.Name
               nsg_key                    = $row.NSGKey
               priority                   = [int]$row.Priority
               direction                  = $row.Direction
               access                     = $row.Access
               protocol                   = $row.Protocol
               source_port_range          = $row.SourcePortRange
               destination_port_range     = $row.DestinationPortRange
               source_address_prefix      = $row.SourceAddressPrefix
               destination_address_prefix = $row.DestinationAddressPrefix
               source_asg_key             = $row.SourceASGKey
               destination_asg_key        = $row.DestinationASGKey
           }
       }

        "ApplicationSecurityGroup" {

            $applicationSecurityGroups[$row.Key] = @{
                name               = $row.Name
                location           = $row.Location
                resource_group_name = $resourceGroups[$row.ParentKey].name
            }
        }


        "PublicIP" {

            $publicIPs[$row.Key] = @{
                name               = $row.Name
                location           = $row.Location
                resource_group_name = $resourceGroups[$row.ParentKey].name
                allocation_method  = $row.AllocationMethod
                sku                = $row.SKU
            }
        }


        "NetworkInterface" {

            $networkInterfaces[$row.Key] = @{
                name                  = $row.Name
                location              = $row.Location
                resource_group_name    = $resourceGroups[$row.ParentKey].name
                subnet_key            = $row.SubnetKey
                public_ip_key         = $row.PublicIPKey
                asg_key               = $row.ASGKey
                nsg_key               = $row.NSGKey
                private_ip_allocation = $row.PrivateIPAllocation
            }
        }
    }
}


$terraformInput = @{

    resource_groups = $resourceGroups

    virtual_networks = $virtualNetworks

    subnets = $subnets

    network_security_groups = $networkSecurityGroups

    network_security_rules = $networkSecurityRules

    application_security_groups = $applicationSecurityGroups

    public_ips = $publicIPs

    network_interfaces = $networkInterfaces
}


$terraformInput |
    ConvertTo-Json -Depth 10 |
    Set-Content $outputPath
    

Write-Host ""
Write-Host "Terraform tfvars generated:"
Write-Host $outputPath