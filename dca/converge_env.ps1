$env=$args[0]

knife ssh "chef_environment:$env" 'sudo chef-client'
