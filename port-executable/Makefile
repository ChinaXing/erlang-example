CC = clang
CFLAGS = 
ERLC = erlc
OBJECTS = sum_io sum_main sum sum_erl

all: ${OBJECTS}
sum_io: sum_io.c
	${CC} ${CFLAGS} -c $^
sum: sum.c
	${CC} ${CFLAGS} -c $^
sum_main: sum_io.o sum.o sum_main.c
	${CC} ${CFLAGS} $^ -o sum_main
sum_erl: sum.erl
	${ERLC} $^
