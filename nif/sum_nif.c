#include "erl_nif.h"

/**
 * This is the driver module, as a bridge from erlang to C module.
 **/
extern int sum(int a, int b);

static ERL_NIF_TERM sum_nif(ErlNifEnv * env, int argc, const ERL_NIF_TERM argv[])
{
	int a, b, result;
	if(!enif_get_int(env, argv[0], &a) || !enif_get_int(env, argv[1], &b)){
		return enif_make_badarg(env);
	}
	result = sum(a,b);
	return enif_make_int(env, result);
}

static ErlNifFunc nif_funcs[] = {
	{"sum", 2, sum_nif}
};

ERL_NIF_INIT(sum, nif_funcs, NULL, NULL, NULL, NULL)
