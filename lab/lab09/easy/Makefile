# Makefile generated at Thu 30 Jul 21:13:31 AEST 2020

CC = gcc
CFLAGS = -Wall -O3

easymain: easymain.o graphics.o world.o 
	$(CC) $(LDFLAGS) -o $@ easymain.o graphics.o world.o 

easymain.o : graphics.h world.h easymain.c
graphics.o : graphics.h world.h graphics.c
world.o : world.h world.c
