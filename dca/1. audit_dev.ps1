Write-Host -ForegroundColor Green "Auditing Development Nodes"

Foreach ($node in @("dev1","dev2")) {
  knife node run_list add $node '''recipe[dca_baseline]'''
}

Write-Host -ForegroundColor Green "Converging Development Nodes"
knife ssh 'chef_environment:development' 'sudo chef-client'

