#!/bin/sh

# this is test for sub_function and return

echo() {
    echo $n
    test $((n / 2)) -gt 5 && return 1
    return 0
}
