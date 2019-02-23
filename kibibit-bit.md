---
title: "@kibibit/bit documentation"
authors:
 - Neil Kalman
layout: default
id: kibibit-bit
permalink: /kibibit-bit
---

# @kibibit/bit

@kibibit/bit is a **git-flow + GitHub** replacement for **git and git flow**

git flow is great but it has much more missing to work against github considering
it's a method for projects with "scheduled release cycle"

Some missing things:
- Work with pull requests on GitHub (for now. later we'll support more cloud gits)
- Finishing a feature should open a PR instead of merging it locally to master
- Initialization of a project (adding the necassery branches)
- Creating a github project when `git init` a project
- Integrate github with a set of corisponding tools for release and stuff
- Support for convensional commit messages
- Support for generating an automatic changlog

**As a general rule**: This should make creating kibibit projects (and 
hopefully other people's projects) easy to create with all hooks and stuff
as
```bash
kibibit init
# or bit init
```

## Existing solutions and external documentation

- [gitflow](https://github.com/nvie/gitflow) (original gitflow extension)
- [Introducing GitFlow](https://datasift.github.io/gitflow/IntroducingGitFlow.html)
- [HubFlow: Tool for gitflow and GitHub][https://datasift.github.io/gitflow/] (not maintained anymore)
- [gitflow workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow)
- [gitflow cheatsheet](https://danielkummer.github.io/git-flow-cheatsheet/)

## Some lessons learned from `tdd1t`

Basically, two different flows can be used:

- rebase every pull request into master (keeping all commits intact)
- merge and squash the commits into a single "PR" commit for each PR

With `tdd1t`, we used the first option, which looked like it was recieved
poorly becuase the team needed to maintain **conventional commit messages
for all commits in a branch**. I think it's better to go with the second option,
which will force keeping only pull request title's and descriptions to conventions.

This might be a bit harder since it will require a github integration with
pull requests' webhooks in order to keep PR title + body to conventions instead of a githook.

This can be done with a [probot bot installation](https://probot.github.io/apps/semantic-pull-requests/),
we just need to check that it supports configuration and if not, add it.

## Project "Gotch'a"s

Some things we need to consider while writing this:

- Should be easily mainainable, preferrably with tests and such
- Should work as a command line tool, and as a npm library
  > We need to write functions that will corespond to specific cli commands
  > that can take the flow and work with it **without the extra command line question steps**.
- Should save sensitive data in appropriate locations (like keychain)
- Should be as easy to integrate with as possible
  > We should support customization for advanced users, but also lots of defaults or user prompts
  > for first time users.

## Supported Commands

### Initialization `kibibit init`

kibibit\bit should have an `init` command which will:

- create a git repo and support command line params used by `git init`
- should make sure this repo has a GitHub remote, and if not, ask to create it
- Should configure a specific login account for this repo and github.
  > Basically, with `git`, you can have a user per project
- should ensure that the two `gitflow` branches exist (master & develop by default)
- should install a `.kibibit` file in the root of the repo with specific configurations
  > all configuration should be split between two places: the `.git` folder, and `.kibibit`.
  > `.kibibit` will basically hold configuration we want to make **consistant** since
  > `.git` folder is not being commited.
  > for example: the user to use should **not be consistant** becuase it can change locally,
  > but which branch is "production" and which one is "develop" should be kept in `.kibibit`,
  > and updated inside the `.git` folder on initial use.

Currently, we'll support `node` applications specifically. So, these `node` integrations
can also be initialized here:

- create a `package.json` with all the attributes we know (remote repo, name, etc.)
- install [husky](https://github.com/typicode/husky) for git hooks
- install `kibibit`'s git hooks (need to understand which one's we need :-))

### Clone `kibibit clone`

Should clone a git repository and also install all kibibit/bit tools (like hooks)
and stuff. Also, update some `.git` config params based on the `.kibibit` file.

### Commit `kibibit commit`

Should allow commits on all bracnehs besides `master` and `develop`.
Will support command line params OR opening an editor to create a commit message.

### Status `kibibit status`

Pretty much the same as `git status`. should show files in staging area and
unstaged files, and maybe some info about which feature you're working on
(connected github issue & PR status \ PR if exists)

### Feature `kibibit feature`

start or continue a feature (will be prompted). If no featureName is given, returns all ongoing features

### Hotfix `kibibit hotfix`

start or continue a hotfix (will be prompted). If no hotfixName is given, returns all ongoing hotfixes

### Finish `kibibit finish`

use GitHub to issue a pull request to origin/develop.

### Update `kibibit update`

keep up-to-date with completed features on GitHub.

Should this happen automatically? what about conflicts?

### Save `kibibit push` OR `kibibit save`

(the oposite of update)

push your current feature branch back to GitHub as you make progress and want to save your work

### Checkout shared branches `kibibit master` AND `kibibit develop`

checkout master or develop branches. should use the configured branch names
from `kibibit init` which should be located in `.kibibit` and `.git`.

These branches should not allow direct commits (maybe later we'll allow it for admins based on github).
