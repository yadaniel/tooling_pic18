#!/bin/bash

set -x

# MPLABX and IPE version => 6.10
#
# -F option does not work => hex is found, cannot be read
# java -jar ipecmd.jar -TPPK4 -P18F4550 -F${HEXFILE} -M -OB
# -M option unused
# TPPK4 = programmer pickit4
# -GFtmp_.hex = read memory from target, requires admin right to save file
# -OB = batch mode => not needed
# -OL = release from reset, default hold in reset
# -OE = erase flash
# -W = power target from tool, default externally powered target
# -W4.7 = power with 4.7V
# -Y = verify device, default no verify
# -Y[PEICBA] = verify memory region, without region verify all memories
# -Z = preserve EEPROM on program, default no preserve

# serial number of pickit4
PK4=BUR183119556

# relative path -> absolute path ... in cygwin convention
HEXFILE_TMP=$(readlink -f ./dist/default/production/*.X.production.hex)

# convert to mixed or windows path convention
HEXFILE=$(cygpath -m ${HEXFILE_TMP})
# HEXFILE=$(cygpath -w ${HEXFILE_TMP})

# hexfile normalization or merging not needed
# hexmate.exe ${HEXFILE} -otmp.hex

# change into IPE installed directory for proper reference to libs
cd "C:\Program Files\Microchip\MPLABX\v6.10\mplab_platform\mplab_ipe"

# debug only => alternative use set -x
# echo "pwd => " $(pwd)
# echo "hex => " ${HEXFILE_TMP}
# echo "hex => " ${HEXFILE}
# cat ${HEXFILE}
# ipecmd.exe -?
# exit

# erase works, readout works with admin rights
# java -jar ipecmd.jar -TPPK4 -P18F4550 -E
# java -jar ipecmd.jar -TPPK4 -P18F4550 -GFtmp_.hex

# NOTE: only worked after full PC restart
# relative file reference does not work => use fullpath
# ipecmd.exe -TPPK4 -P18F4550 -E -M -ftmp.hex -OL
# ipecmd.exe -TPPK4 -P18F4550 -E -M -fC:/_test/tmp.hex -OL

# java -jar does not work => exe works
ipecmd.exe -TPPK4 -P18F4550 -E -M -YP -f${HEXFILE} -OL
# java -jar ipecmd.jar -TPPK4 -P18F4550 -E -M -f${HEXFILE} -OL

