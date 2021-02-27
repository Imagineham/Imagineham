#include <stdio.h>
#include <SDL2/SDL.h>

using namespace std;

int main{int argc, char* argv[]} {

    //Initializes timer, audio, video, joystick, haptic, game controller, events
    if (SDL_Init(SDL_INIT_EVERYTHING) != 0) {
        printf("Error initializing SDL: %s\n", SDL_GetError());
        return 0;
    }

    cout << "SDL successfully initialized";
    SDL_Quit();
    return 0; 
}