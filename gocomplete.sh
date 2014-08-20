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
	# Expect the second word to be the go sub-command.
	subcmd="${COMP_WORDS[1]}"
	case $subcmd in
		build|install|test)
			# List directories with ls -d $input*/ , while ignoring stderr output
			# Strip trailing slashes from the directory names
			COMPREPLY=($(cd $GOPATH/src && ls -d $2*/ 2>/dev/null | sed 's#/$##g'))
			
			# If there is only match, jump right into the completions for that one.
			if [[ ${#COMPREPLY[@]} == 1 ]]; then
				COMPREPLY=($(cd $GOPATH/src && ls -d ${COMPREPLY[0]}/*/ 2>/dev/null | sed 's#/$##g'))
			fi
			return 0
			;;
	esac
	return 1
}

# -o default falls back to default matching if we found nothing
# -o nospace strips trailing space from the completion
complete -o default -o nospace -F _gocomplete go
