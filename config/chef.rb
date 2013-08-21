set :application,     "AphraelServer"

run_list :router, [
  'role[bootstrap]',
  'recipe[nginx::source]',
  'recipe[docker]',
  'recipe[virtualbox]'
]
