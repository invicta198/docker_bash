#!/bin/bash

function delete_cache(){
	echo 'Deleting __pycache__ !...'
	cd $1
	command=`rm -rf $(find $2 -name __pycache__) 2>&1 `
	cd -
}
function common_pull(){
	echo 'Pulling Common repo !...'
	repo=touchstone-common
	delete_cache $repo touchstone_common
	cd $repo
	github_pull
	source ~/voereir/code/ts-venv/bin/activate
	cd touchstone-common/touchstone_common/db/migration
	command=`alembic downgrade -1 2>&1 `
	command=`alembic upgrade +1 2>&1 `
	cd -
	deactivate
}
function agent_pull(){
	echo 'Pulling Agent repo !...'
	repo=touchstone-agent-webservice
	delete_cache $repo .
	cd $repo
	github_pull
	source touchstone-agent-webservice/server/venv3/bin/activate
	deactivate
}
function package_pull(){
	echo 'Pulling Package repo !...'
	repo=touchstone-package
	delete_cache $repo .
	cd $repo
	github_pull
}
function api_pull(){
	echo 'Pulling Api repo !...'
	repo=touchstone-api
	delete_cache $repo touchstoneApi
	cd $repo
	github_pull	
}
function doc_pull(){
	echo 'Pulling Doc repo !...'
	repo=touchstone-doc
	delete_cache $repo .
	cd $repo
	github_pull
}
function web_pull(){
	echo 'Pulling Web repo !...'
	repo=touchstone-web
	delete_cache $repo .
	cd $repo
	github_pull
	command=`bash touchstone-web/webpack/pack-webpack.cmd 2>&1 `
}
function cli_pull(){
	echo 'Pulling CLI repo !...'
	repo=touchstone-CLI
	delete_cache $repo touchstone_cli
	cd $repo
	github_pull
}
function externals_pull(){
	echo 'Pulling Externals repo !...'
	repo=touchstone-externals
	delete_cache $repo touchstone
	cd $repo
	github_pull
}
function management_pull(){
	echo 'Pulling Management repo !...'
	repo=touchstone-management-portal
	delete_cache $repo touchstone_management_portal
	cd $repo
	github_pull
	source ~/voereir/code/ts-venv/bin/activate
	cd touchstone-management-portal/touchstone_management_portal/common/db/migration
	command=`alembic downgrade -1 2>&1 `
	command=`alembic upgrade +1 2>&1 `
	cd -
	deactivate
}
function engine_pull(){
	echo 'Pulling Engine repo !...'
	repo=touchstone-engine
	delete_cache $repo ve_engines
	cd $repo
	github_pull
}
function github_pull(){
	command=`git checkout master 2>&1 `
	if [[ $command == *'Please commit your changes or stash them before you switch branches.'* ]]; then
  		user_git_branch=`git rev-parse --abbrev-ref HEAD 2>&1 ` #Git 1.6.3 or newer.
  		echo 'You are on branch: '$user_git_branch
  		echo 'Press Y: stash and apply || Press N: stash and drop'
  		read user_option
  		command=`git stash 2>&1 `
  		command=`git checkout master 2>&1 `
  		command=`git pull 2>&1 `
  		command=`git checkout $user_git_branch 2>&1 `
  		if [ "$user_option" = "Y" ] || [ "$user_option" = "y" ]; then
  			command=`git stash apply 2>&1 `
  		elif [ "$user_option" = "N" ] || [ "$user_option" = "n" ]; then
  			command=`git stash drop 2>&1 `
  		else
  			command=`exit 1 2>&1 `
  		fi 
	else
		command=`git pull 2>&1 `
		echo '############## Success !!......'
	fi
	cd -
}

cd ~/voereir/code
agent_pull
api_pull
cli_pull
common_pull
doc_pull
engine_pull
externals_pull
management_pull
package_pull
web_pull
