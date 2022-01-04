#Build LDAP Filter to look for users with service account naming conventions
$ldapFilter = "(&(objectclass=Person)(cn=*svc*))"
#use the next ldapfilter for 'password never expire'
#$ldapFilter ="(&(objectclass=user)(objectcategory=user)(useraccountcontrol:1.2.840.113556.1.4.803:=65536))"
$domain = New-Object System.DirectoryServices.DirectoryEntry
$search = New-Object System.DirectoryServices.DirectorySearcher
$search.SearchRoot = $domain
$search.PageSize = 1000
$search.Filter = $ldapFilter
$search.SearchScope = "Subtree"

#Adds list of properties to search for
$objProperties = "name"
Foreach ($i in $objProperties){$search.PropertiesToLoad.Add($i)}

#Execute Search
$results = $search.FindAll()
#Display values from the returned objects
foreach ($result in $results)
{
    $userEntry = $result.GetDirectoryEntry()
    Write-Host "User Name = " $userEntry.name
    Write-Host ""    
}