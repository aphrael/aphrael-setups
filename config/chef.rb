set :application,     "AphraelServer"

run_list :router, ['role[bootstrap]', 'recipe[docker]', 'recipe[virtualbox]']
