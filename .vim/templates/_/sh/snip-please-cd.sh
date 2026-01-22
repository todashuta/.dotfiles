if [ "$(pwd)" != "$(cd "$(dirname "$0")" && pwd)" ]; then
	echo 'Please cd to project diectory beforehand.' 1>&2
	exit 1
fi
