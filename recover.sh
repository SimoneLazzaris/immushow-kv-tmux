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

immu_recover() {
OLD=`$IMMUCLIENT get $1@-1 --value-only`
echo -e "::> \033[32mset $1 $OLD\033[0m"
$IMMUCLIENT set $1 "$OLD"
if [ "$SPEED" == "demo" ]
then
sleep 0.5
fi
}
for k in $(./immuclient scan ''|awk '/key:/{print $2}')
do
immu_recover $k
done

TX=`$IMMUCLIENT status |grep txID|cut -d : -f 2|tr -d ' \t'`
echo Last known good transaction: $TX
echo $TX > /tmp/lastknown

