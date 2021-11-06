#!/bin/bash
echo Just '>' ----------------------------------
find /etc -name grub >grub.out
echo Just '2>' ----------------------------------
find /etc -name grub 2>errs.out
echo Just '&>' ----------------------------------
find /etc -name grub &>both.out
