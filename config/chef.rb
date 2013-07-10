set :application,     "AphraelServer"

run_list :router, ['role[bootstrap]']
