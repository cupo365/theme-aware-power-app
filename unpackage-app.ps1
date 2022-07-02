[cmdletbinding()]
Param([parameter(Mandatory = $true, ValueFromPipeline = $true)] [ValidateNotNullOrEmpty()] [string] $PackageName,
    [parameter(Mandatory = $true, ValueFromPipeline = $true)] [ValidateNotNullOrEmpty()] [ValidateSet("phone", "tablet")] [string] $AppType)

Try {
    $ProjectSrc = $MyInvocation.MyCommand.Path.replace("\$($MyInvocation.MyCommand.Name)", "")

    Write-Host "Unpackaging the app from 'release\$($PackageName).msapp' to 'src\$($AppType)'" -Foreground Cyan

    $DefaultUIColor = $host.ui.RawUI.ForegroundColor
    $host.ui.RawUI.ForegroundColor = "Magenta"

    pasopa -unpack "$($ProjectSrc)\release\$($PackageName).msapp" "$($ProjectSrc)\src\$($AppType)" | Out-Null
  
    $host.ui.RawUI.ForegroundColor = $DefaultUIColor

    Write-Host "Done." -Foreground Cyan
}
Catch [Exception] {
    Write-Host "`nAn error occurred: $($_.Exception.Message)" -Foreground Red
}
