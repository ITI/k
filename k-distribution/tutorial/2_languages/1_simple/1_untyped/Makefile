MAKEFILE_PATH := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
DEF=simple-untyped
EXT=simple
TESTDIR=tests/*
KOMPILE_FLAGS=--transition strict
KOMPILE_BACKEND?=java
KRUN_FLAGS=--output none --smt none

include $(MAKEFILE_PATH)/../../../find-k.mak
include ${K_HOME}/include/kframework/ktest.mak

tests/threads/threads_05.simple: kompile
	cat $@.in 2>/dev/null | $(KRUN_OR_KX) $@ -d $(DEFDIR) --search --bound 5 $(CHECK) $@.out

tests/exceptions/exceptions_07.simple \
tests/threads/threads_01.simple \
tests/threads/threads_02.simple \
tests/threads/threads_04.simple \
tests/threads/threads_06.simple \
tests/threads/threads_09.simple \
tests/diverse/div-nondet.simple: kompile
	cat $@.in 2>/dev/null | $(KRUN_OR_KX) $@ -d $(DEFDIR) --search --pattern '<output> ListItem(#ostream(1)) ListItem("off") ListItem(#buffer(S:String)) </output>' $(CHECK) $@.out
