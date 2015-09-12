#!/bin/sh

ptrace_scope="$(cat /proc/sys/kernel/yama/ptrace_scope)"

if [ -z "${DISPLAY}" ]; then
   echo "You need to setup the DISPLAY and xauth stuff."
   echo "If your using sddm, then do something like:"
   echo "  sudo cp /var/runr/sddm/:0 foo"
   echo "  xauth merge foo"
   echo "  export DISPLAY=:0"
fi

if [ "$ptrace_scope" != "0" ]; then
   echo "Please run echo 0 > /proc/sys/kernel/yama/ptrace_scope as root"
   exit -1
fi

echo "========================================================================"
echo "Lets look at thread backtraces for the KDE Processes"
echo "========================================================================"
for prog in kwin_x11 kded5 plasmashell ksmserver kglobalaccled; do
   PROCESS_PID="$(ps auxwww | grep $prog | grep -v grep | grep -v kwrapper5 | awk '{print $2}')"
   if [ -n "${PROCESS_PID}" ]; then
      echo "================================================================"
      echo "================BT FOR $prog ($PROCESS_PID)"
      echo "================================================================"
      gdb --batch --quiet -p ${PROCESS_PID} -ex "thread apply all bt 100" -ex "quit"
   else
      echo "Error: Could not find PID for $prog"
   fi
done

echo "========================================================================"
echo "Lets look at responses from the qdbus components"
echo "========================================================================"
kde_bus_endpoints="$(qdbus | grep -v ':' | grep kde)"
for bus_ep in $kde_bus_endpoints; do
   echo ""
   echo "================================================================"
   echo "================Bus Response FOR $bus_ep"
   echo "================================================================"
   qdbus $bus_ep
done
