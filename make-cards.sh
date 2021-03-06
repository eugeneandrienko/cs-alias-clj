#!/bin/bash

WORDS="words.txt"
PEOPLE="people.txt"
CS_ALIAS_CLJ="cs-alias-clj-1.0.0-SNAPSHOT-standalone.jar"

#Check - is words.txt or people.txt exists
if [ ! -e $WORDS ]; then
    echo "File $WORDS do not exist"
    exit 1
fi
if [ ! -e $PEOPLE ]; then
    echo "File $PEOPLE do not exist"
    exit 1
fi

#Check - there should be enough words in the file to fill at least one table 3x3x8
RESULT=$((`wc -l $WORDS | sed -r 's/([0-9]+) .*/\1/g'` / 72))
if [ "$RESULT" -eq "0" ]; then
    echo "Not enough words in the input file to generate at least one table 3x3x8"
    echo "Your should specify not less than 72 words in $WORDS"
    exit 1
fi
RESULT=$((`wc -l $WORDS | sed -r 's/([0-9]+) .*/\1/g'` / 72))
if [ "$RESULT" -eq "0" ]; then
    echo "Not enough words in the input file to generate at least one table 3x3x8"
    echo "Your should specify not less than 72 words in $PEOPLE"
    exit 1
fi

if [ ! -e $CS_ALIAS_CLJ ]; then
    lein deps
    lein uberjar
fi
java -jar $CS_ALIAS_CLJ
pdflatex alias.tex
echo
echo "Generated alias.pdf"
echo
