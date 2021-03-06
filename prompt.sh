if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then 
 c_reset=`tput sgr0`
  c_user=`tput setaf 2; tput bold`
  c_path=`tput setaf 4; tput bold`
  c_git_clean=`tput setaf 2`
  c_git_dirty=`tput setaf 1`
else
c_reset=
  c_user=
  c_path=
  c_git_clean=
  c_git_dirty=
fi

git_prompt ()
{
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
return 0
  fi


git_branch=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')
  
 git_status="$(git status 2> /dev/null)"
 
# Set color based on clean/staged/dirty.
if [[ ${git_status} =~ "working directory clean" ]]; then
  git_color="${c_git_clean}"
else
  git_color="${c_git_dirty}"
fi

echo " [$git_color$git_branch${c_reset}]"
}

PS1='\[\033[0;36m\]\d \t \[\e[0;31m\]\u\[\e[36;1m\]@\[\e[32;1m\]\H:\[\e[33;1m\]\w\[\e[32;1m\]\[\e[0m\]$(git_prompt)\n\[\e[36;1m\]\$ \[\033[0m\]'
