TODO [ ] Define flavors. What are they? Why?

- flavors are maintained in branches
    - key word is maintained: flavors as branches allows team to develop
    on flavors continuously AND INTERNALLY, without releasing

- flavors are RELEASED as single commits


You can achieve the same effect as cherry-pick with merge
ASSUMING that the current flavor tagged commit matches HEAD
of the current flavor branch. Which may or may not be true.

By tracking flavors in both tags and branches, we partition
the public and private interfaces to our flavor code. We can
make updates to one representation of a flavor with total certainty
that our changes won't affect any random person using our flavor.
From the other side, any user can feel certain that, whenever they
cherry-pick a flavor, as long as the current latest version of the flavor
matches the one used before, we will receive the same code on top of our
copy of the boilerplate repository

NOOOO!!!!! BECAUSE YOU CAN MERGE A TAG!!!!

VERSIONING ALLOWS IDENTIFYING THE EXTENSION YOU'RE USING, IDENTIFYING
WHAT CODE YOU'RE PULLING IN AND EXPLAINING DIFFERENCES IF YOU SEE ANY...
(explain this better, still unclear)

## TODOs

- [x] Read as much as you can
- [x] Write a very basic README, try to write through your thinking
- [x] Work through test manually, on a fork
    - accidentally did git reset WRONG ORIGIN BRANCH (origin/master, not origin/pal).
    What the fuck happened? How would you recover?
- [x] Get basic shell script running — TAILORED TO OUR PROCESS ONLY
    - [x] Can take input and store in variables
    - [x] Variables work in string building
    - [x] Add linting
- [x] Read and write some more
(experiment w/ tagging in history; creating, cherry-picking,)
- [x] Try to answer the questions below
- [] Expand the README
- [] Polish the script, make it better, make it match the README
    - [] error handling?
    - [] sensible defaults?
    - [] prompts?
    - [] logging?
    - [x] WRAP IN NODE, MAKE USABLE VIA NPX
    - [x] help option and page!! https://github.com/alanshaw/david/blob/master/bin/usage.txt
    - [] write tests? overkill?
    - [] CONTRIBUTING?
    - [] Add ref name validation? place in the shell script?
    - [] If -v given, but no version specified, parses package.json file and uses the version found there
- [] Polish the README
    - [] Ask Devin about publicizing and explaining flavoring?
    - [] shellcheck for shell linting

## QUESTIONS

- [] What does this do? `git reset pal/pal`? What happens if I skip? Detach from ...
    ...OK!!! YOU COULDN'T CREATE A NEW COMMIT, BECAUSE THERE'D BE NOTHING TO COMMIT
    - git reset points HEAD at specified ref, sets index to specified ref, sets working
    tree to diff from ref in the commit you'd been working on

- [] What does the publishing doc mean by squashing a commit, squash irrelevant changes?

We want to be sure that the flavor is synchronized with the branch onto which it will be applied
except for the modifications made for the flavor, so applying a flavor will only ever extend
the master branch, not extend, but also modify / revert in some ways to earlier points in history.
We want to treat flavors as branches from the HEAD of master, with their tags representing
standalone, public-facing interfaces for extending master (see above not about cherry-pick vs. merge)

- [] Is tagging just a human-friendly SHA marker? `git checkout SHA` or `git cherry-pick SHA`
is the same as `git checkout / cherry-pick tag` when tag applies to commit of SHA?

- [] Why do we create flavors in commits separate from main history / flavor branch history?
Why do we detach?

https://stackoverflow.com/questions/1241720/git-cherry-pick-vs-merge-workflow
cherry-pick COPIES the given commit, detaching it from its history
merging preserves the commit's history, pulling that into the current branch

For our purposes, where we detach, merging the tag wouldn't pull in any history,
as it's detached, so completely history-less (I believe?)

If we were to commit and tag on the flavor branch....wouldn't cherry-pick still work?
Theoretically? NO!!! Unless you committed the squashed commit on the branch, but..why?

Tagging on a branch ADDS THAT TAG to the branch's history...bad thing?

  commit 385affa6b853b8be155630755b6e21d7e1ecc56b (tag: v1.2.3, tag: swagger-v2.1.1, origin/pal, origin/HEAD, pal)

 [] Merging would add swagger's history to your main branch's history, right?

 Yup, merging adds 2 entries to your main branch's log
 - merge entry, which duplicates the commit message of the commit merged in
 - the commit merged in
So cherry-picking keeps history clean, creates a new commit, tacks it onto HEAD


But it's possible that a.) that commit in the branch's history goes away for some reason?
The branch moves, gets renamed, etc., so the commit is gone, so the tag fails?
Wouldn't git keep the tag around, though? So as long as you keep the tag, even if you
delete the branch it's on, you could still access the changes?

https://git-scm.com/book/en/v2/Distributed-Git-Maintaining-a-Project#_rebase_cherry_pick

We detach to defensively protect against failures / changes in the flavor dev
branch impacting client use? Make sure the public interface is totally separate
from our development environment??? (TODO **ASK ABOUT THIS**)
[x] NO!! Detaching squashes all changes together; cherry picking flavor head would bring the
changes introduced in JUST THAT COMMIT, not the entire body of changes. TEST THIS!!
    For example, cherry-picking the flavor branch results in the last change appearing
    in the current branch. In the tested case, that meant server/plugins/swagger.js was created,
    but it wasn't registered on the manifest or package.json i.e. none of its dependencies or wiring,
    changes introduced in other commits and required for that script to work, so cherry-picking ended
    up being useless

- [x] How does git cherry-pick work?
- [x] Why do we cherry-pick when we can also merge?
- [] What's a squashed commit?
    A single commit derived from multiple commits i.e. we squash the changes made across
    all commits into a single one. In our cases, for the purposes of allowing users to cherry-pick
    in the full branch history of our flavor without a.) cluttering their project's history
    with our flavor branch's history (merge) b.) still applying the entire difference between
    master and flavor


- [] What's a shebang? Why do I care?

- [] Should I not set git-tag as an .sh file? (https://mywiki.wooledge.org/BashGuide/CommandsAndArguments#Scripts)

- [] How generalizable is our process? What are common tagging processes? merge into master,
then tag commit in master

- [] Is git reset optional if tagging on the same branch i.e. not branching, then tagging?
What happens in this case? How does the tag display in repo history?


- [] Is this command necessary? `git fetch pal --tags` (docs explain it's just the manual step)

- [] Fetch vs. pull?
- [] What does detached HEAD mean?
- [] From shellcheck.net (https://www.shellcheck.net/) : Double quote to prevent globbing and word splitting. What does this mean?
- [] git tag -s? cryptographically signing tags?
- [] merge --no-ff? git log --graph is cool. What does fast-forwarding do? If merged is ancestor of current, we can move HEAD pointer on current to HEAD of merged and DO NOT NEED TO CREATE A
MERGE COMMIT, NO NEED TO RECORD, JUST EXTEND history vs. if no-ff, create a merge-commit as HEAD
of current, display in history all commits from merged and in graph display those commits as
separate from current (preserves history / branched status) https://stackoverflow.com/questions/9069061/what-is-the-difference-between-git-merge-and-git-merge-no-ff

## RESOURCES

https://gist.github.com/bclinkinbeard/1331790
https://github.com/mafintosh/benny-hill (executing a shell script w/ js)


## READING

https://git-scm.com/book/en/v2/Git-Basics-Tagging
- tagging is giving a name / reference to a commit
- There are 2 types of tags: annotated and lightweight
    - annotated: add a message, committer name / email, and object storage to the commit?
    - lightweight: nothing, just a pointer to the commit????
- Tagging is for marking points in history (or just any commit) as important /
relevant for later/ ongoing use
- you can also tag commits later!

https://www.atlassian.com/git/tutorials/inspecting-a-repository/git-tag
- key point: tags have no further history (unlike branches); they are just a static
snapshot of the state of files at a given point in history (commit)
- "By default, git tag will create a tag on the commit that HEAD is referencing."
    - What does this mean for this project? Do we care about this?
    - TODO For documentation purposes, MUST BE EXPLICIT ABOUT EXPECTED USAGE SCENARIO,
    THE STATE THAT GIT SHOULD BE IN FOR THIS TO WORK

https://git-scm.com/docs/git-tag
https://nvie.com/posts/a-successful-git-branching-model/
  - really like the constant master and develop branches, keeping those separate, their
  clear definitions.
  - not sold on the release branching and tagging process, at least for us
https://jeffkreeftmeijer.com/git-flow/
https://softwareengineering.stackexchange.com/questions/165725/git-branching-and-tagging-best-practices
https://stackoverflow.com/questions/10376206/what-is-the-preferred-bash-shebang
http://www.fks.com/default.html

https://git-scm.com/book/en/v2/Git-Tools-Reset-Demystified

https://github.com/koalaman/shellcheck/blob/master/README.md#user-content-gallery-of-bad-code
https://www.shellcheck.net/

## hpal new vs. clone: boilerplate installation

- Remote:
   - hpal --> pal
   - clone --> origin

- Branch:
   - hpal --> pal
   - clone --> pal

- Tags:
    - hpal --> all
    - clone --> all
