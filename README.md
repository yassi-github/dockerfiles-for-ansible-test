# Usage

## **DON'T forget to white github user name at Line 16 before running below.**

At the docker server "bastion", cd this file directory and run:  
```shell=
docker build -t ansible-test:init .
docker run -itd -p 50022:22 --privileged --name ansible-test-server ansible-test:init
```

Then, use ssh like:
```shell=
ssh -i ~/.ssh/id_rsa -p 50022 test@localhost
```

or

```shell=
ssh -i ~/.ssh/id_rsa test@172.17.0.2
```

