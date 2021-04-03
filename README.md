# Usage

Please input `GitHubUserName` and option `LoginName`(default: test)

```shell=
$ docker build -t ansible-test:init --build-arg GitHubUserName="<your github name>" --build-arg LoginName="<user name (default: test)>" .
$ docker run -d --privileged --name ansible-test-server ansible-test:init

# example
$ docker build -t ansible-test:init --build-arg GitHubUserName="yassi-github" --build-arg LoginName="piyo" .
```

Then, use ssh like:
```shell=
$ ssh -i ~/.ssh/id_rsa piyo@172.17.0.2
```
