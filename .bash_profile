#export GIT_SSH_COMMAND='ssh -o KexAlgorithms=+diffie-hellman-group1-sha1'
#export gitdir=$(git rev-parse --git-dir); scp -p -P 29418 jtbricker@test-stash.gainesville.infiniteenergy.com:hooks/commit-msg ${gitdir}/hooks

#####################################################
####################   PATH   #######################
#####################################################
PATH=$PATH:/c/Users/jbrick1/AppData/Local/Continuum/anaconda3
PATH=$PATH:/c/Users/jbrick1/AppData/Local/Continuum/anaconda3/Scripts
PATH=$PATH:/c/Users/jbrick1/bin/
PATH=$PATH:/c/src/bin/
PATH=$PATH:/c/src/bin/cbc/bin/
PATH=$PATH:/c/src/bin/oracle/instantclient_18_5
PATH=$PATH:/c/Program\ Files\ \(x86\)/Microsoft\ SDKs/Windows/v10.0A/bin/NETFX\ 4.7.1\ Tools
PATH=$PATH:/c/src/bin/WinMerge/
export PATH=$PATH:/c/Users/jbrick1/AppData/Local/Programs/Microsoft\ VS\ Code

############# PROXY SETTINGS ########################
export http_proxy=proxy.acml.com:8082
export https_proxy=proxy.acml.com:8082
export no_proxy='localhost,.acml.com,.beehive.com,.alliancebernstein.com,.ac.lp.acml.com,.lp.acml.com,.abglobal.com'

############# RANDOM ENV ########################
export COIN_INSTALL_DIR=/c/src/bin/cbc

#####################################################
##################   ALIASES   ######################
#####################################################
alias edit="Code.exe"
#alias python="winpty python.exe"
alias vs='[ "$(ls -b *sln | wc -l)" -le 1 ] && start *sln'
alias bp="edit ~/.bash_profile &"
alias savebp="source ~/.bash_profile"
alias python="winpty python"

#########  NAVIGATION ALIASES #############
alias src="cd /c/src/"
alias rpy="cd /c/src/RAP.Python.Scripts"
alias lvg="cd /c/src/RAP.LVGateway.WebApi"
alias mstar="cd /c/src/it_git/WebscrapingProjects/morningstar"

#########  GIT HELPERS  ###############
alias gitalias="edit ~/.gitconfig"
alias bclean='git branch | grep -v "master" | grep -v "develop" | xargs git branch -D '
alias dev='git checkout develop'
alias devup='git checkout develop && git pull'
alias qaup='git checkout qa && git pull'

######### MISC ###############
alias updateabpylibs="pip install --upgrade --no-index --find-links=\\\\nts0018\\bond\\FIQUANT\\PYTHON_REPO\\py3 pymssql ctds cx_Oracle abutils pyOpenRap abdatamap jpmdqapi abRegularBatch datastreamapi pycurl abSymphony OptimUtils xlrd sqlanydb"
alias venv="source ./venv/Scripts/activate"
alias denv="deactivate"
alias sched="python /c/src/personal/outlook/outlook_get_calendar_events.py"


#########  FUNCTIONS ##############
function renameFilesRecursively () {
  SEARCH_PATH="$1"
  SEARCH="$2"
  REPLACE="$3"

  find ${SEARCH_PATH} -type f -name "*${SEARCH}*" | while read FILENAME ; do
      NEW_FILENAME="$(echo ${FILENAME} | sed -e "s/${SEARCH}/${REPLACE}/g")";
      mv "${FILENAME}" "${NEW_FILENAME}";
  done
}

function hist {
  history | grep $1
} 

function pubra {
  dotnet publish /c/src/RAP.Abbie/Skills/BrokerMatrix/RAP.Abbie.BrokerMatrix.Consumer/RAP.Abbie.BrokerMatrix.Consumer.csproj --output /c/src/RAP.MassTransit.Host/RAP.MassTransit.Host.Service/bin/Debug/ --framework net471
  dotnet publish /c/src/RAP.Abbie/Skills/Intent/RAP.Abbie.Intent.Consumer/RAP.Abbie.Intent.Consumer.csproj --output /c/src/RAP.MassTransit.Host/RAP.MassTransit.Host.Service/bin/Debug/ --framework net471
}

function srf {
  cd "$(find /c/src/ -maxdepth 2 -iname "*$1*" -type d | head -n 1)"
}

function pip() {
  if [[ "$1" == "install" ]]; then
    shift 1
    command pip install --find-links=\\\\nts0018\\bond\\FIQUANT\\PYTHON_REPO\\py3 "$@"
  else
    command pip "$@"
  fi
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval "$('/c/Continuum/anaconda3/Scripts/conda.exe' 'shell.bash' 'hook')"
# <<< conda initialize <<<

