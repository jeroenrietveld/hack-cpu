#!/bin/bash

ghdl -a --workdir=work src/$1.vhd
ghdl -e --workdir=work $1

ghdl -a --workdir=work tb/$1_tb.vhd
ghdl -e --workdir=work $1_tb

ghdl -r --workdir=work $1_tb --fst=$1.fst
