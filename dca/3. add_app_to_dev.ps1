Write-Host -ForegroundColor Green "Adding Application Recipe to Development Nodes."

Foreach ($node in @("dev1","dev2"))
{
  knife node run_list add $node '''recipe[dca_baseline::install_site]'''
}

Write-Host -ForegroundColor Green "Converging Development Nodes"
knife ssh "*:*" 'sudo chef-client'