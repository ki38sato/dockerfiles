Terraform Local Environment
---
terraform container with direnv/peco/ghq

version combination history
---
|version|TERRAFORM_VERSION|DIRENV_VERSION|PECO_VERION|GHQ_VERSION|
|---|---|---|---|---|
|0.6.16|0.6.16|2.8.1|0.3.6|0.7.4|
|0.7.1 - 0.7.10, 0.8.4|0.7.0 - 0.7.10, 0.8.4|2.9.0|0.3.6|0.7.4|
|0.8.5|0.8.5|2.10.0|0.4.7|0.7.4|

```
docker build -t terraform:<version> base/ --build-arg TERRAFORM_VERSION=0.8.5 --build-arg DIRENV_VERSION=2.9.0 --build-arg PECO_VERSION=0.4.7 --build-arg GHQ_VERSION=0.7.4
```
