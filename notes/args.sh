# Ensure flavor and pal branch are up-to-date locally
# git checkout flavor-<name> # Go to the flavor branch
# git merge pal/pal # Ensure we're not squashing irrelevant changes, e.g. to the readme
# git push pal flavor-<name> # Push the updated flavor branch

## Currently works for sh ../test.sh swagger 2.1.2

name=$1
shift

version=
remote='origin'
master='master' # TODO Set default to master


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

echo $name $version $remote $master

tag_name=$name
# if not null
if [ -n "$version" ]
then
  tag_name="$tag_name-v$version"
fi

echo $tag_name
tag_message="${tag_name/[-]/ }"
echo $tag_message
