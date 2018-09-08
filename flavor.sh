#!/usr/bin/env bash

## Given you're
# Prompt the user?
# This command assumes you're on the branch at the point
# At which you want to update, including, we assume,
# having synchronized this branch with master, if needed, and clean working tree
# In a git repository of the project (git's a prereq, shocker :) )

## two args
# flavor name
# new version

# Which flavor are we updating? What's it's name?
# What version are we updating to?
# (optional) Which branch do we consider the variant / origin
# e.g. flavorist {{ name }} {{ version }} -o (--origin) (defaults to origin) -m (--master)

# Setup configuration
#
# O = origin if not --origin
# M = master if not --master
# V = version
# N = name

# if origin / master specified? Or if current branch !== master?
git reset pal/pal
#

git checkout --detach

# if origin / master specified? Or if current branch !== master?
git add --all
#

git commit -m "(flavor) $N v$V"

# TODO Allow customizing messages? Prompt? Take advantage of git's built-in prompt?
git tag -a $N-v$V -m "(flavor) $N v$V"
git tag --force -a $N -m "(flavor) $N v$V"

git push $O $N-v$V # Push versioned tag
# TODO What happens if this is a new flavor, no flavor to delete?
git push --delete $O $N # Remove single tagged commit on the pal repo—we're about to replace it!
git push $O $N



####### ***$$$$$$$$$$$$$$$**** ########

git reset pal/pal # See the changes as they appear on top of the main pal branch
git checkout --detach # Leave the current branch– at this point we dont need to update any branch
git add ... # List updated files
git commit -m "(flavor) <name> v<major>.<minor>.<patch>" # Create the squashed commit

git tag -a <name>-v<major>.<minor>.<patch> -m "(flavor) <name> v<major>.<minor>.<patch>" # Tag it with its version
git tag --force -a <name> -m "(flavor) <name> v<major>.<minor>.<patch>" # Tag it for convenience, overridding the previous


# WHAT DOES pal REFER TO HERE????
git push pal <name>-v<major>.<minor>.<patch> # Push versioned tag
git push --delete pal <name> # Remove single tagged commit on the pal repo—we're about to replace it!
git push pal <name> # Push the single tagged commit up to the pal repo
