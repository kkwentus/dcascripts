Write-Host -ForegroundColor Green "Adding Application Recipe to Non-Development Nodes."

Foreach ($node in @("stage1","stage2","prod1","prod2","prod3"))
{
  knife node run_list add $node '''recipe[dca_baseline::install_site]'''
}

Write-Host -ForegroundColor Green "Converging Non-Development Nodes"
knife ssh "*:*" 'sudo chef-client'