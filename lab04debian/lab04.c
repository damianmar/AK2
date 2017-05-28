#include <stdio.h>

int fun(int x, float y, int z){
	if(z==0)
		return x * x + y * y;
	if(z!=0)
		return x * x * x + y * y * y;
}