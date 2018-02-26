$env=$args[0]
$recipe=$args[1]

foreach( $node in ` knife node list -E $env ` ) {
  knife node run_list add $node "'''$recipe'''"
}
