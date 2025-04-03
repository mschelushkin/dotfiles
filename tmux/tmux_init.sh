#!/bin/bash

session="main"
tmux has-session -t $session &> /dev/null

if [ $? != 0 ]
  then
    tmux new-session -d -s $session
    tmux rename-window -t $session:1 'main'
fi

session="server"
tmux has-session -t $session &> /dev/null

if [ $? != 0 ]
  then
    tmux new-session -d -s $session 
    tmux rename-window -t $session:1 'git'
    tmux send-keys -t $session:1 'cd ~/IdeaProjects/enmacc-server/' C-m
    tmux send-keys -t $session:1 'lazygit' C-m

    tmux new-window -t $session:2 -n 'nvim'
    tmux send-keys -t $session:2 'cd ~/IdeaProjects/enmacc-server/' C-m
    tmux send-keys -t $session:2 'v .' C-m

    tmux new-window -t $session:3 -n 'mvn'
    tmux send-keys -t $session:3 'cd ~/IdeaProjects/enmacc-server/' C-m
    tmux send-keys -t $session:3 'clear' C-m

    tmux select-window -t $session:1
fi

session="docker"
tmux has-session -t $session &> /dev/null

if [ $? != 0 ]
  then
    tmux new-session -d -s $session 
    tmux rename-window -t $session:1 'main'
    tmux send-keys -t $session:1 'cd ~/IdeaProjects/e2e-testing/e2e/' C-m
    tmux send-keys -t $session:1 'clear' C-m
    tmux select-window -t $session:1
fi

session="curl"
tmux has-session -t $session &> /dev/null

if [ $? != 0 ]
  then
    tmux new-session -d -s $session 
    tmux rename-window -t $session:1 'main'
    tmux send-keys -t $session:1 'cd ~/curlUtils/' C-m
    tmux send-keys -t $session:1 'clear' C-m
    tmux select-window -t $session:1
fi

 session="data-sharing"
 tmux has-session -t $session &> /dev/null

 if [ $? != 0 ]
   then
     tmux new-session -d -s $session
     tmux rename-window -t $session:1 'git'
    tmux send-keys -t $session:1 'cd ~/IdeaProjects/enmacc-data-sharing/' C-m
     tmux send-keys -t $session:1 'lazygit' C-m

     tmux new-window -t $session:2 -n 'nvim'
    tmux send-keys -t $session:2 'cd ~/IdeaProjects/enmacc-data-sharing/' C-m
     tmux send-keys -t $session:2 'v .' C-m

     tmux new-window -t $session:3 -n 'mvn'
    tmux send-keys -t $session:3 'cd ~/IdeaProjects/enmacc-data-sharing/' C-m
    tmux send-keys -t $session:3 'clear' C-m

     tmux select-window -t $session:1
 fi

tmux attach-session -t main:1
