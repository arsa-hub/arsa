#!/bin/bash
# use testnet settings,  if you need mainnet,  use ~/.arsacore/arsad.pid file instead
arsa_pid=$(<~/.arsacore/testnet3/arsad.pid)
sudo gdb -batch -ex "source debug.gdb" arsad ${arsa_pid}
