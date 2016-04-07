# Alice's over-engineered z-shell configuration, released in the public domain.
# Shell builtin, file, and process management aliases.

[[ -o interactive ]] || return

# I like some of my commands to act consistently across platforms.
if [[ $OSTYPE == darwin* ]]; then
	alias d='du -h -d 1'
	alias grep='grep --colour'
	alias ls='ls -G'
	
	# These are distinctly Mac.
	alias lock='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'
	
	# This should only be aliased if running locally (!ssh) and when not wrapped in screen/tmux.
	[[ $TTY == /dev/tty([sS]|)<-> ]] && alias clear="osascript -e 'tell application \"System Events\" to keystroke \"k\" using command down'"
else
	alias d='du --total -h --max-depth=1'
	alias ls='ls --color=auto'
fi

# This next line permits alias expansion of the first argument after each command.
alias sudo="sudo "

# Disable globbing for these commands as they perform their own.
alias find='noglob find'

# Various very short aliases.
alias pt='ptipython'
alias bpy='bpython'
alias ipy='ipython'
alias l.='ls -A'
alias l='ls'
alias ll.='ls -al'
alias ll='ls -l'
alias lsd='ls -ld *(-/DN)'
alias pipi='pip install'
alias pipu='pip install -U'
alias po='popd'
alias pu='pushd'
alias py='python'
alias u='uptime'
alias v='less'
alias screens='screen -ls'
alias wipe='screen -wipe'
alias act='. bin/activate; cd src'

# Fix common mistakes.
alias cd.='cd .'
alias cd/='cd /'

# Process management.
alias p='ps ax'

