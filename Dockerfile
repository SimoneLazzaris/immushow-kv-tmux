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


FROM debian:bullseye-slim as bullseye-slim
RUN apt-get update && apt-get install procps tmux dialog curl netcat-traditional -y
WORKDIR /app
COPY . .
RUN curl -sL https://github.com/vchain-us/immudb/releases/download/v1.2.4/immudb-v1.2.4-linux-amd64-static -o immudb && chmod +x immudb
RUN curl -sL https://github.com/vchain-us/immudb/releases/download/v1.2.4/immuclient-v1.2.4-linux-amd64-static -o immuclient && chmod +x immuclient

ENTRYPOINT ["bash", "start.sh"]
