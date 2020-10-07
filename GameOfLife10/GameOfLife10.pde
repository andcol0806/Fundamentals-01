final int w = 640;
final int h = 480;
GameOfLife game;

void settings() {
	size (w, h);
}

void setup() {
	game = new GameOfLife(640, 480, 4, 4);
}

void draw() {
	game.draw();
}
