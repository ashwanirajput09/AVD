# Get-AzWvdRegistrationInfo
# Above COmmand is used when we add vm to Desktop Pool by Azure Desktop Agent.

$username = 'azureuser' 
$password = ConvertTo-SecureString 'Demo@123' -AsPlainText -Force
$AzVMWindowsCredentials = New-Object System.Management.Automation.PSCredential ($username, $password)
#Creating a Vm
New-AzVM 
    -ResourceGroupName 'AVD_RG' 
    -Name 'avddemovm' 
    -Image 'Win2019Datacenter' 
    -Credential $AzVMWindowsCredentials 
    -OpenPorts 3389
#Creating a Public Network

    Get-AzPublicIpAddress 
    -ResourceGroupName 'AVD_RG'                  
    -Name 'avddemovm' | Select-Object IpAddress

#Run the following cmdlet to sign in to the Azure Virtual Desktop environment:

New-AzWvdHostPool -ResourceGroupName <resourcegroupname> -Name <hostpoolname> -WorkspaceName <workspacename> -HostPoolType <Pooled|Personal> -LoadBalancerType <BreadthFirst|DepthFirst|Persistent> -Location <region> -DesktopAppGroupName <appgroupname> -PreferredAppGroupType <appgrouptype>


#Run the next cmdlet to create a registration token to authorize a session host to join the host pool and save it to a new file on your local computer. You can specify how long the registration token is valid by using the -ExpirationTime parameter.
    
New-AzWvdRegistrationInfo -ResourceGroupName <resourcegroupname> -HostPoolName <hostpoolname> -ExpirationTime $((get-date).ToUniversalTime().AddDays(1).ToString('yyyy-MM-ddTHH:mm:ss.fffffffZ'))


#For example, if you want to create a token that expires in two hours, run this cmdlet:

New-AzWvdRegistrationInfo -ResourceGroupName <resourcegroupname> -HostPoolName <hostpoolname> -ExpirationTime $((get-date).ToUniversalTime().AddHours(2).ToString('yyyy-MM-ddTHH:mm:ss.fffffffZ'))

# run this cmdlet to add Azure Active Directory users to the default desktop app group for the host pool.

New-AzRoleAssignment -SignInName <userupn> -RoleDefinitionName "Desktop Virtualization User" -ResourceName <hostpoolname+"-DAG"> -ResourceGroupName <resourcegroupname> -ResourceType 'Microsoft.DesktopVirtualization/applicationGroups'

#Run this next cmdlet to add Azure Active Directory user groups to the default desktop app group for the host pool:

New-AzRoleAssignment -ObjectId <usergroupobjectid> -RoleDefinitionName "Desktop Virtualization User" -ResourceName <hostpoolname+"-DAG"> -ResourceGroupName <resourcegroupname> -ResourceType 'Microsoft.DesktopVirtualization/applicationGroups'

#Run the following cmdlet to export the registration token to a variable, which you will use later in Register the virtual machines to the Azure Virtual Desktop host pool.

$token = Get-AzWvdRegistrationInfo -ResourceGroupName <resourcegroupname> -HostPoolName <hostpoolname>

