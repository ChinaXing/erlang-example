CC = clang
INCLUDES = /opt/local/lib/erlang/erts-6.3/include/   
CFLAGS = -fpic -shared -flat_namespace -undefined suppress 
OBJECTS = sum_drv sum_erl
ERLC = erlc

all: ${OBJECTS}

sum_drv : sum_driver.c sum.c
	${CC} ${CFLAGS} -I ${INCLUDES} -o sum_drv.so $^
sum_erl : sum.erl
	${ERLC} $^
