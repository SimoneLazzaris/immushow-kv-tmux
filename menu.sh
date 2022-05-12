#!/bin/bash

# Copyright 2022 CodeNotary, Inc. All rights reserved.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 	http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

SPEED="demo"
R="insert"
while [ 1 == 1 ]
do
exec 3>&1

R=$(dialog  --no-cancel --no-tags --no-ok \
 --title "immudb by CodeNotary" --default-item "$R" \
 --menu "ransomware recovery demo (KV)" 20 50 20 \
 insert "Initialize database" \
 ransom "Execute ransomware" \
 travel "Time travel - recover from ransomware" \
 "" "" \
 speed "Speed: $SPEED" \
 quit   "Exit program" \
 2>&1 1>&3)

exec 3>&-

case $R in
"insert")
  tmux selectp -t 2 \; send-keys "./insert.sh $SPEED" C-m 
  ;;
"ransom")
  tmux selectp -t 2 \; send-keys "./ransom.sh $SPEED" C-m 
  ;;
"travel")
  tmux selectp -t 2 \; send-keys "./recover.sh $SPEED" C-m 
  ;;
"speed")
  if [ "$SPEED" == "demo" ]
  then
  SPEED="realtime"
  else
  SPEED="demo"
  fi
  ;;
"quit")
  pkill -9 immudb
  tmux selectp -t 3 \; send-keys C-c   
  tmux selectp -t 2 \; send-keys C-c   
  tmux selectp -t 1 \; send-keys C-c   
  tmux selectp -t 3 \; send-keys C-d  
  tmux selectp -t 2 \; send-keys C-d  
  tmux selectp -t 1 \; send-keys C-d  
  tmux selectp -t 0 \; send-keys C-d  
  tmux detach
  tmux kill-session -t immushow
  break
  ;;
esac
tmux selectp -t 0
done
clear

