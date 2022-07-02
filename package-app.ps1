[cmdletbinding()]
Param([parameter(Mandatory = $true, ValueFromPipeline = $true)] [ValidateNotNullOrEmpty()] [string] $PackageName,
    [parameter(Mandatory = $true, ValueFromPipeline = $true)] [ValidateNotNullOrEmpty()] [ValidateSet("phone", "tablet")] [string] $AppType)

Try {
    $ProjectSrc = $MyInvocation.MyCommand.Path.replace("\$($MyInvocation.MyCommand.Name)", "")

    Write-Host "Packaging the app from 'src\$($AppType)' to 'release\$($PackageName).msapp'" -Foreground Cyan

    $DefaultUIColor = $host.ui.RawUI.ForegroundColor
    $host.ui.RawUI.ForegroundColor = "Magenta"

    pasopa -pack "$($ProjectSrc)\release\$($PackageName).msapp" "$($ProjectSrc)\src\$($AppType)" | Out-Null
  
    $host.ui.RawUI.ForegroundColor = $DefaultUIColor

    Write-Host "Done." -Foreground Cyan
}
Catch [Exception] {
    Write-Host "`nAn error occurred: $($_.Exception.Message)" -Foreground Red
}
