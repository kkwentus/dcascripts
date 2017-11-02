Write-Host -ForegroundColor Green "Hardening Non-Development Nodes"

Foreach ($node in @("stage1","stage2","prod1","prod2","prod3"))
{
  knife node run_list add $node '''recipe[dca_baseline::hardening]'''
}

Write-Host -ForegroundColor Green "Converging Non-Development Nodes"
knife ssh "NOT chef_environment:development" 'sudo chef-client'