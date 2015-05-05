CC = clang
INCLUDES = /opt/local/lib/erlang/erts-6.3/include/   
CFLAGS = -fpic -shared -flat_namespace -undefined suppress 
OBJECTS = sum_nif sum_erl
ERLC = erlc

all: ${OBJECTS}

sum_nif : sum_nif.c sum.c
	${CC} ${CFLAGS} -I ${INCLUDES} -o sum_nif.so $^
sum_erl : sum.erl
	${ERLC} $^
