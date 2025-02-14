# OpenWhc

Project to visualize the WHC Sites collection in a interactive way

## Setup

Setup is pretty easy, make sure you have docker installed.
Then you can put the relevant env vars on the relevant file of your machine `.env.bat` or `.env.sh` for the build process and run:

For Windows:

```shell
  call .env.bat
```

For Linux:

```shell
  source .env.sh
```

After that you just have to put docker compose up

```shell
   docker-compose up --build
```
You can visit localhost:4000 and play with the explorer