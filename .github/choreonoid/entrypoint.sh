#!/usr/bin/env bash

export HRPSYS_DIR="$WORKSPACE_INSTALL_DIR/share/hrpsys/samples"
alias clear_omninames=$HRPSYS_DIR/RHPS1/clear-omninames2.sh

cd_hrpsys() {
  cd $HRPSYS_DIR
}

list_robots()
{
echo "Available robots and projects in : $HRPSYS_DIR"
cd $HRPSYS_DIR
find . -name '*.cnoid'
cd -
}

run_choreonoid() {
  robot=$1
  project=$2
  if [ ! -d "$HRPSYS_DIR/$robot" ]; then
    echo "Robot $robot does not exist in $HRPSYS_DIR"
    return 1
  fi
  if [ ! -f "$HRPSYS_DIR/$robot/$project" ]; then
    echo "Project $project does not exist for robot $robot in $HRPSYS_DIR"
    return 1
  fi
  cd $HRPSYS_DIR/$robot
  ./clear-omninames2.sh
  choreonoid $project --start-simulation
  cd -
}

help()
{
  echo "-----------------"
  echo "Welcome to choreonoid-private image for $UBUNTU_VERSION!"
  echo ""
  echo "This image contains choreonoid, mc_rtc, mc_udp, and all private robots available at AIST and LIRMM"
  echo ""
  echo "To interact with the choreonoid instance in this image, it is recommended to use "
  echo "mc_udp in another container"
  echo ""
  echo "CONFIDENTIALITY NOTICE: Do not share this image to unauthorized users"
  echo "-----------------"
  echo ""
  echo "To use this image:"
  echo "$ xhost +local: # for X11"
  echo "$ podman run -it --env=\"DISPLAY=${DISPLAY}\" --volume=\"/tmp/.X11-unix:/tmp/.X11-unix:rw\" \\"
  echo "  ghcr.io/isri-aist/choreonoid-private:jammy-standalone-release-latest <command>"
  echo ""
  echo "  where <command> is:"
  echo ""
  echo "      <none>  				  runs an interactive shell (does nothing if already in a shell)"
  echo ""
  echo "      help  				  shows this help"
  echo ""
  echo "      run_choreonoid			  <robot> <project>    runs a choreonoid project"
  echo "                                          ex: choreonoid RHPS1 sim_mc_upd.cnoid"
  echo ""
  echo "      list_robots		          list all available project and robot"
  echo ""
  echo "      cd_hrpsys  			  goes to the hrpsys samples directory where projects are located"
  echo "                			  HRPSYS_DIR=$HRPSYS_DIR"
  echo ""
  echo "      clear_ominames  			  reset the omniname name server (done automatically)"
  echo ""
}

help
