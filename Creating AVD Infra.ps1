# Defining a variable for The Resourse Group
$Resourcegroup = "AVD_RG"
$Location = "East US"
$Network = "AVD_Network"
$Address_Prefix = "10.0.0.0/16"
$SubnetA="AVD_A"
$SubnetA_prefix="10.0.0.0/24"
$SubnetB="AVD_B"
$SubnetB_prefix = "10.0.1.0/24"
$SubA = New-AzVirtualNetworkSubnetConfig -Name $SubnetA -AddressPrefix $SubnetA_prefix
$SubB = New-AzVirtualNetworkSubnetConfig -Name $SubnetB -AddressPrefix $SubnetB_prefix
$Hostpool = "AVDHOSTPOOL"
$workspace ='AVDWORKSPACE'
$appgrpname ='AVDAPPGROUP'

#Creating Resourse Group
New-AzResourceGroup -Name $Resourcegroup -Location $Location
#Creating vNet in Resource Group and adding subnet
New-AzVirtualNetwork -Name $Network -ResourceGroupName $Resourcegroup -Location $Location -AddressPrefix $Address_Prefix -Subnet $SubA,$SubB

New-AzWvdHostPool -ResourceGroupName $Resourcegroup -Name $Hostpool -WorkspaceName $workspace -HostPoolType 'Pooled' -LoadBalancerType 'BreadthFirst' -Location $Location -DesktopAppGroupName $appgrpname -PreferredAppGroupType 'Desktop'