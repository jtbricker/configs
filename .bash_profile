#export GIT_SSH_COMMAND='ssh -o KexAlgorithms=+diffie-hellman-group1-sha1'
#export gitdir=$(git rev-parse --git-dir); scp -p -P 29418 jtbricker@test-stash.gainesville.infiniteenergy.com:hooks/commit-msg ${gitdir}/hooks

#####################################################
####################   PATH   #######################
#####################################################
PATH=$PATH:/c/Users/jtbricker/bin/
PATH=$PATH:/c/src/bin/
PATH=$PATH:/c/Program\ Files\ \(x86\)/Microsoft\ VS\ Code/
PATH=$PATH:/c/src/Corman3.PacketGenerator/PacketGenerator/bin/Debug/
export PATH=$PATH:/c/Program\ Files/MongoDB/Server/3.2/bin/

#####################################################
##################   ALIASES   ######################
#####################################################
alias edit="Code.exe"
#alias python="winpty python.exe"
alias vs='[ "$(ls -b *sln | wc -l)" -le 1 ] && start *sln'
alias bp="edit ~/.bash_profile"
alias savebp="source ~/.bash_profile"
alias nsl="LOCAL_BFF_PORT=60015 npm start"

#########  NAVIGATION ALIASES #############
alias src="cd /c/src/"
alias bff="cd /c/src/IEI.CustomerWeb/backend"
alias wa="cd /c/src/IEI.CustomerWeb.WebAccount"

#########  GIT HELPERS  ###############
alias gitalias="edit ~/.gitconfig"
alias bclean='git branch | grep -v "master" | grep -v "develop" | xargs git branch -D '
alias dev='git checkout develop'
alias devup='git checkout develop && git pull'

#####################################################
##################   FUNCS     ######################
#####################################################
function push() {
    if [ $# -eq 0 ]
    then
        echo "Usage: push TAG_NAME"
        echo "=====Executes: git push origin CURRENT_GIT_BRANCH:refs/for/develop/TAG_NAME"
        return
    fi
    TAG=$1
    CURR_BRANCH=`git branch | grep \* | cut -d ' ' -f2`
    echo "git push origin $CURR_BRANCH:refs/for/develop/$TAG"
}

#####################################################
####################   GIT   ########################
#####################################################
# Setup to Use NPM behind the WSA
npm config set registry http://web2/nexus/content/groups/npm-unstable
npm config set strict-ssl false


# Note: ~/.ssh/environment should not be used, as it
#       already has a different purpose in SSH.

env=~/.ssh/agent.env

# Note: Don't bother checking SSH_AGENT_PID. It's not used
#       by SSH itself, and it might even be incorrect
#       (for example, when using agent-forwarding over SSH).

agent_is_running() {
    if [ "$SSH_AUTH_SOCK" ]; then
        # ssh-add returns:
        #   0 = agent running, has keys
        #   1 = agent running, no keys
        #   2 = agent not running
        ssh-add -l >/dev/null 2>&1 || [ $? -eq 1 ]
    else
        false
    fi
}

agent_has_keys() {
    ssh-add -l >/dev/null 2>&1
}

agent_load_env() {
    . "$env" >/dev/null
}

agent_start() {
    (umask 077; ssh-agent >"$env")
    . "$env" >/dev/null
}

if ! agent_is_running; then
    agent_load_env
fi

# if your keys are not stored in ~/.ssh/id_rsa or ~/.ssh/id_dsa, you'll need
# to paste the proper path after ssh-add
if ! agent_is_running; then
    agent_start
    ssh-add
elif ! agent_has_keys; then
    ssh-add
fi

unset env
