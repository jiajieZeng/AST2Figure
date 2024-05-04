#!/bin/sh
lexer_g4="$1"
parser_g4="$2"

# 检查参数数量
if [ $# -ne 2 ]; then
    echo "Usage: $0 <input_lexer_g4> <input_parser_g4>"
    exit 1
fi

java -jar antlr-4.13.1-complete.jar  # 启动org.antlr.v4.Tool
java -cp antlr-4.13.1-complete.jar org.antlr.v4.Tool $lexer_g4 -visitor
java -cp antlr-4.13.1-complete.jar org.antlr.v4.Tool $parser_g4 -visitor

javac -cp antlr-4.13.1-complete.jar ./*.java