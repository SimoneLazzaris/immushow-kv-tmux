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

immu_insert() {
echo -e "::> \033[32mset '$1' '$2'\033[0m"
$IMMUCLIENT set "$1" "$2"
if [ "$SPEED" == "demo" ]
then
sleep 0.5
fi
}

immu_insert "name" "Michael Schumacher"
immu_insert "wdc_wins" "7"
immu_insert "f1_wins" "91"
immu_insert "podiums" "155"
immu_insert "f1_points" "1566"
immu_insert "poles" "68"
immu_insert "fast_laps" "77"
immu_insert "f1_races" "308"
immu_insert "first_win" "1992 Belgian Grand Prix"
immu_insert "last_win" "2006 Chinese Grand Prix"

TX=`$IMMUCLIENT status |grep txID|cut -d : -f 2|tr -d ' \t'`
echo Last known good transaction: $TX
echo $TX > /tmp/lastknown
