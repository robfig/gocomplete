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
			COMPREPLY=($(cd $GOPATH/src && ls -d $2*/ 2>/dev/null))
			return 0
			;;
	esac
	return 1
}

# -o default falls back to default matching if we found nothing
# -o nospace strips trailing space from the completion
complete -o default -o nospace -F _gocomplete go
