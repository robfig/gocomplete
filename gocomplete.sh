#!/bin/sh
#
# Bash completion script for the go commandline tool.  Presently it activates
# to show packages under $GOPATH on these subcommands:
# - go install
# - go build
# - go test
#
# Install by sourcing this file from your .bash_profile, or copy it in.
#
# Author: Rob Figueiredo (robfig@gmail.com)

function _gocomplete() {
	subcmd="${COMP_WORDS[1]}"
	case $subcmd in
		build|install|test)
			COMPREPLY=($(cd $GOPATH/src && ls -d $2*/ 2>/dev/null | sed 's#/$##g'))
			if [[ ${#COMPREPLY[@]} == 1 ]]; then
				COMPREPLY=($(cd $GOPATH/src && ls -d ${COMPREPLY[0]}/*/ 2>/dev/null | sed 's#/$##g'))
			fi
			return 0
			;;
	esac
	return 1
}

complete -o default -o nospace -F _gocomplete go
