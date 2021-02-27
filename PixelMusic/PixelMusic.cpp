#include <stdio.h>
#include <SDL2/SDL.h> 
#include <SDL2/SDL_image.h> 
#include <SDL2/SDL_timer.h> 
  
//Screen dimension constants
const int SCREEN_WIDTH = 640;
const int SCREEN_HEIGHT = 480;

int main(unt argc, char* args[]) {
    //the window we'll be rendering to
    SDL_Window* window = NULL;

    //the window surface
    SDL_Surface* screenSurface = NULL;

    //Initialize SDL
    if (SDL_Init(SDL_INIT_VIDEO) < 0)
    printf("SDL could not initialize! SDL_Error: $s\n", SDL_GetError());
}

