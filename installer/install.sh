set -e
set -u

set +e
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'FreeBSD' ]]; then
   platform='freebsd'
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='osx'
fi

if [[ $platform == 'osx' ]]; then
  #DETECT OSX VERSION
  OSX_VERSION_CHECK=`sw_vers | grep ProductVersion | cut -f 2 -d ':'  | egrep '10\.8|10\.9'`

  if [ $? != 0 ]; then
      echo 'You must be on Mountain Lion or greater!'
      exit 1
  fi
  set -e

  if [ ! -f /usr/bin/gcc ]; then
    printf "%s\n" $'
  You need to have Xcode with Command Line Tools installed before you can
  continue.

    1. Go to the App Store and install Xcode.
    2. Open Terminal.app
    3. Type `xcode-select --install`
    exit 1
  fi

  # show the banner and wait for a response
  printf "%s" $'\e[1;32m
    _____       _ _       
   |  __ \     (_) |      
   | |__) |__ _ _| | ___  
   |  _  // _` | | |/ _ \ 
   | | \ \ (_| | | | (_) |
   |_|  \_\__,_|_|_|\___/ \e[1;31m
      <%= view.user_org.upcase if view.user_org %>
  \e[0m
      Hello! I\'m going to set up Railo on this machine for you. It might take me a bit
      of time before I\'m done, but you\'ll end up with the best CFML environment for your machine.
  \e[0;1m
      Ready to get started? Press any key to continue.\e[0m'
  read -n 1 -s

  # prompt for sudo access. if correct we're good to go.
  echo "

  --> For added privacy invasion I'll need your local account's password."
  sudo -p "    Password for sudo: " echo "    Sweet, thanks. I'll see you in Vegas, sucker."

  echo "
  --> Making sure /opt/railo exists and belongs to you."

  sudo mkdir -p /opt/railo
  sudo chown $USER:staff /opt/railo

  if [ ! -f /opt/railo/.snapshot ]; then
    echo
    echo "--> Grabbing Latest Railo Express for Mac and arranging things. Be patient this may take a while."

    git clone https://github.com/joshuairl/railo_express_for_mac.git /opt/railo
  fi

  echo "
  --> Finalizing installation..."

  echo "source /opt/railo/env.sh" >> "~/.profile"

  cd $HOME

  echo "
  You're good to go! Make sure to source /opt/railo/env.sh in your
  shell config if you want all the good stuff to work.
  "
elif [[ $platform == 'freebsd' ]]; then

elif [[ $platform == 'linux' ]]; then

fi