# ~/.bashrc: executed by bash(1) for non-login shellsdd.
#----------------------------------------------------------------------
#                                CustoM
#----------------------------------------------------------------------

# supressing pushd and popd the default "print stack" when called 

pushd(){       command pushd $@ > /dev/null; }
popd() {       command popd $@ > /dev/null;  }

pkg_status(){

# require sudo permission which sucks!	
# dpkg-query -W -f='${Status}' MYPACKAGE | grep -q -P '^install ok installed$'; echo $?
# VAL=$(dpkg-query -W -f='${Status}' $@ 2>/dev/null | grep -c "ok installed")

			XPKG_CHK=0;
			# dont require sudo permissions
			# 2>&1 :Passing stderr (2) over "-v" pipe along with stdout (1)
			# by redirecting the stderr stream (file descriptor #2)
			# to stdout (file descriptor #1)	

			command -v $@ >/dev/null 2>&1 || { XPKG_CHK=1;}
			if [ $XPKG_CHK -eq 0 ];
			then
				apt-cache policy xclip
			else	
				read -r -p "Do you want to continue? [Y/n]? " response
				case "$response" in
					[yY][eE][sS]|[yY]) 
						sudo apt-get install $@;
					;;
					*)
						exit 1;
				        ;;
				esac
			fi

}

# colored GCC warnings and errors
# export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


  red=$'\e[1;31m'
  grn=$'\e[1;32m'
  yel=$'\e[1;33m'
  blu=$'\e[1;34m'
  mag=$'\e[1;35m'
  cyn=$'\e[1;36m'
  end=$'\e[0m'
  rnd=$'\e[38;05;'
  Color_Off='\033[0m'  


# salva conteudo do clipboar em pasta dedicada --> ~/Desktop/dotFiles
cmd(){
	# init function: creat cmd folder the first time cmd() is called.
	pushd ~/Desktop;
	if [ ! -d ~/Desktop/dotFiles ]; then 
		mkdir dotFiles
			cd dotFiles;
			echo " " > commands.txt
		echo "dotFiles directory not found... & Created in $(pwd)"
		git clone https://github.com/matheusmlopess/dotFiles-linux.git 
		cd dotFiles && ls -laF;
		return 1;
	else
		cd dotFiles/dotFiles-linux
	fi

   command ls -a;
   NUMBER=$[ ( $RANDOM % 255 )  + 1 ]
   VAR=$@;

	if [[ -z $VAR ]]; then 
		printf "\n"
		echo ${yel} 
		xclip -o;
        	echo  ${end}
		printf "\n"

	CONTEUDO=$(xclip -o);
        echo ${rnd}${NUMBER}m $CONTEUDO  >> commands.txt
	
else
        echo ${rnd}${NUMBER}m $@ ${end} >> commands.txt
fi
popd;
}


txt(){
	# init function: creat text folder the first time txt() is called.
	pushd ~/Desktop;
	if [ ! -d ~/Desktop/txts ]; then 
		mkdir txts
		echo "Text directory not found... Creating folder and appling permissions"
		sudo chmod 700 txts
		echo TEXT files directory created.
		return 1;
	else
		cd txts
	fi
	
	printf "\n"
	VAR=$@;
if [[ -z $VAR ]]; then
        VAR=$(xclip -o);
	echo ${yel}________________________________________________________________________ 
		printf "\n"
			xclip -o;
		printf "\n"
	echo ________________________________________________________________________ ${end}
	printf "\n"
		ls -a | grep ".txt";
	printf "\n"
		read -p "which .txt file?${end} ${cyn}(or just) type a name: ${end}:" -r nome;
	xclip -o >> $nome.txt;
else 
	echo ${yel}________________________________________________________________________
	printf "\n"
		echo $VAR 
	printf "\n"
	echo ________________________________________________________________________ ${end}
	printf "\n"
		ls -a | grep ".txt";
	printf "\n"
		read -p "which .txt file?${end} ${cyn}(or just) type a name: ${end}:" -r nome;
	echo $VAR >> $nome.txt;
fi
	printf "\n"
	popd;
}


# First terminal run 
 
	pushd ~/Desktop;
	if [ ! -d ~/Desktop/dotFiles ]; then
	# Redirecting stdrr over stdout 

			GIT_CHK=0;
			command -v git > /dev/null 2>&1 || { GIT_CHK=1;}
		 	if [ $GIT_CHK -eq 0 ]; then
				apt-cache policy git 
			else    
				echo to continue please install git
				sudo apt-get install git-all;	
		 	fi

			XCLIP_CHK=0;
			command -v xclip >/dev/null 2>&1 || { XCLIP_CHK=1;}
			if [ $XCLIP_CHK -eq 0 ];
			then
				apt-cache policy xclip
			else
				echo to continue please install xclip
				sudo apt-get install xclip
			fi
		cmd
	fi

	if [ ! -d ~/Desktop/txts ]; then
		txt
	fi
	popd;


#-----------------------------------------------------------------------
#custom end | ----------------------------------------------------------
#-----------------------------------------------------------------------

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

#----------------------------------------------------------------------
#                              CustoM
#----------------------------------------------------------------------

# colored GCC warnings and errors
# export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


# Overwintering configuração prévia do prompt
# Custom prompt (PS1) - tmcolor $@ - configura para cor aleatória da palet de 255 cores do xterm/gnome terminal
tmcolor(){
	VAR=$@;
	echo $VAR
	if [[ -z $VAR ]]; then
		export PS1='\[\033[01;48m\] ~$(pwd)〉\033[0m \n$ '
	#fi
	else	
	#if [ "$VAR" == "f" ]; then
		NUM=$[ ( $RANDOM % 37 ) + 30 ];
	#	echo numero tmcolor $NUM
		export PS1='$\e${NUM}m~$(pwd)〉${end}\n$ '
	fi
#clear
}
tmcolor

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
export VIRTUALENVWRAPPER_SCRIPT=$HOME/.local/bin/virtualenvwrapper.sh
source $HOME/.local/bin/virtualenvwrapper.sh

#/usr/local/bin/virtualenvwrapper.sh

# ----------------------------- Aliases --------------------------------------
# ----------------------------------------------------------------------------

alias _bashrc='nvim ~/.bashrc'
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
alias pullFoldrs='cd ~/Desktop/gits'
alias s="git status -s"
alias _rmbashSwp='rm ~/.local/share/nvim/swap//%home%mrs-magooo%.bashrc.swp'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias rs='resize -s 110 100'
alias hide_icons='ls ~/Desktop > ~/Desktop/.hidden'
alias show_icons='rm ~/Desktop/.hidden'
cd(){	command cd $1 && l && printf "\n"; }

cmdisplay(){
	pushd ~/Desktop/dotFiles;
	cat commands.txt;
	popd;
}

_ckdir(){

if [ -d "$@" ]; then
  # Control will enter here if $DIRECTORY exists.
	ls -a $@
fi

}

bashPull(){
	pushd $HOME;
	echo "--> Dir:`pwd`"
	if [ -f ~/.bashrc ]; then
	    echo "File found!"
	fi

 	pushd ~/Desktop/gits/dotFiles-linux;
		ls -d .?*;




	popd;
}

bashPush(){

	echo " " 
}

#eval $(echo "no:global default;fi:normal file;di:directory;ln:symbolic link;pi:named pipe;so:socket;do:door;bd:block device;cd:character device;or:orphan symlink;mi:missing file;su:set uid;sg:set gid;tw:sticky other writable;ow:other writable;st:sticky;ex:executable;"|sed -e 's/:/="/g; s/\;/"\n/g')           
#{      
 # IFS=:     
  #for i in $LS_COLORS     
  #do        
  #  echo -e "\e[${i#*=}m$( x=${i%=*}; [ "${!x}" ] && echo "${!x}" || echo "$x" )\e[m" 
  #done       
#} bashrc

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion                                                                                                                                                                
fi


function_exists() {
    declare -f -F $1 > /dev/null
    return $?
}

for al in `__git_aliases`; do
    alias g$al="git $al"
    
    complete_func=_git_$(__git_aliased_command $al)
    function_exists $complete_fnc && __git_complete g$al $complete_func
done

