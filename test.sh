# Ensure flavor and pal branch are up-to-date locally
# git checkout flavor-<name> # Go to the flavor branch
# git merge pal/pal # Ensure we're not squashing irrelevant changes, e.g. to the readme
# git push pal flavor-<name> # Push the updated flavor branch

## Currently works for sh ../test.sh swagger 2.1.2

name=$1
version=$2
origin='origin'
master='pal' # TODO Set default to master


# TODO Note that resetting, detaching, adding, and committing
# Is wanted only when not tagging on master / tagging separately???
# Reset needed only if tag is in separate branch
# 

# See the changes as they appear on top of the main branch
git reset $origin/$master

# Leave the current branch– at this point we dont need to update any branch
git checkout --detach

# List updated files
# TODO Is this right?
git add --all

# Create the squashed commit
git commit -m "(flavor) $name v$version"

# Tag it with its version
git tag -a $name-v$version -m "(flavor) $name v$version"

# Tag it for convenience, overridding the previous
git tag --force -a $name -m "(flavor) $name v$version"

# Push versioned tag
git push $origin $name-v$version

# Remove single tagged commit on the pal repo—we're about to replace it!
git push --delete $origin $name

git push $origin $name
