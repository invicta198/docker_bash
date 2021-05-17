#!/bin/bash

function common_pull(){
	echo 'Pulling Common repo !...'
	cd touchstone-common
	github_pull
}
function agent_pull(){
	echo 'Pulling Agent repo !...'
	cd touchstone-agent-webservice
	github_pull
}
function package_pull(){
	echo 'Pulling Package repo !...'
	cd touchstone-package
	github_pull
}
function api_pull(){
	echo 'Pulling Api repo !...'
	cd touchstone-api
	github_pull
}
function doc_pull(){
	echo 'Pulling Doc repo !...'
	cd touchstone-doc
	github_pull
}
function web_pull(){
	echo 'Pulling Web repo !...'
	cd touchstone-web
	github_pull
}
function cli_pull(){
	echo 'Pulling CLI repo !...'
	cd touchstone-CLI
	github_pull
}
function externals_pull(){
	echo 'Pulling Externals repo !...'
	cd touchstone-externals
	github_pull
}
function management_pull(){
	echo 'Pulling Management repo !...'
	cd touchstone-management-portal
	github_pull
}
function engine_pull(){
	echo 'Pulling Engine repo !...'
	cd touchstone-engine
	github_pull
}
function github_pull(){
	output=`git checkout master 2>&1 `
	#echo $output
	if [[ $output == *'Please commit your changes or stash them before you switch branches.'* ]]; then
  		output_second='git branch 2>&1 '
  		echo $output_second
	else
		echo '############## Success !!......'
	fi
	#git pull
	# while read -r line; do
	# 	echo $line
	# done <<< "$output"
	#echo '############## Success !!......'
	cd -
}
function check(){
	#output=$(git status)
	errormessage=`git status -n -v hfsplus 2>&1 `
	#echo $errormessage
	# while read -r line; do
	# 	echo "###########"
 	#   echo "$line"
	# done <<< "$output"
}

cd ~/voereir/code
#agent_pull
#api_pull
#cli_pull
#common_pull
#doc_pull
engine_pull
#externals_pull
#management_pull
#package_pull
#web_pull
#check