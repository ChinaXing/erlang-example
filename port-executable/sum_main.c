#include <netinet/in.h>

typedef unsigned char byte;
extern int read_cmd(byte *buf);
extern int write_cmd(byte *buf, int size);
extern int sum(int a, int b);  
int main(){
	int fn, arg0, arg1, res;
	byte buf[16];
	while(read_cmd(buf) >0){
		fn = buf[0];
		arg0 = ntohl(*((uint32_t*)(buf + 1)));
		arg1 = ntohl(*((uint32_t*)(buf + 1 + sizeof(uint32_t))));
		res = htonl(sum(arg0, arg1));
		write_cmd((byte*)&res, sizeof(uint32_t));
	}
}
