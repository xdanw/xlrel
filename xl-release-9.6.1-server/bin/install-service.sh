#!/bin/sh
#
# Shell script to install XL Release Server as a daemon
#

DIR=$( cd "$( dirname "$0" )" && pwd )
. "$DIR"/.wrapper-env.sh

echo "Installing into $xlrelease_home"
if echo $xlrelease_home | grep -q " "; then
    echo "XL Release needs to be installed in a path that does not contain spaces, but current path has them: '$xlrelease_home'."
    exit 1
fi

if [ ! -f "conf/xl-release-license.lic" ]; then
    echo "A license is required in order to be able to install the XL Release Server as a daemon."
    exit 1
fi

if [ ! -f "conf/xl-release.conf" ]; then
    echo "The XL Release server is not initialized. Please execute the run.sh script!"
    exit 1
fi

read -p "Please provide the user that will run XL Release Server: " user
export user

# install daemon/ service
"$java_exe" "$wrapper_java_options" "$wrapper_logging_file_options" "$wrapper_java_sys_options" -jar "$wrapper_jar" -i "$conf_file"
"$java_exe" "$wrapper_java_options" "$wrapper_logging_file_options" "$wrapper_java_sys_options" -jar "$wrapper_jar" -t "$conf_file"


echo ""
echo "Please make sure the server is configured so that it can start without input from the user"
echo "(e.g. if a repository keystore password is required then it should be provided in xl-release.conf)."
