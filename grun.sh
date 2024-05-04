#!/bin/sh
input_file="$1"
output_file="$2"
# 检查参数数量
if [ $# -ne 2 ]; then
    echo "Usage: $0 <testSysY.txt> <output_file.ps>"
    exit 1
fi
java -cp .:$PWD/antlr-4.13.1-complete.jar org.antlr.v4.gui.TestRig SysY compUnit -gui -ps $output_file < $input_file