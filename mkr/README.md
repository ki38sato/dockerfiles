mkr Local Environment
---
mkr container with direnv/peco/ghq

version combination history
---
|version|MKR_VERSION|DIRENV_VERSION|PECO_VERION|GHQ_VERSION|
|---|---|---|---|---|
|0.11.2 - 0.11.3|0.11.2 - 0.11.3|2.8.1|0.3.6|0.7.4|

```
docker build -t mkr:<version> base/ --build-arg MKR_VERSION=0.11.3 --build-arg DIRENV_VERSION=2.10.0 --build-arg PECO_VERSION=0.4.7 --build-arg GHQ_VERSION=0.7.4
```
