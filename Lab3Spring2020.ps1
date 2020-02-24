<#

Purpose: 3rd PowerShell lab. Practices use of:
            Here-Strings
            Pipting commands
            Writing and Reading files
            Conditional logic

Author: Rodman Landi
File: Lab3Spring2020.ps1
Date: February 20, 2020

#>

cls
Set-Location $env:USERPROFILE

Get-ChildItem -Filter *.txt -Path $env:USERPROFILE | Format-Table -Property Name, Length

$menu = @"
What do you want to do?
    1. Write a contract entry to a file
    2. Display all files last written to after a given date
    3. Read a specified text file

"@
$menu
$choice = Read-Host "Enter 1, 2, or 3"



if ($choice -eq 1) {

    $name = Read-Host "Please enter full name"
    $phone = Read-Host "Please enter phone number"
    $email = Read-Host "Please enter email address"
    $file = Read-Host "Please enter name for file"

    Add-Content -Path .\$file.txt -Value $name,$phone,$email, `n

    notepad $file

}
elseif ($choice -eq 2) {
    $lastwrite = Read-Host "Earliest date of files/folders to display"
     
    Get-ChildItem -Recurse | Where-Object {$_.LastWriteTime -ge "$lastwrite"} | Format-Table -Property Name, LastWriteTime

}
elseif ($choice -eq 3) {
    $read = Read-Host "Please enter name of file"
    $test = Test-Path $read
    if ($test -eq $True) {
        Get-Content $read
    }
    else {
        Write-Output "File does not exist"
    }
}
else {
    Write-Output "You have enter a invalid choice on computer $env:ComputerName logged on as $env:UserName"
}