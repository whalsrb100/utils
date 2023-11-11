#!/bin/bash
############################
#####  Except Process  #####
############################
Prefix=${1}
function prefixHelp() {
        echo "Usage: ${0} [PREFIX NUMBER]"
        exit 1
}
if [[ ${Prefix} -lt 0 ]] || [[ ${Prefix} -gt 32 ]]; then
        prefixHelp
fi
############################

############################
##### 1. My Calculator #####
############################
fullValue=0
for i in $(seq 0 $(expr ${Prefix} \- 1)); do
        fullValue=$(( fullValue + $(( 1 << i )) ))
done
addshift=$(expr 32 \- ${Prefix} )
fullValue=$(( fullValue << addshift ))
result=(
        $(( $(( fullValue & $(( 255 << 24 )) )) >> 24 ))
        $(( $(( fullValue & $(( 255 << 16 )) )) >> 16 ))
        $(( $(( fullValue & $(( 255 <<  8 )) )) >>  8 ))
        $(( $(( fullValue & $(( 255 <<  0 )) )) >>  0 ))
)
############################

############################
##### 2. Print  Result #####
############################
for i in $(seq 0 3);do
        echo -n ${result[${i}]}.
done | sed 's/\.$/\n/'
############################

############################
##### Exit Calculator ######
############################
 exit 0
############################
