# Flavorist

Small helper for creating and publishing git tags

<!-- toc -->

- [Introduction](#introduction)
- [Usage](#usage)
  * [Options](#options)
- [How it Works and Examples](#how-it-works-and-examples)
  * [Assumptions About The State of your Repo At Runtime](#assumptions-about-the-state-of-your-repo-at-runtime)
  * [Default Mode](#default-mode)
  * [Flavor Mode](#flavor-mode)

<!-- tocstop -->

## Introduction

Flavorist publishes the current HEAD of your local repository
as a tag with whatever name you provide.

Tagging in git is a mechanism for marking points in a project's
history as important, most commonly used for marking releases, usually
with a version number (Github's UI
even stores a repository's annotated tags under its "Releases" page)

More generically, though, tags give us references to specific commits.
This is useful not just for marking a point in a branches history e.g.
the point in master at which the project reached v1, but also for
marking extensions of or variations on a project that a user could optionally pull
in, also known as flavors or topics.

Flavorist aims to simplify creating and publishing tags, hopefully erasing
a few manual steps from your everyday gitting / repository management.


## Usage

_**WARNING** Before using this library, we'd advise reading the "Assumptions
About The State of your Repo At Runtime" section below. It might be totally familiar,
but could end up saving some confusion when running flavorist._

`flavorist <tag name> -m <message>`

- **tag name**: Reference name following [git's rules](https://git-scm.com/docs/git-check-ref-format).
flavorist will overwrite any tag of the same name (by using `git tag --force`)


- **-m, --message**: Message with which to annotate your tag. In flavor mode (see "Flavor Mode" section below), this will double as the commit message for the squashed commit
    - **DEFAULT**
        - **default mode** none, REQUIRED
        - **flavor mode** `(flavor) <tag name>-v<version>` (or just tag-name, if version omitted; also, note that the dash and v are included by flavorist)

### Options

- **-r, --remote** The remote repository to which you'll publish your new tag(s). In flavor mode,
this is also the repository whose target branch you'll reset to before tagging
  - **DEFAULT** `origin`

<br/>

- **-v, --version** Version number, to pair with a descriptive name set in the first arg position.
  When set, versioned and non-versioned tags, using the descriptive name as base, will be published
  e.g. `topic` and `topic-v1.0.0` (the dash and v are included by flavorist)
  - **DEFAULT** null

<br/>

- **-f, --flavor** Runs the tool in flavor mode (see "Flavor Mode" section below)
  - **DEFAULT** `false`

<br/>

- **-b, --branch** Branch you intend to extend with the new flavor tag (applied in flavor mode only)
  - **DEFAULT** `master`


## How it Works and Examples

### Assumptions About The State of your Repo At Runtime

<!-- TODO Expand this? -->

flavorist makes some assumptions about git's current state. If reality disagrees,
the tool could very well produce unexpected results.

We assume the following:

<!-- TODO what happens when you tag with changes in either tree? -->
- clean working tree and index
- your local repository's HEAD currently points at the commit you want to tag
OR, in flavor mode, you're on the branch whose difference from the branch specified
with the `-b` flag you intend to squash into a new commit that you'll then tag
- **flavor mode only**
    - your current branch is not `master` or whichever branch you'd specify with `-b`
    - your current branch is up to date with `master` or whichever branch you'd specify with `-b`
    i.e. merging it into `master` would only extend from `master`, not


### Default Mode

In its most basic form, you supply a name and you get a tag of that name published
to your project's remote `origin`.

For example,

```
flavorist v1.0.0 -m "We made it to v1.0.0!"
```

On running that command, assuming your local repository has a remote
named `origin` (flavorist's default for the `-r` flag, you should see, in your local
and remote repositories, a `v1.0.0` annotated tag with the message "We made it to v1.0.0!"  
pointing at the same commit at which your local HEAD's pointing.

This default mode corresponds to the practice of tagging points in `master` with a
version number.

If you instead wanted to give this release tag a descriptive name

```
flavorist bolognese-train -m "We made it to v1.0.0!" -v 1.0.0
```

You'd end up with 2 published tags, `bolognese-train` and `bolognese-train-v1.0.0`, both
pointing at the same commit.
On subsequent taggings, if you keep the name `bolognese-train`, but specify a new
version as your project progresses, the old, un-versioned tag would be replaced
with the new commit and you'd get a second, versioned tag.

```
flavorist bolognese-train -m "Chugging away, onwards and upwards!" -v 2.0.0
```

You'd now have the following tags:

- `bolognese-train`
- `bolognese-train-v1.0.0`
- `bolognese-train-v2.0.0`

Where `bolognese-train-v2.0.0` and `bolognese-train` point at the same, latest commit
while `bolognese-train-v1.0.0` points at the commit at your HEAD when you first created
the `bolognese-train` tag.

Note you can perform the above commands for any remote, not just `origin`:

```
flavorist v1.0.0 -m "We made it to v1.0.0!" -r named-remote
```

Now, the tag would be published to whichever repo `named-remote` specifies

### Flavor Mode

Flavor mode is suited for creating a tag by which you can extend a base branch.
This was inspired by the practice in the hapi pal boilerplate, where users can
extend the base boilerplate with flavors for various add-on functionality e.g.
automatic API documentation, ORM integration, templating, etc.
<!-- TODO cite this, link, okay w/ Devin -->

Basically, given a master branch (defaulting to `master`) and a topic (or
flavor) branch that's up to date with that master branch (contains all its
commits plus some of its own), flavorist does the following:

1. resets the current HEAD (flavor branch) to the master branch
    - this stages all changes across all flavor-specific commits i.e. summarizes
    the difference between flavor and master
2. moves into detached state
3. commits — the resultant commit is all flavor commits squashed into 1
4. tags and publishes as in default mode

Now, if you were to then `git cherry-pick` this tag onto your master branch,
you'd extend master with the entirety of your work in the flavor branch.
Since we're cherry-picking and the commit we're cherry-picking was separated from the
flavor branch i.e. has a separate history from the flavor branch, the only log
we introduce into master's history is the commit message you supplied to flavorist.

By tracking flavors in both tags and branches, we can partition
the public (tag) and private (branch) interfaces to our flavor code. We can
make updates to our flavor branch with total certainty
that our changes won't affect any random person using our flavor.
Tagging, then, becomes deploying for our flavors.
From the other side, any user can feel certain that, whenever they
cherry-pick (or otherwise apply; merging works, too!) a flavor, as
long as its tag hasn't changed since last use, they will receive the same code
as they did before.

Basic usage of flavor mode looks like:

```
flavorist -f vanilla -v 1.0.0
```

So, assuming you're on branch `flavor-vanilla`, you'd end up with 2 new tags,
`vanilla` and `vanilla-v1.0.0`, that each comprise the difference between
`flavor-vanilla` and `master`.
