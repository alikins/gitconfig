#!/usr/bin/python

import fileinput
import re

FUNCNAME = r'''@@.*@@\sdef\s(.*)\(.*\)|@@.*@@\sclass\s(.*)\(.*\)'''
funcname_re = re.compile(FUNCNAME)

FILENAME_PATTERN = r'''^\+\+\+\s(.*)'''
filename_re = re.compile(FILENAME_PATTERN)


def process(line, filename):
    filename_match = filename_re.match(line)
    if filename_match:
        filename = filename_match.group(1)
    res = funcname_re.match(line)
    method_name = ''
    if res:
        method_name = res.group(1)
        #print method_name
    if method_name:
        return filename, method_name
        #return '%s: %s' % (filename, method_name)
    return filename, None


def main():
    filename = 'N/A'
    for line in fileinput.input():
        filename, method_name = process(line, filename)
        if method_name:
            print '%s: %s' % (filename, method_name)


if __name__ == "__main__":
    main()
