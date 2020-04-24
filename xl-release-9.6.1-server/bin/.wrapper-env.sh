#!/bin/sh
#
# Commons for service wrapper related scripts
#

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

absdirname () {
  _dir="`dirname \"$1\"`"
  cd "$_dir"
  echo "`pwd`"
}

resolvelink() {
  _dir=`dirname "$1"`
  _dest=`readlink "$1"`
  case "$_dest" in
  /* ) echo "$_dest" ;;
  *  ) echo "$_dir/$_dest" ;;
  esac
}

# Get XL Release server home dir
if [ -z "$xlrelease_home" ] ; then
  self="$0"
  if [ -h "$self" ]; then
    self=`resolvelink "$self"`
  fi
  BIN_DIR=`absdirname "$self"`
  xlrelease_home=`dirname "$BIN_DIR"`
elif [ ! -d "$xlrelease_home" ] ; then
  echo "Directory $xlrelease_home does not exist"
  exit 1
fi
export xlrelease_home

cd "$xlrelease_home"

# path to wrapper home
wrapper_home="$xlrelease_home"/serviceWrapper
export wrapper_home

wrapper_jar="$wrapper_home"/wrapper.jar
export wrapper_jar

wrapper_java_sys_options=-Djna_tmpdir="$wrapper_home"/tmp
export wrapper_java_sys_options

wrapper_java_options="-Xmx30m"
export wrapper_java_options

wrapper_logging_file_options="-Djava.util.logging.config.file=$xlrelease_home/conf/logging.properties"
export wrapper_logging_file_options

# Get Java executable
if [ -z "$JAVA_HOME" ] ; then
  java_exe=java
else
  java_exe="${JAVA_HOME}/bin/java"
fi

javaVersion=$("$java_exe" -version 2>&1 | head -n 1 | cut -d'"' -f2 | cut -d'.' -f1,2)
javaMajorVersion=${javaVersion%.*}
javaMinorVersion=${javaVersion#*.}

if [ -z "$javaMajorVersion" ] || [ -z "$javaMinorVersion" ] ; then
    echo "Unable to determine java version"
    exit 1
fi

if [ "$javaMajorVersion" -lt 1 ] || ( [ "$javaMajorVersion" -eq 1 ] && [ "$javaMinorVersion" -lt 8 ] ) ; then
  echo "XL Release requires Java 1.8 or higher to be able to run"
  exit 1
fi

export java_exe

conf_file="$xlrelease_home"/conf/xlr-wrapper-linux.conf
export conf_file
