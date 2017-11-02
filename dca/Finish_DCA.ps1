Write-Host -ForegroundColor Green "[1/4] Adding remediation recipe to all machines"

cd ~
Foreach ($node in @("stage1","stage2","prod1","prod2","prod3"))
{
  knife node run_list add $node '''recipe[dca_baseline::hardening]'''
}

Write-Host -ForegroundColor Green "[2/4] Converge all nodes"

knife ssh '*:*' 'sudo chef-client'

Write-Host -ForegroundColor Green "[3/4] Add application recipe to all machines."

cd ~
Foreach ($node in @("dev1","dev2","stage1","stage2","prod1","prod2","prod3"))
{
  knife node run_list add $node '''recipe[dca_baseline::install_site]'''
}

Write-Host -ForegroundColor Green "[4/4] Opening final e-mail"

# Uncomment to open e-mails
# & ${env:userprofile}\dca\DCA_email_wk3.html

Write-host -ForegroundColor White "All done!"
Read-Host -Prompt "Press Enter to exit"
