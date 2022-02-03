# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

if [ -f ~/.bash_utils ]; then
    . ~/.bash_utils
fi

if [ -f ~/.bash_historyconfig ]; then
    . ~/.bash_historyconfig
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_variables ]; then
    . ~/.bash_variables
fi

if [ -f ~/.bash_powerline ]; then
    . ~/.bash_powerline
fi
