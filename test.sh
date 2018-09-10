# Ensure flavor and pal branch are up-to-date locally
# git checkout flavor-<name> # Go to the flavor branch
# git merge pal/pal # Ensure we're not squashing irrelevant changes, e.g. to the readme
# git push pal flavor-<name> # Push the updated flavor branch

## Currently works for sh ../test.sh swagger 2.1.2

name=$1
shift

version=
remote='origin'
master='master'


while [ "$1" != "" ]; do
    case $1 in
        -v | --version )   version=$2
                           ;;

        -r | --remote )    remote=$2
                           ;;

        -m | --master )    master=$2
                           ;;
    esac
    shift
done

tag_name=$name
# if not null
if [ -n "$version" ]
then
  tag_name="$tag_name-v$version"
fi

# Replaces dash with empty space
tag_message="${tag_name/[-]/ }"


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
#TODO Is this the right format for the tag here?
# TODO How should we handle commit messages?
git commit -m "(flavor) $tag_message"

# Tag it with its version
git tag -a $tag_name -m "(flavor) $tag_message"

# Tag it for convenience, overridding the previous
# TODO How should this be generalized, creating 2 tags? flavor and history modes??
git tag --force -a $name -m "(flavor) $tag_message"

# Push versioned tag
git push $origin $tag_name

# Remove single tagged commit on the pal repo—we're about to replace it!
git push --delete $origin $name

git push $origin $name

exit 0;
