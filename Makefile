TESTS = write_bw_postlist rdma_lat rdma_bw send_lat send_bw write_lat write_bw read_lat read_bw
UTILS = clock_test

all: ${TESTS} ${UTILS}

CFLAGS += -Wall -g -D_GNU_SOURCE 
EXTRA_FILES = get_clock.c
EXTRA_HEADERS = get_clock.h
#The following seems to help GNU make on some platforms
LOADLIBES += 
LDFLAGS +=

${TESTS}: LOADLIBES += -libverbs

${TESTS} ${UTILS}: %: %.c ${EXTRA_FILES} ${EXTRA_HEADERS}
	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) $< ${EXTRA_FILES} $(LOADLIBES) $(LDLIBS) -o ib_$@
clean:
	$(foreach fname,${TESTS}, rm -f ib_${fname})
	rm -f ${UTILS}	
.DELETE_ON_ERROR:
.PHONY: all clean
