bindkey -v  ## vi key bindings

## get keys working
case $TERM in 
    linux)
#   bindkey "^[[2~" yank
   bindkey "^[[3~" delete-char
    bindkey "^[[5~" up-line-or-history ## PageUp
    bindkey "^[[6~" down-line-or-history ## PageDown
    bindkey "^[[7~" beginning-of-line
    bindkey "^[[8~" end-of-line
    bindkey "^[[1~" beginning-of-line
    bindkey "^[[4~" end-of-line
    bindkey "^e" expand-cmd-path ## C-e for expanding path of typed command
    bindkey "^A" beginning-of-line
    bindkey "^L" end-of-line
    bindkey "^W" backward-kill-word
    bindkey "^K" kill-line
    bindkey "^E" expand-cmd-path ## C-e for expanding path of typed command
    bindkey "^[[A" history-search-backward ## up arrow for back-history-search
    bindkey "^[[B" history-search-forward ## down arrow for fwd-history-search
    bindkey " " magic-space ## do history expansion on space
    bindkey "^R" history-incremental-search-backward
    bindkey "^Xr" history-incremental-search-backward
;;
    *xterm*|mrxvt|rxvt|rxvt-unicode|(dt|k|a|E)term|screen)
#   bindkey "^[[2~" yank
#   bindkey "^[[3~" delete-char
    bindkey "^[[5~" up-line-or-history ## PageUp
    bindkey "^[[6~" down-line-or-history ## PageDown
    bindkey "^[[7~" beginning-of-line
    bindkey "^[[8~" end-of-line
    bindkey "^e" expand-cmd-path ## C-e for expanding path of typed command
    bindkey "^[[A" history-search-backward ## up arrow for back-history-search
    bindkey "^[[B" history-search-forward ## down arrow for fwd-history-search
#   bindkey " " magic-space ## do history expansion on space
    bindkey "^b" backward-word ## go back one word
    bindkey "^f" forward-word ## go forward one word
    bindkey "^R" history-incremental-search-backward
    bindkey "^Xr" history-incremental-search-backward
;;
esac

## use hard limits, except for a smaller stack and no core dumps
unlimit
limit stack 8192
limit core 0
limit -s

## set path and cdpath
## think about setting path,cdpath,manpath & fpath in .zshenv
path=($path /bin /usr/bin )
path=($path /usr/local/bin $HOME/bin $HOME/.python/bin /usr/local/mysql/bin)
#MacOS X specific
if [[ "$VENDOR" == "apple" ]]; then
    path=($path /opt/local/bin)
fi
cdpath=(~ ..) ## on cd command offer dirs in home and one dir up.

## for root add sbin dirs to path
if (( EUID == 0 )); then
    path=($path /sbin /usr/sbin /usr/local/sbin /usr/lib/portage/bin/ /opt/local/sbin/)
fi

## aditional dir to look for function definitions
#fpath=($fpath ~/.zfunc) ## EDIT ## or comment if u don't need it.

## set manpath
manpath=(/usr/local/man /usr/share/man) ## EDIT ##
manpath=($manpath /usr/man /usr/lib/perl5/man) ## EDIT ##
#MacOS X specific
if [[ "$VENDOR" == "apple" ]]; then
    manpath=($manpath /opt/local/share/man) ## EDIT ##
fi

## remove duplicate entries from path,cdpath,manpath & fpath
typeset -gU path cdpath manpath fpath

# by default, we want this to get set.
# Even for non-interactive, non-login shells.
if [ "`id -gn`" = "`id -un`" -a `id -u` -gt 99 ]; then
        umask 002
  else
        umask 022
fi

## The file to save the history in when an interactive shell exits.
## If unset, the history is not saved.
HISTFILE=${HOME}/.zsh_history

## The maximum number of events stored in the internal history list.
HISTSIZE=5000

## The maximum number of history events to save in the history file.
SAVEHIST=4500

## maximum size of the directory stack.
DIRSTACKSIZE=20

## The interval in seconds between checks for login/logout activity
## using the watch parameter.
LOGCHECK=30

## The baud rate of the current connection.  Used by the line editor
## update mechanism to compensate for a slow terminal by delaying
## updates until necessary.
#BAUD=38400 ## to turn off set this to zero

## If nonnegative, commands whose combined user and system execution times
## (measured in seconds) are greater than this value have timing
## statistics printed for them.
REPORTTIME=2

## If set, this gives a string of characters, which can use
## all the same codes as the bindkey command as described in
## section The zsh/zle Module, that will be output to
## the terminal instead of beeping.
## This may have a visible instead of an audible effect;
## for example, the string `\e[?5h\e[?5l' on a vt100 or xterm will have
## the effect of flashing reverse video on and off (if you usually use reverse
## video, you should use the string `\e[?5l\e[?5h' instead).  This takes
## precedence over the NOBEEP option.
#ZBEEP='\e[?5h\e[?5l'

## The directory to search for shell startup files (.zshrc, etc),
## if not $HOME.
#ZDOTDIR=~/.zsh



## (( ${+*} )) = if variable is set don't set it anymore
(( ${+USER} )) || export USER=$USERNAME
(( ${+HOSTNAME} )) || export HOSTNAME=$HOST
(( ${+EDITOR} )) || export EDITOR=`which nano`
(( ${+VISUAL} )) || export VISUAL=`which nano`
(( ${+FCEDIT} )) || export FCEDIT=`which nano`
(( ${+PAGER} )) || export PAGER=`which less`
(( ${+LESSCHARSET} )) || export LESSCHARSET='utf-8' ## charset for pager
(( ${+LESSOPEN} )) || export LESSOPEN='|lesspipe.sh %s'
(( ${+CC} )) || export CC='gcc' ## or egcs or whatever

## variables for BitchX (irc client)
(( ${+IRCNAME} )) || export IRCNAME='Alice Bevan-McGregor'
(( ${+IRCNICK} )) || export IRCNICK='GothAlice' 
(( ${+IRCSERVER} )) || export IRCSERVER='irc.freenode.net' 

## auto logout after timeout in seconds
TMOUT=1800

## if we are in X then disable TMOUT
case $TERM in
    *xterm*|rxvt|(dt|k|E)term)
    unset TMOUT
    ;;
esac


## turn on full featured completion (minimal needs: zsh3.1)
if [[ "$ZSH_VERSION" == (3.1|4)* ]]; then
    autoload -U compinit
    compinit -C
else
    print "Advanced completion system not found; ignoring zstyle settings."
    function zstyle { }
fi

## set colors for GNU ls ; set this to right file
export LS_COLORS='*.swp=00;44;37:*,v=5;34;93:*.vim=35:no=0:fi=0:di=32:ln=36:or=1;40:mi=1;40:pi=31:so=33:bd=44;37:cd=44;37:ex=35:*.jpg=1;32:*.jpeg=1;32:*.JPG=1;32:*.gif=1;32:*.png=1;32:*.jpeg=1;32:*.ppm=1;32:*.pgm=1;32:*.pbm=1;32:*.c=1;32:*.C=1;33:*.h=1;33:*.cc=1;33:*.awk=1;33:*.pl=1;33:*.gz=31:*.tar=31:*.zip=31:*.lha=1;31:*.lzh=1;31:*.arj=1;31:*.bz2=31:*.tgz=31:*.taz=1;31:*.html=36:*.htm=1;34:*.doc=1;34:*.txt=1;34:*.o=1;36:*.a=1;36'


## Color completion
## this module should be automatically loaded if u use menu selection
## but to be sure we do it here
zmodload -i zsh/complist

## This allows incremental completion of a word.
## After starting this command, a list of completion
## choices can be shown after every character you
## type, which you can delete with ^h or DEL.
## RET will accept the completion so far.
## You can hit TAB to do normal completion, ^g to            
## abort back to the state when you started, and ^d to list the matches.
autoload -U incremental-complete-word
zle -N incremental-complete-word
bindkey "^Xi" incremental-complete-word ## C-x-i

## This function allows you type a file pattern,
## and see the results of the expansion at each step.
## When you hit return, they will be inserted into the command line.
autoload -U insert-files
zle -N insert-files
bindkey "^Xf" insert-files ## C-x-f

## This set of functions implements a sort of magic history searching.
## After predict-on, typing characters causes the editor to look backward
## in the history for the first line beginning with what you have typed so
## far.  After predict-off, editing returns to normal for the line found.
## In fact, you often don't even need to use predict-off, because if the
## line doesn't match something in the history, adding a key performs
## standard completion - though editing in the middle is liable to delete
## the rest of the line.
autoload -U predict-on
zle -N predict-on
zle -N predict-off
bindkey "^X^Z" predict-on ## C-x C-z
bindkey "^Z" predict-off ## C-z

## This is a multiple move based on zsh pattern matching.  To get the full
## power of it, you need a postgraduate degree in zsh.
## Read /path_to_zsh_functions/zmv for some basic examples.
autoload -U zmv

# Super-hyper mega brilliant bc
autoload -z zcalc

#autoload -z colors; colors

## watch for my friends
## An array (colon-separated list) of login/logout events to report.
## If it contains the single word `all', then all login/logout events
## are reported.  If it contains the single word `notme', then all
## events are reported as with `all' except $USERNAME.
## An entry in this list may consist of a username,
## an `@' followed by a remote hostname,
## and a `%' followed by a line (tty).
#watch=( $(<~/.friends) )  ## watch for people in $HOME/.friends file
#watch=(notme)  ## watch for everybody but me
#LOGCHECK=60  ## check every ... seconds for login/logout activity

## The format of login/logout reports if the watch parameter is set.
## Default is `%n has %a %l from %m'.
## Recognizes the following escape sequences:
## %n = name of the user that logged in/out.
## %a = observed action, i.e. "logged on" or "logged off".
## %l = line (tty) the user is logged in on.
## %M = full hostname of the remote host.
## %m = hostname up to the first `.'.
## %t or %@ = time, in 12-hour, am/pm format.
## %w = date in `day-dd' format.
## %W = date in `mm/dd/yy' format.
## %D = date in `yy-mm-dd' format.
WATCHFMT='%n %a %l from %m at %t.'

## set prompts ####
#PS1=$'%{\e[1;31m%}%B(%b%{\e[0m%}%n@%m%{\e[1;31m%})%{\e[0m%} : %{\e[1;31m%}(%{\e[0m%}%~%{\e[1;31m%})%{\e[0m%} %# '
#PS1=$'%{\e[0m%}%n@%m%{\e[0m%}%{\e[1;31m%}:%{\e[0m%}%~%{\e[0m%}%#'
#PS1=$'%{\e[0m%}%n@%m%{\e[1;31m%}:%{\e[0m%}%~%#'

if [ "`id -gn`" = "`id -un`" -a `id -u` -gt 99 ]; then
        PS1=$'%n@%m%{\e[1;31m%} %{\e[0m%}%~ $ '
  else
        PS1=$'%{\e[01;32m%}%n@%m%{\e[01;34m%} %~ $ %{\e[00m%}'
fi

RPROMPT=$'%(?..[ %B%?%b ])'

## or use neat prompt themes included with zsh
#autoload -U promptinit
#promptinit
## Currently available prompt themes:
## adam1 adam2 bart bigfade clint elite2 elite
## fade fire off oliver redhat suse walters zefram
#prompt elite2

## don't ask me 'do you wish to see all XX possibilities' before menu selection
LISTPROMPT=''

## SPROMPT - the spelling prompt
SPROMPT='zsh: correct '%R' to '%r' ? ([Y]es/[N]o/[E]dit/[A]bort) '

## functions for displaying neat stuff in *term title
case $TERM in
    *xterm*|rxvt|(dt|k|E)term)
    ## display user@host and full dir in *term title
    precmd () {
        print -Pn  "\033]0;%~\007"
        #OLD print -Pn  "\033]0;%n@%m %~\007"
        #print -Pn "\033]0;%n@%m%#  %~ %l  %w :: %T\a" ## or use this
        }
    ## display user@host and name of current process in *term title
    preexec () {
        print -Pn "\033]0; $1 %~\007"
        #OLD print -Pn "\033]0;%n@%m <$1> %~\007"
        #print -Pn "\033]0;%n@%m%#  <$1>  %~ %l  %w :: %T\a" ## or use this
        }
    ;;
esac

## aliases ####
alias p='ps -fu $USER'
alias v='less'
alias h='history'
alias z='$EDITOR ~/.zshrc;src'
#alias gvim='gvim -U ~/.gvimrc'
alias gvim='$EDITOR'
alias g='$EDITOR'
alias vi='$EDITOR'
alias mv='nocorrect mv -i'
alias cp='nocorrect cp -i'
alias rm='nocorrect rm -i'
alias mkdir='nocorrect mkdir'
alias man='nocorrect man'
alias find='noglob find'
alias grep='grep --colour'
if [[ "$VENDOR" == "apple" ]]; then
    alias ls='ls -G'
else 
    alias ls='ls --color=auto'
fi
alias l='ls'
alias ll='ls -l'
alias l.='ls -A'
alias ll.='ls -al'
alias lsa='ls -ls .*' ## list only file beginning with "."
alias lsd='ls -ld *(-/DN)' ## list only dirs
alias du1='du -hs *(/)' ## du with depth 1
alias u='uptime'
alias j='ps ax'
alias ..='cd ..'
alias cd/='cd /'
alias sd='export DISPLAY=:0.0' ## export DISPLAY=:0.0

#custom aliases go here

## global aliases, this is not good but it's useful
alias -g L='|less'
alias -g G='|grep'
alias -g T='|tail'
alias -g H='|head'
alias -g W='|wc -l'
alias -g S='|sort'
alias -g US='|sort -u'
alias -g NS='|sort -n'
alias -g RNS='|sort -nr'
alias -g N='&>/dev/null&'

#custom exports for coloured less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

## functions ####
## csh compatibility
setenv () { typeset -x "${1}${1:+=}${(@)argv[2,$#]}" }

## find process to kill and kill it.
pskill ()
{ 
    local pid
    pid=$(ps -ax | grep $1 | grep -v grep | awk '{ print $1 }')
    echo -n "killing $1 (process $pid)..."
    kill -9 $=pid
    echo "slaughtered."
}

## invoke this every time when u change .zshrc to
## recompile it.
src ()
{
    autoload -U zrecompile
    [ -f ~/.zshrc ] && zrecompile -p ~/.zshrc
    [ -f ~/.zcompdump ] && zrecompile -p ~/.zcompdump
    [ -f ~/.zshrc.zwc.old ] && rm -f ~/.zshrc.zwc.old
    [ -f ~/.zcompdump.zwc.old ] && rm -f ~/.zcompdump.zwc.old
    source ~/.zshrc
}

## find all suid files
suidfind ()
{ ls -l /**/*(su0x) }

## restore all .bak files
restore_bak ()
{
autoload -U zmv
zmv '(**/)(*).bak' '$1$2'
}

## display processes tree in less
pst ()
{ pstree -p $* | less -S }

## search for various types or README file in dir and display them in $PAGER
readme ()
{
    local files
    files=(./(#i)*(read*me|lue*m(in|)ut)*(ND))
    if (($#files))
    then $PAGER $files
    else
    print 'No README files.'
    fi
}


## completions ####
## General completion technique
## complete as much u can ..
zstyle ':completion:*' completer _complete _list _oldlist _expand _ignored _match _correct _approximate _prefix
## complete less
#zstyle ':completion:*' completer _expand _complete _list _ignored _approximate
## complete minimal
#zstyle ':completion:*' completer _complete _ignored

## allow one error
#zstyle ':completion:*:approximate:*' max-errors 1 numeric
## allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'

## formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format $'%{\e[0;31m%}%d%{\e[0m%}'
zstyle ':completion:*:messages' format $'%{\e[0;31m%}%d%{\e[0m%}'
zstyle ':completion:*:warnings' format $'%{\e[0;31m%}No matches for: %d%{\e[0m%}'
zstyle ':completion:*:corrections' format $'%{\e[0;31m%}%d (errors: %e)%{\e[0m%}'
zstyle ':completion:*' group-name ''

## determine in which order the names (files) should be
## listed and completed when using menu completion.
## `size' to sort them by the size of the file
## `links' to sort them by the number of links to the file
## `modification' or `time' or `date' to sort them by the last modification time
## `access' to sort them by the last access time
## `inode' or `change' to sort them by the last inode change time
## `reverse' to sort in decreasing order
## If the style is set to any other value, or is unset, files will be
## sorted alphabetically by name.
zstyle ':completion:*' file-sort name

## how many completions switch on menu selection
## use 'long' to start menu compl. if list is bigger than screen
## or some number to start menu compl. if list has that number
## of completions (or more).
zstyle ':completion:*' menu select=long

## case-insensitive (uppercase from lowercase) completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
## case-insensitive (all) completion
#zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
## case-insensitive,partial-word and then substring completion
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

## offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

## insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

## ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'

## completion caching
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path ~/.zcompcache/$HOST

## add colors to completions
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

## don't complete backup files as executables
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'

## filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns \
'*?.(o|c~|old|pro|zwc)' '*~'

## completions for some progs. not in default completion system

zstyle ':completion:*:*:mpg123:*' file-patterns \
'*.(mp3|MP3):mp3\ files *(-/):directories'

zstyle ':completion:*:*:ogg123:*' file-patterns \
'*.(ogg|OGG):ogg\ files *(-/):directories'

## generic completions for programs which understand GNU long options(--help)

compdef _gnu_generic slrnpull make df du

## on processes completion complete all user processes
zstyle ':completion:*:processes' command 'ps -au$USER'

## add colors to processes for kill completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

## setup accounts
users=( USERNAME root ) ## EDIT ##
zstyle ':completion:*' users $users

## common hostnames
hosts=( $(cat /etc/hosts | grep -v "^#" | awk '{print $1}'| cut -d"," -f1), $(cat $HOME/.ssh/known_hosts | awk '{print $1}'| cut -d"," -f1))
#hosts=( $(</etc/hosts), $(`cat .ssh/known_hosts | awk '{print $1}'`)
zstyle ':completion:*' hosts $hosts

## (user,host) pairs
## all my accounts:
my_accounts=(
#        {root foobar}@localhost ## EDIT ##
)
            
zstyle ':completion:*:my-accounts' users-hosts $my_accounts

## set options (setopt) ####
############################
# In the following list, options set by default in all emulations are marked
# <D>; those set by default only in csh, ksh, sh, or zsh emulations are marked
# <C>, <K>, <S>, <Z> as appropriate.  When listing options 
# (by `setopt', `unsetopt', `set -o' or `set +o'), those turned on by default
# appear in the list prefixed with `no'. Hence (unless KSH_OPTION_PRINT is set),
# `setopt' shows all options whose settings
# are changed from the default.
# Default options are commented, uncomment them if you want
# to be diferent from default

# ALIASES <D> Expand aliases.
#setopt NO_aliases

# ALL_EXPORT (-a, ksh: -a)
# All parameters subsequently defined are automatically exported.
setopt all_export

# ALWAYS_LAST_PROMPT <D>
# If unset, key functions that list completions try to return to the last
# prompt if given a numeric argument. If set these functions try to
# return to the last prompt if given no numeric argument.
#setopt NO_always_last_prompt

# ALWAYS_TO_END
# If a completion is performed with the cursor within a word, and a
# full completion is inserted, the cursor is moved to the end of the
# word.  That is, the cursor is moved to the end of the word if either
# a single match is inserted or menu completion is performed.
setopt always_to_end

# APPEND_HISTORY <D>
# If this is set, zsh sessions will append their history list to
# the history file, rather than overwrite it. Thus, multiple parallel
# zsh sessions will all have their history lists added to the
# history file, in the order they are killed.
#setopt NO_append_history

# AUTO_CD (-J)
# If a command is issued that can't be executed as a normal command,
# and the command is the name of a directory, perform the cd
# command to that directory.
setopt auto_cd

# AUTO_LIST (-9) <D>
# Automatically list choices on an ambiguous completion.
#setopt NO_auto_list

# AUTO_MENU <D>
# Automatically use menu completion after the second consecutive request for
# completion, for example by pressing the tab key repeatedly. This option
# is overridden by MENU_COMPLETE.
#setopt NO_auto_menu

# AUTO_NAME_DIRS
# Any parameter that is set to the absolute name of a directory
# immediately becomes a name for that directory, that will be used
# by the `%~'
# and related prompt sequences, and will be available when completion
# is performed on a word starting with `~'.
# (Otherwise, the parameter must be used in the form `~param' first.)
setopt NO_auto_name_dirs

# AUTO_PARAM_KEYS <D>
# If a parameter name was completed and a following character
# (normally a space) automatically inserted, and the next character typed is one
# of those that have to come directly after the name (like `}', `:',
# etc.), the automatically added character is deleted, so that the character
# typed comes immediately after the parameter name.
# Completion in a brace expansion is affected similarly: the added character
# is a `,', which will be removed if `}' is typed next.
#setopt NO_auto_param_keys

# AUTO_PARAM_SLASH <D>
# If a parameter is completed whose content is the name of a directory,
# then add a trailing slash instead of a space.
#setopt NO_auto_param_slash

# AUTO_PUSHD (-N)
# Make cd push the old directory onto the directory stack.
setopt auto_pushd

# AUTO_REMOVE_SLASH <D>
# When the last character resulting from a completion is a slash and the next
# character typed is a word delimiter, a slash, or a character that ends 
# a command (such as a semicolon or an ampersand), remove the slash.
#setopt NO_auto_remove_slash

# AUTO_RESUME (-W)
# Treat single word simple commands without redirection
# as candidates for resumption of an existing job.
setopt NO_auto_resume

# BAD_PATTERN (+2) <C> <Z>
# If a pattern for filename generation is badly formed, print an error message.
# (If this option is unset, the pattern will be left unchanged.)
#setopt NO_bad_pattern

# BANG_HIST (+K) <C> <Z>
# Perform textual history expansion, csh-style,
# treating the character `!' specially.
#setopt NO_bang_hist

# BARE_GLOB_QUAL <Z>
# In a glob pattern, treat a trailing set of parentheses as a qualifier
# list, if it contains no `|', `(' or (if special) `~'
# characters.  See section Filename Generation.
#setopt NO_bare_glob_qual

# BASH_AUTO_LIST
# On an ambiguous completion, automatically list choices when the
# completion function is called twice in succession.  This takes
# precedence over AUTO_LIST.  The setting of LIST_AMBIGUOUS is
# respected.  If AUTO_MENU is set, the menu behaviour will then start
# with the third press.  Note that this will not work with
# MENU_COMPLETE, since repeated completion calls immediately cycle
# through the list in that case.
#setopt bash_auto_list

# BEEP (+B) <D>
# Beep on error in ZLE.
setopt NO_beep

# BG_NICE (-6) <C> <Z>
# Run all background jobs at a lower priority.  This option
# is set by default.
#setopt NO_bg_nice

# BRACE_CCL
# Expand expressions in braces which would not otherwise undergo brace
# expansion to a lexically ordered list of all the characters.  See
# section Brace Expansion.
setopt brace_ccl

# BSD_ECHO <S>
# Make the echo builtin compatible with the BSD man page echo(1) command.
# This disables backslashed escape sequences in echo strings unless the
# -e option is specified.
#setopt bsd_echo

# C_BASES
# Output hexadecimal numbers in the standard C format, for example `0xFF'
# instead of the usual `16#FF'.  If the option OCTAL_ZEROES is also
# set (it is not by default), octal numbers will be treated similarly and
# hence appear as `077' instead of `8#77'.  This option has no effect
# on the choice of the output base, nor on the output of bases other than
# hexadecimal and octal.  Note that these formats will be understood on input
# irrespective of the setting of C_BASES.
setopt NO_c_bases

# CDABLE_VARS (-T)
# If the argument to a cd command (or an implied cd with the
# AUTO_CD option set) is not a directory, and does not begin with a
# slash, try to expand the expression as if it were preceded by a
# `~' (see section Filename Expansion).
setopt cdable_vars

# CHASE_DOTS
# When changing to a directory containing a path segment `..' which would
# otherwise be treated as canceling the previous segment in the path (in
# other words, `foo/..' would be removed from the path, or if `..' is
# the first part of the path, the last part of $PWD would be deleted),
# instead resolve the path to the physical directory.  This option is
# overridden by CHASE_LINKS.
# For example, suppose /foo/bar is a link to the directory /alt/rod.
# Without this option set, `cd /foo/bar/..' changes to /foo; with it
# set, it changes to /alt.  The same applies if the current directory
# is /foo/bar and `cd ..' is used.  Note that all other symbolic
# links in the path will also be resolved.
setopt NO_chase_dots


# CHASE_LINKS (-w)
# Resolve symbolic links to their true values when changing directory.
# This also has the effect of CHASE_DOTS, i.e. a `..' path segment
# will be treated as referring to the physical parent, even if the preceding
# path segment is a symbolic link.
setopt NO_chase_links

# CHECK_JOBS <Z>
# Report the status of background and suspended jobs before exiting a shell
# with job control; a second attempt to exit the shell will succeed.
# NO_CHECK_JOBS is best used only in combination with NO_HUP, else
# such jobs will be killed automatically.
#setopt NO_check_jobs

# CLOBBER (+C, ksh: +C) <D>
# Allows `>' redirection to truncate existing files,
# and `>>' to create files.
# Otherwise `>!' or `>|' must be used to truncate a file,
# and `>>!' or `>>|' to create a file.
#setopt clobber

# COMPLETE_ALIASES
# Prevents aliases on the command line from being internally substituted
# before completion is attempted.  The effect is to make the alias a
# distinct command for completion purposes.
setopt NO_complete_aliases

# COMPLETE_IN_WORD
# If unset, the cursor is set to the end of the word if completion is
# started. Otherwise it stays there and completion is done from both ends.
setopt complete_in_word

# CORRECT (-0)
# Try to correct the spelling of commands.
setopt NO_correct

# CORRECT_ALL (-O)
# Try to correct the spelling of all arguments in a line.
unsetopt correct_all

# CSH_JUNKIE_HISTORY <C>
# A history reference without an event specifier will always refer to the
# previous command.  Without this option, such a history reference refers
# to the same event as the previous history reference, defaulting to the
# previous command.
#setopt csh_junkie_history

# CSH_JUNKIE_LOOPS <C>
# Allow loop bodies to take the form `list; end' instead of
# `do list; done'.
#setopt csh_junkie_loops

# CSH_JUNKIE_QUOTES <C>
# Changes the rules for single- and double-quoted text to match that of
# csh.  These require that embedded newlines be preceded by a backslash;
# unescaped newlines will cause an error message.
# In double-quoted strings, it is made impossible to escape `$', ``'
# or `"' (and `\' itself no longer needs escaping).
# Command substitutions are only expanded once, and cannot be nested.
#setopt csh_junkie_quotes

# CSH_NULLCMD <C>
# Do not use the values of NULLCMD and READNULLCMD
# when running redirections with no command. This make 
# such redirections fail (see section Redirection).
#setopt csh_nullcmd

# CSH_NULL_GLOB <C>
# If a pattern for filename generation has no matches,
# delete the pattern from the argument list;
# do not report an error unless all the patterns
# in a command have no matches.
# Overrides NOMATCH.
#setopt csh_null_glob

# DVORAK
# Use the Dvorak keyboard instead of the standard qwerty keyboard as a basis
# for examining spelling mistakes for the CORRECT and CORRECT_ALL
# options and the spell-word editor command.
#setopt dvorak

# EQUALS <Z>
# Perform = filename expansion.
# (See section Filename Expansion.)
#setopt NO_equals

# ERR_EXIT (-e, ksh: -e)
# If a command has a non-zero exit status, execute the ZERR
# trap, if set, and exit.  This is disabled while running initialization
# scripts.
#setopt err_exit

# EXTENDED_GLOB
# Treat the `#', `~' and `^' characters as part of patterns
# for filename generation, etc.  (An initial unquoted `~'
# always produces named directory expansion.)
setopt extended_glob

# EXTENDED_HISTORY <C>
# Save each command's beginning timestamp (in seconds since the epoch)
# and the duration (in seconds) to the history file.  The format of
# this prefixed data is:
# `:<beginning time>:<elapsed seconds>:<command>'.
#setopt extended_history

# FLOW_CONTROL <D>
# If this option is unset,
# output flow control via start/stop characters (usually assigned to
# ^S/^Q) is disabled in the shell's editor.
#setopt NO_flow_control

# FUNCTION_ARGZERO <C> <Z>
# When executing a shell function or sourcing a script, set $0
# temporarily to the name of the function/script.
#setopt NO_function_argzero

# GLOB (+F, ksh: +f) <D>
# Perform filename generation (globbing).
# (See section Filename Generation.)
#setopt NO_glob

# GLOBAL_EXPORT (<Z>)
# If this option is set, passing the -x flag to the builtins declare,
# float, integer, readonly and typeset (but not local)
# will also set the -g flag;  hence parameters exported to
# the environment will not be made local to the enclosing function, unless
# they were already or the flag +g is given explicitly.  If the option is
# unset, exported parameters will be made local in just the same way as any
# other parameter.
# This option is set by default for backward compatibility; it is not
# recommended that its behaviour be relied upon.  Note that the builtin
# export always sets both the -x and -g flags, and hence its
# effect extends beyond the scope of the enclosing function; this is the
# most portable way to achieve this behaviour.
#setopt NO_global_export


# GLOBAL_RCS (-d) <D>
# If this option is unset, the startup files /etc/zprofile,
# /etc/zshrc, /etc/zlogin and /etc/zlogout will not be run. It
# can be disabled and re-enabled at any time, including inside local startup
# files (.zshrc, etc.).
#setopt NO_global_rcs

# GLOB_ASSIGN <C>
# If this option is set, filename generation (globbing) is
# performed on the right hand side of scalar parameter assignments of
# the form `name=pattern (e.g. `foo=*').
# If the result has more than one word the parameter will become an array
# with those words as arguments. This option is provided for backwards
# compatibility only: globbing is always performed on the right hand side
# of array assignments of the form `name=(value)'
# (e.g. `foo=(*)') and this form is recommended for clarity;
# with this option set, it is not possible to predict whether the result
# will be an array or a scalar.
#setopt glob_assign

# GLOB_COMPLETE
# When the current word has a glob pattern, do not insert all the words
# resulting from the expansion but generate matches as for completion and
# cycle through them like MENU_COMPLETE. The matches are generated as if
# a `*' was added to the end of the word, or inserted at the cursor when 
# COMPLETE_IN_WORD is set.  This actually uses pattern matching, not
# globbing, so it works not only for files but for any completion, such as
# options, user names, etc.
setopt glob_complete

# GLOB_DOTS (-4)
# Do not require a leading `.' in a filename to be matched explicitly.
#setopt glob_dots

# GLOB_SUBST <C> <K> <S>
# Treat any characters resulting from parameter expansion as being
# eligible for file expansion and filename generation, and any
# characters resulting from command substitution as being eligible 
# for filename generation.  Braces (and commas in between) do not 
# become eligible for expansion.
#setopt glob_subst

# HASH_CMDS <D>
# Note the location of each command the first time it is executed.
# Subsequent invocations of the same command will use the
# saved location, avoiding a path search.
# If this option is unset, no path hashing is done at all.
# However, when CORRECT is set, commands whose names do not appear in
# the functions or aliases hash tables are hashed in order to avoid
# reporting them as spelling errors.
#setopt NO_hash_cmds

# HASH_DIRS <D>
# Whenever a command name is hashed, hash the directory containing it,
# as well as all directories that occur earlier in the path.
# Has no effect if neither HASH_CMDS nor CORRECT is set.
#setopt NO_hash_dirs

# HASH_LIST_ALL <D>
# Whenever a command completion is attempted, make sure the entire
# command path is hashed first. This makes the first completion slower.
#setopt NO_hash_list_all

# HIST_ALLOW_CLOBBER
# Add `|' to output redirections in the history.  This allows history
# references to clobber files even when CLOBBER is unset.
setopt NO_hist_allow_clobber

# HIST_BEEP <D>
# Beep when an attempt is made to access a history entry which
# isn't there.
setopt NO_hist_beep

# HIST_EXPIRE_DUPS_FIRST
# If the internal history needs to be trimmed to add the current command line,
# setting this option will cause the oldest history event that has a duplicate
# to be lost before losing a unique event from the list.
# You should be sure to set the value of HISTSIZE to a larger number
# than SAVEHIST in order to give you some room for the duplicated
# events, otherwise this option will behave just like HIST_IGNORE_ALL_DUPS
# once the history fills up with unique events.
setopt hist_expire_dups_first

# HIST_FIND_NO_DUPS
# When searching for history entries in the line editor, do not display
# duplicates of a line previously found, even if the duplicates are not
# contiguous.
setopt hist_find_no_dups

# HIST_IGNORE_ALL_DUPS
# If a new command line being added to the history list duplicates an
# older one, the older command is removed from the list (even if it is
# not the previous event).
setopt hist_ignore_all_dups

# HIST_IGNORE_DUPS (-h)
# Do not enter command lines into the history list
# if they are duplicates of the previous event.
setopt hist_ignore_dups

# HIST_IGNORE_SPACE (-g)
# Remove command lines from the history list when the first character on
# the line is a space, or when one of the expanded aliases contains a
# leading space.
# Note that the command lingers in the internal history until the next
# command is entered before it vanishes, allowing you to briefly reuse
# or edit the line.  If you want to make it vanish right away without
# entering another command, type a space and press return.
setopt hist_ignore_space

# HIST_NO_FUNCTIONS
# Remove function definitions from the history list.
# Note that the function lingers in the internal history until the next
# command is entered before it vanishes, allowing you to briefly reuse
# or edit the definition.
setopt hist_no_functions

# HIST_NO_STORE
# Remove the history (fc -l) command from the history list
# when invoked.
# Note that the command lingers in the internal history until the next
# command is entered before it vanishes, allowing you to briefly reuse
# or edit the line.
setopt hist_no_store

# HIST_REDUCE_BLANKS
# Remove superfluous blanks from each command line
# being added to the history list.
setopt hist_reduce_blanks

# HIST_SAVE_NO_DUPS
# When writing out the history file, older commands that duplicate
# newer ones are omitted.
setopt hist_save_no_dups

# HIST_VERIFY
# Whenever the user enters a line with history expansion,
# don't execute the line directly; instead, perform
# history expansion and reload the line into the editing buffer.
setopt hist_verify

# HUP <Z>
# Send the HUP signal to running jobs when the
# shell exits.
setopt NO_hup

# IGNORE_BRACES (-I) <S>
# Do not perform brace expansion.
#setopt ignore_braces

# IGNORE_EOF (-7)
# Do not exit on end-of-file.  Require the use
# of exit or logout instead.
# However, ten consecutive EOFs will cause the shell to exit anyway,
# to avoid the shell hanging if its tty goes away.
# Also, if this option is set and the Zsh Line Editor is used, widgets
# implemented by shell functions can be bound to EOF (normally
# Control-D) without printing the normal warning message.  This works
# only for normal widgets, not for completion widgets.
#setopt ignore_eof

# INC_APPEND_HISTORY
# This options works like APPEND_HISTORY except that new history lines
# are added to the $HISTFILE incrementally (as soon as they are
# entered), rather than waiting until the shell is killed.
# The file is periodically trimmed to the number of lines specified by
# $SAVEHIST, but can exceed this value between trimmings.
setopt inc_append_history

# INTERACTIVE (-i, ksh: -i)
# This is an interactive shell.  This option is set upon initialisation if
# the standard input is a tty and commands are being read from standard input.
# (See the discussion of SHIN_STDIN.)
# This heuristic may be overridden by specifying a state for this option
# on the command line.
# The value of this option cannot be changed anywhere other than the command line.
#setopt NO_interactive

# INTERACTIVE_COMMENTS (-k) <K> <S>
# Allow comments even in interactive shells.
setopt interactive_comments

# KSH_ARRAYS <K> <S>
# Emulate ksh array handling as closely as possible.  If this option
# is set, array elements are numbered from zero, an array parameter
# without subscript refers to the first element instead of the whole array,
# and braces are required to delimit a subscript (`${path[2]}' rather
# than just `$path[2]').
#setopt ksh_arrays

# KSH_AUTOLOAD <K> <S>
# Emulate ksh function autoloading.  This means that when a function is
# autoloaded, the corresponding file is merely executed, and must define
# the function itself.  (By default, the function is defined to the contents
# of the file.  However, the most common ksh-style case - of the file
# containing only a simple definition of the function - is always handled
# in the ksh-compatible manner.)
#setopt ksh_autoload

# KSH_GLOB <K>
# In pattern matching, the interpretation of parentheses is affected by
# a preceding `@', `*', `+', `?' or `!'. See section Filename Generation.
#setopt ksh_glob

# KSH_OPTION_PRINT <K>
# Alters the way options settings are printed: instead of separate lists of
# set and unset options, all options are shown, marked `on' if
# they are in the non-default state, `off' otherwise.
#setopt ksh_option_print

# KSH_TYPESET <K>
# Alters the way arguments to the typeset family of commands, including
# declare, export, float, integer, local and
# readonly, are processed.  Without this option, zsh will perform normal
# word splitting after command and parameter expansion in arguments of an
# assignment; with it, word splitting does not take place in those cases.
#setopt ksh_typeset

# LIST_AMBIGUOUS <D>
# This option works when AUTO_LIST or BASH_AUTO_LIST is also
# set.  If there is an unambiguous prefix to insert on the command line,
# that is done without a completion list being displayed; in other
# words, auto-listing behaviour only takes place when nothing would be
# inserted.  In the case of BASH_AUTO_LIST, this means that the list
# will be delayed to the third call of the function.
#setopt NO_list_ambiguous

# LIST_BEEP <D>
# Beep on an ambiguous completion.  More accurately, this forces the
# completion widgets to return status 1 on an ambiguous completion, which
# causes the shell to beep if the option BEEP is also set; this may
# be modified if completion is called from a user-defined widget.
setopt NO_list_beep

# LIST_PACKED
# Try to make the completion list smaller (occupying less lines) by
# printing the matches in columns with different widths.
setopt list_packed

# LIST_ROWS_FIRST
# Lay out the matches in completion lists sorted horizontally, that is,
# the second match is to the right of the first one, not under it as
# usual.
setopt NO_list_rows_first

# LIST_TYPES (-X)
# When listing files that are possible completions, show the
# type of each file with a trailing identifying mark.
setopt list_types

# LOCAL_OPTIONS <K>
# If this option is set at the point of return from a shell function,
# all the options (including this one) which were in force upon entry to
# the function are restored.  Otherwise, only this option and the XTRACE
# and PRINT_EXIT_VALUE options are restored.  Hence
# if this is explicitly unset by a shell function the other options in
# force at the point of return will remain so.
# A shell function can also guarantee itself a known shell configuration
# with a formulation like `emulate -L zsh'; the -L activates LOCAL_OPTIONS.
#setopt local_options

# LOCAL_TRAPS <K>
# If this option is set when a signal trap is set inside a function, then the
# previous status of the trap for that signal will be restored when the
# function exits.  Note that this option must be set prior to altering the
# trap behaviour in a function; unlike LOCAL_OPTIONS, the value on exit
# from the function is irrelevant.  However, it does not need to be set
# before any global trap for that to be correctly restored by a function.
# For example,
# unsetopt localtraps
# trap - INT
# fn() { setopt localtraps; trap '{}' INT; sleep 3; }
# will restore normally handling of SIGINT after the function exits.
#setopt local_traps

# LONG_LIST_JOBS (-R)
# List jobs in the long format by default.
setopt long_list_jobs

# MAGIC_EQUAL_SUBST
# All unquoted arguments of the form `anything=expression'
# appearing after the command name have filename expansion (that is,
# where expression has a leading `~' or `=') performed on
# expression as if it were a parameter assignment.  The argument is
# not otherwise treated specially; it is passed to the command as a single
# argument, and not used as an actual parameter assignment.  
# For example, in echo foo=~/bar:~/rod, both occurrences of ~ would be replaced.
# Note that this happens anyway with typeset and similar statements.
# This option respects the setting of the KSH_TYPESET option.
# In other words, if both options are in effect, arguments looking like
# assignments will not undergo wordsplitting.
setopt magic_equal_subst


# MAIL_WARNING (-U)
# Print a warning message if a mail file has been
# accessed since the shell last checked.
setopt mail_warning

# MARK_DIRS (-8, ksh: -X)
# Append a trailing `/' to all directory
# names resulting from filename generation (globbing).
#setopt mark_dirs

# MENU_COMPLETE (-Y)
# On an ambiguous completion, instead of listing possibilities or beeping,
# insert the first match immediately.  Then when completion is requested
# again, remove the first match and insert the second match, etc.
# When there are no more matches, go back to the first one again.
# reverse-menu-complete may be used to loop through the list
# in the other direction. This option overrides AUTO_MENU.
#setopt menu_complete

# MONITOR (-m, ksh: -m)
# Allow job control.  Set by default in interactive shells.
#setopt NO_monitor

# MULTIOS <Z>
# Perform implicit tees or cats when multiple
# redirections are attempted (see section Redirection).
#setopt NO_multios

# NOMATCH (+3) <C> <Z>
# If a pattern for filename generation has no matches,
# print an error, instead of
# leaving it unchanged in the argument list.
# This also applies to file expansion
# of an initial `~' or `='.
#setopt NO_nomatch

# NOTIFY (-5, ksh: -b) <Z>
# Report the status of background jobs immediately, rather than
# waiting until just before printing a prompt.
#setopt NO_notify

# NULL_GLOB (-G)
# If a pattern for filename generation has no matches,
# delete the pattern from the argument list instead of reporting an error.
# Overrides NOMATCH.
setopt null_glob

# NUMERIC_GLOB_SORT
# If numeric filenames are matched by a filename generation pattern,
# sort the filenames numerically rather than lexicographically.
setopt NO_numeric_glob_sort

# OCTAL_ZEROES <S>
# Interpret any integer constant beginning with a 0 as octal, per IEEE Std
# 1003.2-1992 (ISO 9945-2:1993).  This is not enabled by default as it
# causes problems with parsing of, for example, date and time strings with
# leading zeroes.
#setopt octal_zeroes

# OVERSTRIKE
# Start up the line editor in overstrike mode.
#setopt overstrike

# PATH_DIRS (-Q)
# Perform a path search even on command names with slashes in them.
# Thus if `/usr/local/bin' is in the user's path, and he or she types
# `X11/xinit', the command `/usr/local/bin/X11/xinit' will be executed
# (assuming it exists).
# Commands explicitly beginning with `/', `./' or `../'
# are not subject to the path search.
# This also applies to the . builtin.
# Note that subdirectories of the current directory are always searched for
# executables specified in this form.  This takes place before any search
# indicated by this option, and regardless of whether `.' or the current
# directory appear in the command search path.
setopt NO_path_dirs


# POSIX_BUILTINS <K> <S>
# When this option is set the command builtin can be used to execute
# shell builtin commands.  Parameter assignments specified before shell
# functions and special builtins are kept after the command completes unless
# the special builtin is prefixed with the command builtin.  Special
# builtins are
# .,:,break,continue,declare,eval,exit,
# export,integer,local,readonly,return,set,shift,source,times,trap and unset.
#setopt posix_builtins

# PRINT_EIGHT_BIT
# Print eight bit characters literally in completion lists, etc.
# This option is not necessary if your system correctly returns the
# printability of eight bit characters (see man page ctype(3)).
setopt print_eight_bit

# PRINT_EXIT_VALUE (-1)
# Print the exit value of programs with non-zero exit status.
#setopt print_exit_value

# PRIVILEGED (-p, ksh: -p)
# Turn on privileged mode. This is enabled automatically on startup if the
# effective user (group) ID is not equal to the real user (group) ID.  Turning
# this option off causes the effective user and group IDs to be set to the
# real user and group IDs. This option disables sourcing user startup files.
# If zsh is invoked as `sh' or `ksh' with this option set,
# /etc/suid_profile is sourced (after /etc/profile on interactive
# shells). Sourcing ~/.profile is disabled and the contents of the
# ENV variable is ignored. This option cannot be changed using the
# -m option of setopt and unsetopt, and changing it inside a
#  function always changes it globally regardless of the LOCAL_OPTIONS
# option.
#setopt privileged

# PROMPT_BANG <K>
# If set, `!' is treated specially in prompt expansion.
# See section Prompt Expansion.
#setopt prompt_bang

# PROMPT_CR (+V) <D>
# Print a carriage return just before printing
# a prompt in the line editor.  This is on by default as multi-line editing
# is only possible if the editor knows where the start of the line appears.
#setopt NO_prompt_cr

# PROMPT_PERCENT <C> <Z>
# If set, `%' is treated specially in prompt expansion.
# See section Prompt Expansion.
#setopt NO_prompt_percent

# PROMPT_SUBST <K>
# If set, parameter expansion, command substitution and
# arithmetic expansion are performed in prompts.
#setopt prompt_subst

# PUSHD_IGNORE_DUPS
# Don't push multiple copies of the same directory onto the directory stack.
setopt pushd_ignore_dups

# PUSHD_MINUS
# Exchanges the meanings of `+' and `-'
# when used with a number to specify a directory in the stack.
setopt pushd_minus

# PUSHD_SILENT (-E)
# Do not print the directory stack after pushd or popd.
setopt pushd_silent

# PUSHD_TO_HOME (-D)
# Have pushd with no arguments act like `pushd $HOME'.
#setopt NO_pushd_to_home

# RC_EXPAND_PARAM (-P)
# Array expansions of the form
# `foo${xx}bar', where the parameter
# xx is set to (a b c), are substituted with
# `fooabar foobbar foocbar' instead of the default
# `fooa b cbar'.
#setopt rc_expand_param

# RC_QUOTES
# Allow the character sequence `'{'}' to signify a single quote
# within singly quoted strings.  Note this does not apply in quoted strings
# using the format $'...', where a backslashed single quote can
# be used.
setopt rc_quotes

# RCS (+f) <D>
# After /etc/zshenv is sourced on startup, source the
# .zshenv, /etc/zprofile, .zprofile,
# /etc/zshrc, .zshrc, /etc/zlogin, .zlogin, and .zlogout
# files, as described in section Files.
# If this option is unset, the /etc/zshenv file is still sourced, but any
# of the others will not be; it can be set at any time to prevent the
# remaining startup files after the currently executing one from
# being sourced.
#setopt NO_rcs

# REC_EXACT (-S)
# In completion, recognize exact matches even
# if they are ambiguous.
#setopt rec_exact

# RESTRICTED (-r)
# Enables restricted mode.  This option cannot be changed using
# unsetopt, and setting it inside a function always changes it
# globally regardless of the LOCAL_OPTIONS option.  See
# section Restricted Shell.
#setopt restricted

# RM_STAR_SILENT (-H) <K> <S>
# Do not query the user before executing `rm *' or `rm path/*'.
#setopt rm_star_silent

# RM_STAR_WAIT
# If querying the user before executing `rm *' or `rm path/*',
# first wait ten seconds and ignore anything typed in that time.
# This avoids the problem of reflexively answering `yes' to the query
# when one didn't really mean it.  The wait and query can always be
# avoided by expanding the `*' in ZLE (with tab).
#setopt rm_star_wait

# SHARE_HISTORY <K>
# This option both imports new commands from the history file, and also
# causes your typed commands to be appended to the history file (the
# latter is like specifying INC_APPEND_HISTORY).
# The history lines are also output with timestamps ala
# EXTENDED_HISTORY (which makes it easier to find the spot where
# we left off reading the file after it gets re-written).
setopt share_history

# SH_FILE_EXPANSION <K> <S>
# Perform filename expansion (e.g., ~ expansion) before
# parameter expansion, command substitution, arithmetic expansion
# and brace expansion.
# If this option is unset, it is performed after
# brace expansion, so things like `~$USERNAME' and
# `~{pfalstad,rc}' will work.
#setopt sh_file_expansion

# SH_GLOB <K> <S>
# Disables the special meaning of `(', `|', `)'
# and '<' for globbing the result of parameter and command substitutions,
# and in some other places where
# the shell accepts patterns.  This option is set by default if zsh is
# invoked as sh or ksh.
#setopt sh_glob

# SHIN_STDIN (-s, ksh: -s)
# Commands are being read from the standard input.
# Commands are read from standard input if no command is specified with
# -c and no file of commands is specified.  If SHIN_STDIN
# is set explicitly on the command line,
# any argument that would otherwise have been
# taken as a file to run will instead be treated as a normal positional
# parameter.
# Note that setting or unsetting this option on the command line does not
# necessarily affect the state the option will have while the shell is
# running - that is purely an indicator of whether on not commands are
# actually being read from standard input. The value of this option
# cannot be changed anywhere other 
# than the command line.
#setopt shin_stdin

# SH_NULLCMD <K> <S>
# Do not use the values of NULLCMD and READNULLCMD
# when doing redirections, use `:' instead (see section Redirection).
#setopt sh_nullcmd

# SH_OPTION_LETTERS <K> <S>
# If this option is set the shell tries to interpret single letter options
# (which are used with set and setopt) like ksh does.
# This also affects the value of the - special parameter.
#setopt sh_option_letters

# SHORT_LOOPS <C> <Z>
# Allow the short forms of for, select,
# if, and function constructs.
#setopt NO_short_loops

# SH_WORD_SPLIT (-y) <K> <S>
# Causes field splitting to be performed on unquoted parameter expansions.
# Note that this option has nothing to do with word splitting.
# (See section Parameter Expansion.)
#setopt sh_word_split

# SINGLE_COMMAND (-t, ksh: -t)
# If the shell is reading from standard input, it exits after a single command
# has been executed.  This also makes the shell non-interactive, unless the
# INTERACTIVE option is explicitly set on the command line.
# The value of this option cannot be changed anywhere other than the command line.
#setopt single_command

# SINGLE_LINE_ZLE (-M) <K>
# Use single-line command line editing instead of multi-line.
#setopt single_line_zle

# SUN_KEYBOARD_HACK (-L)
# If a line ends with a backquote, and there are an odd number
# of backquotes on the line, ignore the trailing backquote.
# This is useful on some keyboards where the return key is
# too small, and the backquote key lies annoyingly close to it.
#setopt sun_keyboard_hack

# UNSET (+u, ksh: +u) <K> <S> <Z>
# Treat unset parameters as if they were empty when substituting.
# Otherwise they are treated as an error.
#setopt NO_unset

# VERBOSE (-v, ksh: -v)
# Print shell input lines as they are read.
#setopt verbose

# XTRACE (-x, ksh: -x)
# Print commands and their arguments as they are executed.
#setopt xtrace

# ZLE (-Z)
# Use the zsh line editor.  Set by default in interactive shells connected to
# a terminal.
#setopt NO_zle
