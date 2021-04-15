$results = @()
$groups = Get-AzureADGroup -All $true | where {( $_.SecurityEnabled -eq $True) -and ($_.Mail -eq $null)}

foreach ($group in @$groups)

{
    #Write-Host "$($group.DisplayName)'n"
    $members = Get-AzureADGroupMember -ObjectId "$($group.ObjectId)"

    foreach ($member in $members) {
        $results += (New-Object -Typename PSObject -Property @{
            GroupName = $group.DisplayName; groupDescription = $group.Description;
            MemberType = $member.ObjectType; DisplayName = $member.DisplayName;
        } )
    }
}
$results | export-csv -Path $env:USERPROFILE\Desktop\report.csv -NoTypeInformation