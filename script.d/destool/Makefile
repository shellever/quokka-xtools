CROSS_COMPILE = 
# use exported variable from source envsetup.sh
CC = $(CROSS_COMPILE)gcc

CFLAGS += -Wall -O2
CFLAGS += -I.


OBJS := utils.o
OBJS += des.o
OBJS += destool.o
SRCS := $(OBJS:.o=.c)

ALL := destool


all: $(ALL)

$(ALL): .depend $(OBJS)
	$(CC) -o $@ $(OBJS)


# rules define
%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

# depend define
.depend: $(SRCS)
	@rm -f $@
	@for f in $(SRCS); do \
		$(CC) $(CFLAGS) -MM $$f >> $@; \
	done


clean:
	rm -f $(OBJS) .depend

distclean: clean
	rm -f $(ALL)

.PHONY: all test clean distclean

