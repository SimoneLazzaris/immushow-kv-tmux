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

source env.sh
SPEED=$1

immu_ransom() {
V=`openssl rand -base64 12`
echo -e "::> \033[31mset $1 $V\033[0m"
$IMMUCLIENT set $1 $V
if [ "$SPEED" == "demo" ]
then
sleep 0.5
fi
}

KEYS=$(./immuclient scan ''|sed -z 's/\nkey/\tkey/g;s/\nvalue/\tvalue/g;s/\n\n/\n/g;s/ \+/ /g'|sort -nk 2|awk '/key:/{print $4}')

for k in $KEYS
do
immu_ransom $k
done

TX=`$IMMUCLIENT status |grep txID|cut -d : -f 2|tr -d ' \t'`
echo "Current transaction $TX"
GOOD=`cat /tmp/lastknown`
echo "Last known good: $GOOD"
