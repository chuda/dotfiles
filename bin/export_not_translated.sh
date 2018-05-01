#!/bin/sh

cat $1 | awk '
/^msgid/ { lines = "";}
/^$/ { if (prev_line == "msgstr \"\"") print lines }
{
    lines = lines"\n"$0;
    prev_line = $0;
}

'
