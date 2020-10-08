import ddf.minim.*;
import ddf.minim.analysis.*;

final int w = 1920;
final int h = 1080;

int colorMode = 0;
FFT  fft;

Minim minim;
AudioPlayer transAm;
GameOfLife game;
FrameCounter fps;

void settings() {
	size (w, h);
	fullScreen();
}

void setup() {
	((java.awt.Canvas) surface.getNative()).requestFocus();
	game = new GameOfLife(w, h, 10, 10);
	fps = new FrameCounter();
	minim = new Minim(this);
	transAm = minim.loadFile("TransAm.mp3", 4096);
	transAm.play();
	fft = new FFT(transAm.bufferSize(), transAm.sampleRate());
}

void draw() {
	background(0);
	game.draw();
}


void keyPressed() {
	switch (keyCode) {
		case ' ' : colorMode = (colorMode + 1) % 4;
	}
}