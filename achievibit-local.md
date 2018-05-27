---
title: Run Achievibit Locally
authors:
 - Neil Kalman
layout: default
id: achievibit-local
permalink: /achievibit-local
---

# Welcome!

We're so glad you're thinking about contributing to a `kibibit` open source project! If you're unsure or afraid of anything, just ask or submit the issue or pull request anyways. The worst that can happen is that you'll be politely asked to change something. We appreciate any sort of contribution, and don't want a wall of rules to get in the way of that.

Before contributing, we encourage you to read our **CONTRIBUTING** policy **(you are here)**, our **[LICENSE](LICENSE)**, our **[CODE OF CONDUCT](CODE_OF_CONDUCT.md)**, and our **[README](README.MD)**, all of which should be in this repository.

## Easy starting point
Our list of [Easy Picks](https://github.com/Kibibit/achievibit/labels/Easy%20Pick) include specific issues that are a good starting point for new contributors.

These are **easy to pick up tasks**, either because they are small in scope, or just don't involve much in-depth knowledge of the project.

Based on [Jordi Boggiano](https://github.com/Seldaek)'s [blog post](https://seld.be/notes/encouraging-contributions-with-the-easy-pick-label)

## General explanation

to run achievibit (locally or otherwise), you need three main things:

1. a database - achievibit expects to write and read data from a mongodb database.
   You can either create a real mongoDB, or use `monkey.js` to create a mock DB to run locally
2. achievibit's server - pretty self explanatory
3. a static public ip address - in order to connect achievibit to a github repository, you need to have a **url** you can paste into your webhook. On production, this is handled by our heroku hosting. To generate a static url, we use `ngrok` locally.

## Prerequisites

### Tools to install

This project is run on `node.js`. install node.js using [their site](https://nodejs.org/en/).
Besides that, nothing is required.

### Setting up database

There are 3 options for running achievibit with a database:
- locally run mongoDB
- mongoDB cloud service
- mock mongoDB

#### Locally Run MongoDB

The easiest way to do that, is to use **docker**.

1. [Install docker](https://docs.docker.com/install/)
2. Check that docker is installed by running `docker --version` in your command line
3. Create a folder on your machine in order to use that folder for the DB: `mkdir ~/data`
4. MongoDB conveniently provides us with an [official container](https://registry.hub.docker.com/_/mongo/):
   ```shell
   sudo docker run -d -p 27017:27017 -v ~/data:/data/db mongo
   ```
5. At this point, you should have a MongoDB instance listening on port 27017. Its data is stored in ~/data directory of the docker host.
6. your mongoDB uri is `localhost/achievibit`
7. If you want a visual UI to see the data in your mongoDB, your can install mongoUI (`npm i -g mongoui`) and run it (`mongoui`)

#### MongoDB cloud service **(recommended)**

You can use https://mlab.com/ to create one in the cloud.
If you're using `mlab`, you need to create a database, and then create a database user.
After creating a database, click on Users**-->**Add database user
![Users-->Add database user](/screenshots/create-db-user.png)

Now, go to your database homepage, and copy the database url. you need to enter your database username and password (**NOT YOUR MLAB ACCOUNT!**)

![mongodb url](/screenshots/mongodb-url.png)

#### Mock mongoDB

instead of running against a real DB, you can use our tests' mock DB with the cli param `--testDB`. This is less recommended since it means you don't test everything E2E. But it's the quickest method

### Setting up a static url

Create an account at https://ngrok.com/ so you can connect your local server to a **GitHub Repository**
> you'll need the **ngrok token**:
>
> ![ngrok token](/screenshots/ngrok-token.png)

## Getting Started

1. clone achievibit locally (we prefer using [ungit](https://github.com/FredrikNoren/ungit) or [gitkraken](https://www.gitkraken.com/))
2. run `npm install` to install all dependencies
3. Now we need to run achievibit. achievibit looks for variables in the following order:
   1. Command-line arguments
   2. Environment variables
   3. A file located at the root of the project called `privateConfig.json`
   You can run the command line with the `--savePrivate` argument, which will save the `privateConfig.json` file locally for you with the params you passed.
   Run the following command, replacing all the urls we got in the **prerequisites** step:
   ```shell
   node index.js --databaseUrl "<mongodb-url>" --ngrokToken "<ngrok-token>"
   ```
   If you chose to run locally without a database, use the following command:
   ```shell
   node index.js --testDB --ngrokToken "<ngrok-token>"
   ```
   > To set global variables: In Unixy environments: `export ngrokToken="<ngrok-token>"` || In Windows **powershell**: `$env:ngrokToken="<ngrok-token>"`

4. if everything worked, you should see the `achievibit` logo, and an **ngrok url** under it.
5. follow the instructions in the [`README.MD`](/README.MD) file to connect a test repository to your local achievibit (replace the url with your ngrok url). Make sure **Content type** is set to **application\json**
> ![connect repo](/screenshots/connect-to-repo.png)

6. check that the achievement works on your database (your user got your achievement on your test repository).
if your achievement requires interaction with another user, talk to one of the developers and we'll help test it (reviewing a test pull request, etc.).

## Seeing logs
Other then seeing the **logs** in your `console`, you can access your logs from anywhere on `<ngrok_url>/logs`.
See [Supported Params](#supported-params) for more info

## Supported params
`achievibit` supports the following params:
- `--databaseUrl` **OR** `--testDB` (required) - either set-up achievibit against a real DB or a mock DB
- `--ngrokToken` (required) - needed in order to connect to GitHub for testing
- `--logsUsername` - set a username to the logs
- `--logsPassword` - set a password to the logs (without the username, this is ignored)
- `--stealth` - if you don't want to print the logo in the terminal. Useful when running in `watch` mode and you don't want the server to print the achievibit logo each time it restarts
- `--githubUser` - `GitHub` user to make requests with
- `--githubPassword` - `GitHub` password to make requests with

## Running tests (WIP)

Currently, only unit-tests are implemented. To run them locally, run `npm test`
