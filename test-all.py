#!/bin/python
#
# File: test-all.py
# Authors: Leonid Shamis (leonid.shamis@gmail.com)
#          Keith Schwarz (htiek@cs.stanford.edu)
#
# A test harness that automatically runs your compiler on all of the tests
# in the 'samples' directory.  This should help you diagnose errors in your
# compiler and will help you gauge your progress as you're going.  It also
# will help catch any regressions you accidentally introduce later on in
# the project.
#
# That said, this test script is not designed to catch all errors and you
# will need to do your own testing.  Be sure to look over these tests
# carefully and to think over what cases are covered and, more importantly,
# what cases are not.

import os
from subprocess import *

TEST_DIRECTORY = 'samples-small'

for _, _, files in os.walk(TEST_DIRECTORY):
  for file in files:
    if not file.endswith('.decaf'):
      continue
    refName = os.path.join(TEST_DIRECTORY, '%s.out' % file.split('.')[0])
    testName = os.path.join(TEST_DIRECTORY, file)
    inputName = os.path.join(TEST_DIRECTORY, '%s.in' % file.split('.')[0])

    print 'Executing test "%s"' % testName

    # Run dcc.  If we get no errors, try running the rest of the stack.
    dcc = Popen('./dcc < ' + testName + ' > tmp.asm', shell = True, stderr = STDOUT, stdout = PIPE)
    dcc.wait();

    if dcc.returncode == 0:
      # If there is a stdin file, run the program using that input.  Otherwise do nothing.
      if os.path.exists(inputName):
        result = Popen('/usr/class/cs143/bin/spim -file tmp.asm < ' + inputName, shell = True, stderr = STDOUT, stdout = PIPE)
      else:
        result = Popen('/usr/class/cs143/bin/spim -file tmp.asm', shell = True, stderr = STDOUT, stdout = PIPE)

      # Diff the outputs.
      result = Popen('diff -w - ' + refName, shell = True, stdin = result.stdout, stdout = PIPE)
      print ''.join(result.stdout.readlines())
    else:
      # If the program reported an error, run it once more and directly diff the output with the result.
      # This is a bit hacky, but it works.
      dcc = Popen('./dcc < ' + testName + ' > tmp.asm', shell = True, stderr = STDOUT, stdout = PIPE)
      result = Popen('diff -w - ' + refName, shell = True, stdin = dcc.stdout, stdout = PIPE)
      print ''.join(result.stdout.readlines())
