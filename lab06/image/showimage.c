
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include "SDL/SDL.h"
#include "SDL/SDL_image.h"



extern int AssemblyFunc(int x, int y, int z);

void Filter(unsigned char * buf, int width,int height,int size,char bpp, int RowSize, int Padding){

int i, j, k;
char temp;
srand(time(NULL));
    for(i=0; i < height; i++)
    {
        for(j=0; j < (width); j++)
        {
            for(k=0; k<bpp; k++)
            {
            	    //int RowSize= (( image->format->BitsPerPixel * image->w + 31)/32) * 4;
    				//int Padding = 4 - ( (image->w * image->format->BytesPerPixel) %4);
                //temp = buf[ ( i * (RowSize) ) + ( j * bpp ) + k ];
                //buf[ ( i * (RowSize) ) + ( j * bpp ) + k ] = buf[ ( i * (RowSize) ) + ( j * bpp ) + k ] + rand() % 20 -10;
                buf[ ( (height-i) * (RowSize) - Padding ) - ( j * bpp ) + k ] = AssemblyFunc(buf[ ( (height-i) * (RowSize) - Padding ) - ( j * bpp ) + k ], buf[ ( (height-i-1) * (RowSize) - Padding ) - ( j * bpp ) + k ], buf[ ( (height-i+1) * (RowSize) - Padding ) - ( j * bpp ) + k ]);
                buf[ ( (height-i) * (RowSize) - Padding ) - ( j * bpp ) + k +1] = AssemblyFunc(buf[ ( (height-i) * (RowSize) - Padding ) - ( j * bpp ) + k +1], buf[ ( (height-i-1) * (RowSize) - Padding ) - ( j * bpp ) + k +1], buf[ ( (height-i+1) * (RowSize) - Padding ) - ( j * bpp ) + k +1]);
                buf[ ( (height-i) * (RowSize) - Padding ) - ( j * bpp ) + k +2] = AssemblyFunc(buf[ ( (height-i) * (RowSize) - Padding ) - ( j * bpp ) + k +2], buf[ ( (height-i-1) * (RowSize) - Padding ) - ( j * bpp ) + k +2], buf[ ( (height-i+1) * (RowSize) - Padding ) - ( j * bpp ) + k +2]);
                //buf[ ( (height-i) * (RowSize) - Padding ) - ( j * bpp ) + k ] = (buf[ ( (height-i-1) * (RowSize) - Padding ) - ( j * bpp ) + k ] + buf[ ( (height-i) * (RowSize) - Padding ) - ( j * bpp ) + k ] + buf[ ( (height-i+1) * (RowSize) - Padding ) - ( j * bpp ) + k ])/3;
                //buf[ ( (height-i) * (RowSize) - Padding ) - ( j * bpp ) + k +1] = (buf[ ( (height-i-1) * (RowSize) - Padding ) - ( j * bpp ) + k +1] + buf[ ( (height-i) * (RowSize) - Padding ) - ( j * bpp ) + k +1] + buf[ ( (height-i+1) * (RowSize) - Padding ) - ( j * bpp ) + k +1])/3;
                //buf[ ( (height-i) * (RowSize) - Padding ) - ( j * bpp ) + k +2] = (buf[ ( (height-i-1) * (RowSize) - Padding ) - ( j * bpp ) + k +2] + buf[ ( (height-i) * (RowSize) - Padding ) - ( j * bpp ) + k +2] + buf[ ( (height-i+1) * (RowSize) - Padding ) - ( j * bpp ) + k +2])/3;
            }
        }
    }
} ;
void FilterASM(unsigned char * buf, int width,int height,int size,char bpp, int RowSize, int Padding){

int i, j, k;
char temp;
srand(time(NULL));
    for(i=0; i < height; i++)
    {
        for(j=0; j < (width); j++)
        {
            for(k=0; k<bpp; k++)
            {
            	    //int RowSize= (( image->format->BitsPerPixel * image->w + 31)/32) * 4;
    				//int Padding = 4 - ( (image->w * image->format->BytesPerPixel) %4);
                //temp = buf[ ( i * (RowSize) ) + ( j * bpp ) + k ];
                //buf[ ( i * (RowSize) ) + ( j * bpp ) + k ] = buf[ ( i * (RowSize) ) + ( j * bpp ) + k ] + rand() % 20 -10;



                buf[ ( (height-i) * (RowSize) - Padding ) - ( j * bpp ) + k ] = (buf[ ( (height-i-1) * (RowSize) - Padding ) - ( j * bpp ) + k ] + buf[ ( (height-i) * (RowSize) - Padding ) - ( j * bpp ) + k ] + buf[ ( (height-i+1) * (RowSize) - Padding ) - ( j * bpp ) + k ])/3;
                buf[ ( (height-i) * (RowSize) - Padding ) - ( j * bpp ) + k +1] = (buf[ ( (height-i-1) * (RowSize) - Padding ) - ( j * bpp ) + k +1] + buf[ ( (height-i) * (RowSize) - Padding ) - ( j * bpp ) + k +1] + buf[ ( (height-i+1) * (RowSize) - Padding ) - ( j * bpp ) + k +1])/3;
                buf[ ( (height-i) * (RowSize) - Padding ) - ( j * bpp ) + k +2] = (buf[ ( (height-i-1) * (RowSize) - Padding ) - ( j * bpp ) + k +2] + buf[ ( (height-i) * (RowSize) - Padding ) - ( j * bpp ) + k +2] + buf[ ( (height-i+1) * (RowSize) - Padding ) - ( j * bpp ) + k +2])/3;
            }
        }
    }
} ;




SDL_Surface* Load_image(char *file_name)
{
		/* Open the image file */
		SDL_Surface* tmp = IMG_Load(file_name);
		if ( tmp == NULL ) {
			fprintf(stderr, "Couldn't load %s: %s\n",
			        file_name, SDL_GetError());
				exit(0);
		}
		return tmp;	
}

void Paint(SDL_Surface* image, SDL_Surface* screen)
{
		SDL_BlitSurface(image, NULL, screen, NULL);
		SDL_UpdateRect(screen, 0, 0, 0, 0);
};





int main(int argc, char *argv[])
{
	Uint32 flags;
	SDL_Surface *screen, *image;
	int depth, done;
	SDL_Event event;

	/* Check command line usage */
	if ( ! argv[1] ) {
		fprintf(stderr, "Usage: %s <image_file>, (int) size\n", argv[0]);
		return(1);
	}

	if ( ! argv[2] ) {
		fprintf(stderr, "Usage: %s <image_file>, (int) size\n", argv[0]);
		return(1);
	}

	/* Initialize the SDL library */
	if ( SDL_Init(SDL_INIT_VIDEO) < 0 ) {
		fprintf(stderr, "Couldn't initialize SDL: %s\n",SDL_GetError());
		return(255);
	}

	flags = SDL_SWSURFACE;
	image = Load_image( argv[1] );
	printf( "\n\nImage properts:\n" );
	printf( "BitsPerPixel = %i \n", image->format->BitsPerPixel );
	printf( "BytesPerPixel = %i \n", image->format->BytesPerPixel );
	printf( "width %d ,height %d \n\n", image->w, image->h );	 	

	SDL_WM_SetCaption(argv[1], "showimage");

	/* Create a display for the image */
	depth = SDL_VideoModeOK(image->w, image->h, 32, flags);
	/* Use the deepest native mode, except that we emulate 32bpp
	   for viewing non-indexed images on 8bpp screens */
	if ( depth == 0 ) {
		if ( image->format->BytesPerPixel > 1 ) {
			depth = 32;
		} else {
			depth = 8;
		}
	} else
	if ( (image->format->BytesPerPixel > 1) && (depth == 8) ) {
    		depth = 32;
	}
	if(depth == 8)
		flags |= SDL_HWPALETTE;
	screen = SDL_SetVideoMode(image->w, image->h, depth, flags);
	if ( screen == NULL ) {
		fprintf(stderr,"Couldn't set %dx%dx%d video mode: %s\n",
			image->w, image->h, depth, SDL_GetError());
	}

	/* Set the palette, if one exists */
	if ( image->format->palette ) {
		SDL_SetColors(screen, image->format->palette->colors,
	              0, image->format->palette->ncolors);
	}


	/* Display the image */
	Paint(image, screen);


    int RowSize= (( image->format->BitsPerPixel * image->w + 31)/32) * 4;
    int Padding = 4 - ( (image->w * image->format->BytesPerPixel) %4);


	done = 0;
	int size =atoi( argv[2] );
	printf("Actual size is: %d\n", size);
	while ( ! done ) {
		if ( SDL_PollEvent(&event) ) {
			switch (event.type) {
			    case SDL_KEYUP:
				switch (event.key.keysym.sym) {
				    case SDLK_ESCAPE:
				    case SDLK_TAB:
				    case SDLK_q:
					done = 1;
					break;
				    case SDLK_SPACE:
				    case SDLK_f:
					SDL_LockSurface(image);
					
					printf("Start filtering...  ");
					//high_resolution_clock::time_point t1 = high_resolution_clock::now();                    //poczatek pomiaru czasu
					clock_t begin = clock();
					Filter(image->pixels,image->w,image->h, size, image->format->BytesPerPixel, RowSize, Padding );
					clock_t end = clock();
double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
   					//high_resolution_clock::time_point t2 = high_resolution_clock::now();
   					//auto durationMicroSec = duration_cast<microseconds>(t2 - t1).count();                   //blok kodu odpowiedzialny
    				printf("%f sekund\n", time_spent);
					printf("Done.\n");

					SDL_UnlockSurface(image);
					
					printf("Repainting after filtered...  ");
					Paint(image, screen);
					printf("Done.\n");
					
					break;
					case SDLK_g:
					SDL_LockSurface(image);
					
					printf("Start filtering...  ");
										clock_t begin2 = clock();
					//high_resolution_clock::time_point t3 = high_resolution_clock::now();                    //poczatek pomiaru czasu
					FilterASM(image->pixels,image->w,image->h, size, image->format->BytesPerPixel, RowSize, Padding );
					//high_resolution_clock::time_point t4 = high_resolution_clock::now();
				    //auto durationMicroSec2 = duration_cast<microseconds>(t4 - t3).count();                   //blok kodu odpowiedzialny
    				//cout << durationMicroSec2 << " microsekund\n";
    									clock_t end2 = clock();
double time_spent2 = (double)(end2 - begin2) / CLOCKS_PER_SEC;
    				printf("%f sekund\n", time_spent2);
					printf("Done.\n");

					SDL_UnlockSurface(image);
					
					printf("Repainting after filtered...  ");
					Paint(image, screen);
					printf("Done assembly.\n");
					
					break;
				    case SDLK_r:
					printf("Reloading image...  ");
					image = Load_image( argv[1] );
					Paint(image,screen);
					printf("Done.\n");
					break;
				    case SDLK_PAGEDOWN:
				    case SDLK_DOWN:
				    case SDLK_KP_MINUS:
					size--;
					if (size==0) size--;
					printf("Actual size is: %d\n", size);
				        break;
				    case SDLK_PAGEUP:
				    case SDLK_UP:
				    case SDLK_KP_PLUS:
					size++;
					if (size==0) size++;
					printf("Actual size is: %d\n", size);
					break;		
				   case SDLK_s:
					printf("Saving surface at nowy.bmp ...");
					SDL_SaveBMP(image, "nowy.bmp" ); 
					printf("Done.\n");
				    default:
					break;
				}
				break;
//			    case  SDL_MOUSEBUTTONDOWN:
//				done = 1;
//				break;
                            case SDL_QUIT:
				done = 1;
				break;
			    default:
				break;
			}
		} else {
			SDL_Delay(10);
		}
	}
	SDL_FreeSurface(image);
	/* We're done! */
	SDL_Quit();
	return(0);
}
