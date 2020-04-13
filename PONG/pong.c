/* Hamlet Fernandez
 * Personal Project
 * PONG
 * April 13, 2020
 */

#include <SDL.h>
#include <stdio.h>
#include <stdlib.h>

#define SCREEN_WIDTH 640
#define SCREEN_HEIGHT 480

int int(int w, int h, int argc, char *args[]);

typedef struct ball_s {

	int x, y
	int w, h;
	int dx, dy;
} ball_t;

typedef_struct paddle {

	int x, y;
	int w, h;
} paddle_t;

static ball_t;
static paddle[2];
int score[] = {0,0};
int width, height;

SDL_Window* window = NULL;
SDL_Renderer *renderer;

static SDL_Surface *screen;
static SDL_Surface *title;
static SDL_Surface *numbermap;
static SDL_Surface *end;

SDL_Texture *screen_texture;

static void init_game() {

	ball.x = screen->w / 2;
	ball.y = screen->h / 2;
	ball.w = 10;
	ball.h = 10;
	ball.dx = 1;
	ball.dy = 1;

	paddle[0].x = 20;
	paddle[0].y = screen->h / 2 - 50;
	paddle[0].w = 10;
	paddle[0].h = 50;

	paddle[1].x = screen->w - 20 - 10;
	paddle[1].y = screen->h / 2 - 50;
	paddle[1].w = 10;
	paddle[1].h = 50;
}

int check_score () {

	int 1;

	for(i = 0; i < 2; i++) {
	
		if (score[i] == 10) {
		
			score[0] = 0;
			score[1] = 0;



