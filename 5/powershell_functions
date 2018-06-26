function DCA-Bootstrap-SSH {
  param (
    $name,
    $env,
    $cookbook,
    $recipe
  )
  Write-Output "Bootstrapping host $name into $env with recipe $cookbook::$recipe"
  knife bootstrap $name -N $name -E $env -r "'''recipe[$cookbook::$recipe]'''" -i ~/.ssh/id_rsa -x ubuntu --sudo -y

  Write-Output "Bootstrap Complete!"
  Write-Output "Command: knife bootstrap $name -N $name -E $env -r `"'''recipe[$cookbook::$recipe]'''`" -i ~/.ssh/id_rsa -x ubuntu --sudo -y"
}

function DCA-Nuke-Automate {
  Write-Output "TERMINATING..."
  ssh automate "sudo curl -X DELETE 'http://localhost:9200/_all' && sudo automate-ctl reconfigure"
}

function DCA-AWS-Create {
  param (
    $env,
    $cookbook,
    $recipe
  )
  Write-Output "Running knife-ec2 to bootstrap node in $env"
  knife ec2 server create -r "'''recipe[$cookbook::$recipe]'''" -f m4.large -E $env -S chef_demo_2x --image ami-70b67d10 --security-group-id sg-1cea9178 -T instance-type=DCA-kitchen-ec2 -i ~/.ssh/id_rsa --user-data C:\Users\chef\ubuntu_user_data -x ubuntu --use-iam-profile
  Write-Output "Create Complete!"
  Write-Output "Command: knife ec2 server create -r `"'''recipe[$cookbook::$recipe]'''`" -f m4.large -E $env -S chef_demo_2x --image ami-70b67d10 --security-group-ids sg-1cea9178 -T instance-type=DCA-kitchen-ec2 -i ~/.ssh/id_rsa --user-data C:\Users\chef\ubuntu_user_data -x ubuntu --use-iam-profile"
}

function DCA-Azure-Create {
  param (
    $env,
    $cookbook,
    $recipe,
    $name
  )
  Write-Output "Running knife-azurerm to bootstrap node in $env"
  knife azurerm server create -r "'''recipe[$cookbook::$recipe]'''" -E azuredev --azure-resource-group-name cm_azure_demo --azure-vm-name $name.Substring(0,9).ToLower() --azure-service-location 'westus' --azure-image-os-type ubuntu --azure-image-reference-sku '14.04.2-LTS' --ssh-user ubuntu --ssh-password C0d3C@n! --azure-vm-size Small --no-node-verify-api-cert --node-ssl-verify-mode none -c /Users/chef/knife.rb
  Write-Output "Create Complete!"
  Write-Output "Command: knife azurerm server create -r "'''recipe[$cookbook::$recipe]'''" -E azuredev --azure-resource-group-name cm_azure_demo --azure-vm-name $name.Substring(0,9).ToLower() --azure-service-location 'westus' --azure-image-os-type ubuntu --azure-image-reference-sku '14.04.2-LTS' --ssh-user ubuntu --ssh-password C0d3C@n! --azure-vm-size Small --no-node-verify-api-cert --node-ssl-verify-mode none -c /Users/chef/knife.rb"
}

function Update-RunLists {
    param (
        $env,
        $cookbook,
        $recipe
    )
    Write-Output "Adding the $cookbook::$recipe to nodes in $env"
    foreach( $node in ` knife node list -E $env ` ) {
    knife node run_list add $node "'''recipe[$cookbook::$recipe]'''"
    }
  Write-Output "Run Lists Updated!"
  Write-Output "Command: knife node run_list add NODE_NAME `"'''recipe[$cookbook::$recipe]'''`""
}

function Invoke-ChefClient {
    param($env)

    Write-Output "Running Chef-Client on all nodes in $env"
    knife ssh "chef_environment:$env" 'sudo chef-client'

    Write-Output "CCRs Complete!"
    Write-Output "Command: knife ssh `"chef_environment:$env`" 'sudo chef-client'"

}

function DCA-Update-Nodes {
  param(
    $env,
    $cookbook,
    $recipe
  )
  $environment = $env
  if ($env -match "awsdev"){
  } elseif ($env -match "dev"){
    $environment = "development"
  } elseif ($env -match "sta"){
    $environment = "staging"
  } elseif ($env -match "prod"){
    $environment = "production"
  }

  Write-Output "Updating nodes in $environment with $cookbook::$recipe."
  foreach( $node in ` knife node list -E $environment ` ) {
    knife node run_list add $node "'''recipe[$cookbook::$recipe]'''"
  }
  Write-Output "Converging nodes in the $environment environment"
  knife ssh "chef_environment:$environment" 'sudo chef-client'

  Write-Output "Updates Complete!"
  Write-Output "Command1: knife node run_list add NODE_NAME `"'''recipe[$cookbook::$recipe]'''`""
  Write-Output "Command2: knife ssh `"chef_environment:$env`" 'sudo chef-client'"
}

function DCA-Apply-Role {
  param(
    $role
  )

  Write-Output "Updating nodes with $role role."
  foreach( $node in ` knife node list ` ) {
    knife node run_list add $node "'''role[$role]'''"
  }
  Write-Output "Converging all nodes"
  knife ssh "*:*" 'sudo chef-client'

  Write-Output "Updates Complete!"
  Write-Output "Command1: knife node run_list add NODE_NAME `"'''role[$role]'''`""
  Write-Output "Command2: knife ssh `"*:*`" 'sudo chef-client'"
}
