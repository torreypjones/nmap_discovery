#!/bin/bash


NETWORKS=""
 
while getopts "n:" opt; do
  case $opt in
    n)
      echo "-n was triggered, Parameter: $OPTARG" >&2
	NETWORKS=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done


mkdir output 2>&1 > /dev/null || echo "output directory already exists"

myDate=$(date +%Y-%j)

mkdir output/$myDate 2>&1 > /dev/null || echo "output directory already exists"
mv -f output/current* output/$myDate
nmap -vvvvv -o -PE -PP -sS -sV -T5 $NETWORKS --webxml -oA output/current 2>&1 | tee -a output/current.log
