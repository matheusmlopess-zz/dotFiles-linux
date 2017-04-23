# ~/.bashrc: executed by bash(1) for non-login shells.

# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#-------------------------------------
#----------------------------------------
#red='\e[1;31m%s\e[0m\n'
#green='\e[1;32m%s\e[0m\n'
#yellow='\e[1;33m%s\e[0m\n'
#blue='\e[1;34m%s\e[0m\n'
#magenta='\e[1;35m%s\e[0m\n'
#cyan='\e[1;36m%s\e[0m\n'

red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'
rnd=$'\e[38;05;'

Color_Off='\033[0m'       # Text Reset

_restartWifiHrdwar(){
	#set -x
	dmesg | tail ;

	#sudo lshw -C network   # driver=iwlwifi
	#sudo modprobe -r iwlwifi && sudo modprobe iwlwifi

	#ou

	#sudo rmmod ipw2100
	#sudo modprobe ipw2100
	       #sleep 0.25
	       #sudo ifconfig 'wlp3s0' down
	       #sudo ifconfig 'wlp3s0' up
	              #sleep 0.257
		      echo "Wifi HW turning off ..."
		      sudo iwconfig 'wlp3s0' txpower off
		      echo "Wifi HW turning on!"
		      sudo iwconfig 'wlp3s0' txpower auto 
		             #sleep 0.25
			     #sudo rfkill block wifi
			     #sudo rfkill unblock wifi
			            sleep 0.25
				    sudo iwconfig 'wlp3s0' power off
				           echo "Restatrting NetworkManager ..."
					   sudo systemctl restart NetworkManager
					   echo "NetworkManager restored ..."
					          #sleep 0.25
						  #sudo systemctl restart NetworkManager
						  #set +x
 }


export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/.virtualenvs/pythonProjects/
export VIRTUALENVWRAPPER_SCRIPT=~/virtualenvwrapper.sh

source /home/..../virtualenvwrapper.sh



alias _bashrc='nvim ~/.bashrc'
#alias l='ls -al'
#alias ll='ls .?*'
alias clc='clear'
alias _vimrc='vim ~/.vimrc'
alias _nvimrc='nvim ~/.config/nvim/init.vim'
alias ..='cd ..'
alias ...='cd ../../'
alias _update='sudo apt-get update'
alias _install='sudo apt-get install'
alias py='python'
alias desk='cd ~/Desktop'
alias editcmd='nvim ~/Desktop/dotFiles/commands.txt'
alias rsetcolor='echo ${end}'
alias cmt='git commit -m'

cd(){    
	printf "\n"
	 echo ${yel}........................................................................ ${end}
	 command cd $1 && ls -a
	# printf "History bash: %s\n" "${blu} $OLDPWD ${end}"
	 echo ${yel}________________________________________________________________________ ${end}
	# printf "\nHistory bash: %s -to-> %s \n\n" "${blu} $OLDPWD ${end}" "${yel} $(pwd) ${end}"
	printf "\n"
}

txt(){
	pushd ~/Desktop/txts/;
	printf "\n"
	VAR=$@;
if [[ -z $VAR ]]; then
        VAR=$(xclip -o);
	echo ${yel}________________________________________________________________________ ${end}
	echo ${yel} 
	xclip -o;
        echo  ${end}
	echo ${yel}________________________________________________________________________ ${end}
	printf "\n"
	ls -a | grep ".txt";
	printf "\n"
	read -p "which .txt ?${end} ${cyn}(or new txt file name  Ctrl+c to cancel)${end}:" -r nome;
	xclip -o >> $nome.txt;
else 
	echo ${yel}________________________________________________________________________ ${end}
	echo ${yel} $VAR ${end}
	echo ${yel}________________________________________________________________________ ${end}
	printf "\n"
	ls -a | grep ".txt";
	printf "\n"
	read -p "which .txt ?${end} ${cyn}(or new txt file name Ctrl+c to cancel)${end}:" -r nome;
	echo $VAR >> $nome.txt;
fi
	printf "\n"
	popd;
}

cmd(){
   pushd /home/../Desktop/dotFiles;
   command ls;
   NUMBER=$[ ( $RANDOM % 255 )  + 1 ]
   echo $NUMBER	
   echo ${rnd}${NUMBER}m $@  >> commands.txt
   popd;
}

cmdisplay(){
	pushd /home/.../Desktop/dotFiles;
	cat commands.txt;
	popd;
}

tmcolor(){
	VAR=$@;
	echo $VAR
if [[ -z $VAR ]]; then
	NUM=$[ ( $RANDOM % 37 ) + 30 ];
	echo número tmcolor $NUM
	export PS1='${rnd}${NUM}m~$(pwd)〉\n$ \033[00m'
fi

if [ "$VAR" == "f" ]; then
	export PS1='${rnd}48m~$(pwd)〉\n$ \033[00m'
fi
}
tmcolor

#eval $(echo "no:global default;fi:normal file;di:directory;ln:symbolic link;pi:named pipe;so:socket;do:door;bd:block device;cd:character device;or:orphan symlink;mi:missing file;su:set uid;sg:set gid;tw:sticky other writable;ow:other writable;st:sticky;ex:executable;"|sed -e 's/:/="/g; s/\;/"\n/g')           
#{      
 # IFS=:     
  #for i in $LS_COLORS     
  #do        
  #  echo -e "\e[${i#*=}m$( x=${i%=*}; [ "${!x}" ] && echo "${!x}" || echo "$x" )\e[m" 
  #done       
#} bashrc
