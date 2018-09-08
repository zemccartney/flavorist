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

- [] Read as much as you can
- [] Write a very basic README, try to write through your thinking
- [] Work through test manually, on a fork
- [] Get basic shell script running
    - [] Can take input and store in variables
    - [] Variables work in string building
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

## QUESTIONS

- [] What does this do? `git reset pal/pal`? What happens if I skip? Detach from ...
    ...OK!!! YOU COULDN'T CREATE A NEW COMMIT

- [] Why do we create flavors in commits separate from main history / flavor branch history?

- [] What's a shebang? Why do I care?

- [] How generalizable is our process? What are common tagging processes? merge into master,
then tag commit in master

- [] Is git reset optional if tagging on the same branch i.e. not branching, then tagging?
What happens in this case? How does the tag display in repo history?
## RESOURCES

https://gist.github.com/bclinkinbeard/1331790
https://github.com/mafintosh/benny-hill (executing a shell script w/ js)


## READING

https://git-scm.com/book/en/v2/Git-Basics-Tagging
https://www.atlassian.com/git/tutorials/inspecting-a-repository/git-tag
https://git-scm.com/docs/git-tag
https://nvie.com/posts/a-successful-git-branching-model/
https://jeffkreeftmeijer.com/git-flow/
https://softwareengineering.stackexchange.com/questions/165725/git-branching-and-tagging-best-practices
https://stackoverflow.com/questions/10376206/what-is-the-preferred-bash-shebang
http://www.fks.com/default.html
