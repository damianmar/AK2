#include <stdio.h>

extern int checkRounding();
extern int setRounding(int precision);
extern float countFunction(float x, int n);

int main()
{

	int choose = 1;
	int precision = 0;
	while(choose!=0){
		printf("\n\nWybierz co chcesz zrobic:\n0. Zakoncz dzialanie programu\n1. Sprawdz tryb zaokraglania\n2. Wybierz tryb zaokraglania\n3. Wykonaj dzialanie\n4. Oblicz wynik funkcjie e^x\n");
		scanf("%d", &choose);
		if(choose == 1){
			precision = checkRounding();
			printf("%s\n", "Aktualne zaokraglenie jest do ");
			switch(precision){
				case 0:{printf("%s", "do najblizszej"); break;}
				case 1:{printf("%s", "do - nieskonczonosci"); break;}
				case 2:{printf("%s", "do + nieskonczonosci"); break;}
				case 3:{printf("%s", "do zera"); break;}
			}
		}else if(choose == 2){
			printf("%s\n", "Wybierz tryb zaokraglania:\n0. do najblizszej\n1. do - nieskonczonosci\n2. do + nieskonczonosci\n3. do zera\n");
			scanf("%d", &precision);
			if(precision < 0 || precision > 3)
				printf("%s\n", "Bledna wartosc");
			else
				setRounding(precision);
		}else if(choose == 3){
			float number = 100;
			float divide = 3;
			float score = 0;
			score = number/divide;
			printf("%f\n", score);
		}else if(choose == 4){
			int n = 0;
			float x = 0;
			float score = 0;
			printf("%s\n", "Podaj x: ");
			scanf("%f", &x);
			printf("%s\n", "Podaj i: ");
			scanf("%d", &n);
			score = countFunction(x, n);
			printf("%s %f", "Wynik to ", score);
		}
	}
	return 0;
}