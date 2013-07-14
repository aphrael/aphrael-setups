set :application,     "AphraelServer"

run_list :router, [
  'role[bootstrap]',
  'recipe[nats]',
  'recipe[nise_bosh::deploy]',
  'recipe[docker]',
  'recipe[virtualbox]'
]
