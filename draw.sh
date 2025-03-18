#!/usr/bin/env bash 

GRAMMAR_FILE="$1"

mkdir -p out/

antlr4 -atn -Xforce-atn -Xlog $GRAMMAR_FILE -o out/

# for file in *.dot; do
#     output="${file%.dot}.png"
#     dot -Tpng "$file" -o "$output"
# done

# mkdir -p dot/ 
# mkdir -p png/ 

# mv *.dot dot/ 
# mv *.png png/ 