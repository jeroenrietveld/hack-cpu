# -*- Makefile -*-
### Makefile - VHDL Makefile generated by Emacs VHDL Mode 3.38.1

# Directory : "~/Projects/vhdl/cpu_n2t/"
# Platform  : GHDL
# Generated : 2019-06-28 20:52:38 jeroenrietveld


# Define compilation command and options

COMPILE = ghdl
OPTIONS = -i --workdir=work --ieee=synopsys -fexplicit


# Define library paths

LIBRARY-work = work


# Define library unit files



# Define list of all library unit files

ALL_UNITS =



# Rule for compiling entire design

all : \
		library \
		$(ALL_UNITS)


# Rule for cleaning entire design

clean :
	-rm -f $(ALL_UNITS)


# Rule for creating library directory

library : \
		$(LIBRARY-work)

$(LIBRARY-work) :
	mkdir $(LIBRARY-work)


.PHONY : all clean library


# Rules for compiling single library units and their subhierarchy


# Rules for compiling single library unit files


### Makefile ends here