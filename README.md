
# DISCLAIMER — PROJECT IS UNDER CONSTRUCTION

**PLEASE BE AWARE THAT THE BELOW README IS ALMOST ENTIRELY ASPIRATIONAL,
WRITTEN IN THE SPIRIT OF:
THIS TOOL IS UNSTABLE AND WILL PRODUCE POTENTIALLY UNEXPECTED OR REPUGNANT
RESULTS IF USED ON YOUR PROJECT; STABLE RELEASE COMING SOON.
IN THE MEANTIME, ANY AND ALL FEEDBACK IS WELCOME AND APPRECIATED!!**


# Flavorist

<!-- TODO not quite it-->
Small helper for creating and publishing a new git tag

## Introduction

Flavorist publishes the current HEAD of your local repository
as a tag with whatever identifier you provide.

Tagging in git is a mechanism for marking points in a project's
history as important, most commonly used for marking releases, usually
with a version number (Github's UI
even stores a repositories tag under its "Releases" page)
<!-- TODO are releases annotated, tags lightweight? TEST!!
WRONG! What are releases in Github?
-->

More generically, though, tags give us references to specific commits.
This is useful not just for marking a point in a branches history e.g.
the point in master at which the project reached v1, but also for
marking extensions of or variations on a project that a user could optionally pull
in, also known as flavors.

Flavorist aims to simplify creating and publishing tags, hopefully erasing
a few manual steps from your everyday gitting / repository management.

<!-- TODO 2 modes? flavor and release? -->


# Usage

_**WARNING** Before using this library, we'd advise reading the "Assumptions
About The State of your Repo At Runtime" section below. It might be totally familiar,
but could end up saving some confusion when running flavorist._


In its most basic form, you supply a name and you get a tag of that name published
to your project's remote `origin`.

<!-- TODO Any constraints on tag names in git? -->
```
flavorist v1.0.0
```

Flavorist assumes:
- you want to push to the remote `origin`
- you want to overwrite any existing tag with the provided name
- you want the tag present in the current branch's history <!-- TODO What does this mean? -->

This default mode corresponds to the practice of tagging points in `master` with a
version number.

<!-- NOTE default mode is to create an annotated tag; is that right? -->

```
flavorist -f v1.0.0
flavorist -f vanilla -v 1.0.0
flavorist -f vanilla -v 1.0.0 -o remote -b swasster
```





## Assumptions About The State of your Repo At Runtime

Flavorist makes some assumptions about git's current state. If reality disagrees,
the tool could very well produce unexpected results.


## How it Works

Flavorist takes the current HEAD, detaches it, commits its
state, tags the commit twice – with a provided descriptive
name and with said name plus a provided version number — then publishes
both to the project's remote repository.

The commit is not a part of the project's history, referencible only through its
SHA or its tag

The end result is that your repository now contains references
