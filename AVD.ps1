# Defining a variable for The Resourse Group
$Resourcegroup = "Test_RG"
$Location = "East US"
$Network = "Test_Network"
$Hostpool = 'Myhostpool'
$Workspace = "Myworkspace"
$Address_Prefix = "10.0.0.0/16"
$SubnetA="Subnet_A"
$SubnetA_prefix="10.0.0.0/24"
$SubnetB="Subnet_B"
$SubnetB_prefix = "10.0.1.0/24"
$SubA = New-AzVirtualNetworkSubnetConfig -Name $SubnetA -AddressPrefix $SubnetA_prefix
$SubB = New-AzVirtualNetworkSubnetConfig -Name $SubnetB -AddressPrefix $SubnetB_prefix
#Creating Resourse Group
New-AzResourceGroup -Name $Resourcegroup -Location $Location
#Creating vNet in Resource Group and adding subnet
New-AzVirtualNetwork -Name $Network -ResourceGroupName $Resourcegroup -Location $Location -AddressPrefix $Address_Prefix -Subnet $SubA,$SubB
#Creating Workspace
New-AzWvdWorkspace -Name $Workspace -ResourceGroupName $Resourcegroup -Location $Location
#Creating Hostpool
New-AzWvdHostPool -Name $Hostpool -Location $Location -ResourceGroupName $Resourcegroup -PreferredAppGroupType 'Desktop' -HostPoolType 'Pooled' -LoadBalancerType 'BreadthFirst' -MaxSessionLimit '5' -PersonalDesktopAssignmentType 'Automatic'