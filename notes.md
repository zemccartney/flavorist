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


VERSIONING ALLOWS IDENTIFYING THE EXTENSION YOU'RE USING, IDENTIFYING
WHAT CODE YOU'RE PULLING IN AND EXPLAINING DIFFERENCES IF YOU SEE ANY...
(explain this better, still unclear)

## TODOs

- [x] Read as much as you can
- [x] Write a very basic README, try to write through your thinking
- [x] Work through test manually, on a fork
    - accidentally did git reset WRONG ORIGIN BRANCH (origin/master, not origin/pal).
    What the fuck happened? How would you recover?
- [] Get basic shell script running — TAILORED TO OUR PROCESS ONLY
    - [] Can take input and store in variables
    - [] Variables work in string building
    - [] Add linting
- [] Read and write some more
- [] Try to answer the questions below
- [] Polish the script, make it better
    - [] error handling?
    - [] sensible defaults?
    - [] prompts?
    - [] logging?
    - [] WRAP IN NODE, MAKE USABLE VIA NPX
    - [] help option and page!! https://github.com/alanshaw/david/blob/master/bin/usage.txt
    - [] write tests? overkill?
- [] Polish the README
    - [] Ask Devin about publicizing and explaining flavoring?

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

- [] Why do we create flavors in commits separate from main history / flavor branch history?

- [] What's a shebang? Why do I care?

- [] How generalizable is our process? What are common tagging processes? merge into master,
then tag commit in master

- [] Is git reset optional if tagging on the same branch i.e. not branching, then tagging?
What happens in this case? How does the tag display in repo history?


- [] Is this command necessary? `git fetch pal --tags` (docs explain it's just the manual step)

- [] Fetch vs. pull?
- [] What does detached HEAD mean?

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
https://jeffkreeftmeijer.com/git-flow/
https://softwareengineering.stackexchange.com/questions/165725/git-branching-and-tagging-best-practices
https://stackoverflow.com/questions/10376206/what-is-the-preferred-bash-shebang
http://www.fks.com/default.html


https://git-scm.com/book/en/v2/Git-Tools-Reset-Demystified




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
