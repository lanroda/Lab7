<#
    PowerShell Lab 7
    Manipulate users, OUs, group, and group membership
    Date: Apr 13, 2020
    Created by: Rodman Landi
#>

Clear-Host

$menu = @"
`tA. VIEW one OU `t`t`t B. VIEW all OUs
`tC. VIEW one group `t`t D. VIEW all groups
`tE. VIEW one user `t`t F. VIEW all users `n
`tG. CREATE one OU `t`t H. CREATE one group
`tI. CREATE one user `t`t J. CREATE users from CSV file `n
`tK. Add user to group `t L. Remove user from group `n
`tM. DELETE one group `t N. DELETE one user `n
`tEnter Anything other than A - N to quit `n
"@
$menu

$choose = ""
do {
    $choose = Read-Host "Choose from the following Menu Items"
    $menu
    if ($choose -eq "A") {
        $OUname = Read-Host "OU Name"
        Get-ADOrganizationalUnit -Filter $($OUname) | Format-Table -Property Name, DistinguishedName
        Read-Host "Press Enter to Continue . . ."
    } elseif ($choose -eq "B") {
        Get-ADGroup -Filter * | Format-Table -Property Name, DistinguishedName
        Read-Host "Press Enter to Continue . . ."
    } elseif ($choose -eq "C") {
        $Groupname = Read-Host "Group Name"
        Get-ADGroup -Filter $($Groupname) | Format-Table -Property Name, GroupScope, GroupCategory
        Read-Host "Press Enter to Continue . . ."
    } elseif ($choose -eq "D") {
        Get-ADGroup -Filter * | Format-Table -Property Name, GroupScope, GroupCategory
        Read-Host "Press Enter to Continue . . ."
    } elseif ($choose -eq "E") {
        $Username = Read-Host "User's Name"
        Get-ADUser -Filter $($Username) | Format-Table -Property Name, DistinguishedName
        Read-Host "Press Enter to Continue . . ."
    } elseif ($choose -eq "F") {
        Get-ADUser -Filter * | Format-Table -Property Name, DistinguishedName, FirstName, LastName
        Read-Host "Press Enter to Continue . . ."
    } elseif ($choose -eq "G") {
        $createOU = Read-Host "OU name to create"
        New-ADOrganizationalUnit -Name $($createOU)
        Get-ADOrganizationalUnit -Filter $($createOU) | Format-Table -Property Name, DistinguishedName
        Read-Host "Press Enter to Continue . . ."
    } elseif ($choose -eq "H") {
        $creategroup = Read-Host "Group name to create"
        New-ADGroup -Name $($creategroup) -GroupScope Global -GroupCategory Security
        Get-ADGroup -Filter $($creategroup) | Format-Table -Property Name, GroupScope, GroupCategory
        Read-Host "Press Enter to Continue . . ."
    } elseif ($choose -eq "I") {
        $createuser = Read-Host "User name to create"
        $first = Read-Host "First name"
        $last = Read-Host "Last name"
        $address = Read-Host "Address"
        $city = Read-Host "City name"
        $state = Read-Host "State name"
        $zip = Read-Host "Zip Code"
        $company = Read-Host "Company name"
        $division = Read-Host "Listed division"
        New-ADUser -Name $($first, $last) -Enabled -UserPrincipalName $($createuser) -SamAccountName $($createuser) -StreetAddress $($address) -City $($city) -State $($state) -Company $($company) -Division $($division) -PostalCode $($zip)
        Get-ADUser -Name $($createuser) | Format-Table -Property Name, SAMAccountName, UserPrincipalName, FirstName, LastName, City, State, PostalCode, Company, Division
        Read-Host "Press Enter to Continue . . ."
    } elseif ($choose -eq "J") {
        
        Read-Host "Press Enter to Continue . . ."
    } elseif ($choose -eq "K") {
        $groupgain = Read-Host "Group name"
        $user = Read-Host "User name that will be added"
        Add-ADGroupMember -Identity $($groupgain) -Members $($user)
        Get-ADGroupMember -Filter * | Format-Table -Property SAMAccountName, DistinguishedName
        Read-Host "Press Enter to Continue . . ."
    } elseif ($choose -eq "L") {
        $grouploss = Read-Host "Group name"
        $userloss = Read-Host "User name that will be added"
        Remove-ADGroupMember -Identity $($grouploss) -Members $($userloss)
        Get-ADGroupMember -Filter * | Format-Table -Property SAMAccountName, DistinguishedName
        Read-Host "Press Enter to Continue . . ."
    } elseif ($choose -eq "M") {
        $groupremove = Read-Host "Group name to delete"
        Remove-ADGroup -Identity $($groupremove)
        Get-ADGroup -Filter * | Format-Table -Property Name, GroupScope, GroupCategory
        Read-Host "Press Enter to Continue . . ."
    } elseif ($choose -eq "N") {
        $userremove = Read-Host "User name to delete"
        Remove-ADUser -Identity $($Userremove)
        Get-ADUser -Filter * | Format-Table -Property Name, DistinguishedName
        Read-Host "Press Enter to Continue . . ."
    } else {
    Stop-Process -Id $PID
    }

} until ($choose -eq "") {}