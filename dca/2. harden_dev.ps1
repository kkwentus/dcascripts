Write-Host -ForegroundColor Green "Hardening Development Nodes"

Foreach ($node in @("dev1","dev2"))
{
  knife node run_list add $node '''recipe[dca_baseline::hardening]'''
}

Write-Host -ForegroundColor Green "Converging Development Nodes"
knife ssh 'chef_environment:development' 'sudo chef-client'