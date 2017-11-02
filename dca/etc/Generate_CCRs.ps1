while($true) {
  Write-Host -ForegroundColor Yellow "Generating client converges, feel free to close with CTRL+C."
  knife job start chef-client -s *:*; sleep $(Get-Random -Maximum 240 -Minimum 60)
}
