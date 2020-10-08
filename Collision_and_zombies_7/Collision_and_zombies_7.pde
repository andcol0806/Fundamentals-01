import processing.sound.*;

final int W = 835;
final int H = 655;

SoundFile file;
int gameState;
Time time;
long zombiesWinTime = 0;
CharacterManager cmanager;
BloodManager blood;
Weather weather;
PImage background;
long[][] terrain = {{430, 60, 105, 150},
					{535, 150, 50, 240},
					{450, 210, 83, 250},
					{585, 80, 80, 370},
					{665, 175, 60, 100},
					{725, 70, 65, 130},
					{725, 325, 60, 130}};

void settings() {
	size(W, H);
}

void setup() {
	file = new SoundFile(this, "evil.mp3");
	time = new Time();
	cmanager = new CharacterManager();
	blood = new BloodManager();
	weather = new Weather(W, H);
	gameState = 1;	// Game on!	
  	background = loadImage("background.png");
	file.loop();				
}


void draw() {
	float delta_t = time.getDelta() * 0.015;
	image(background, 0, 0);

	switch (gameState) {
		case 0:		// Init
			time = new Time();
			cmanager = new CharacterManager();
			blood = new BloodManager();
			gameState = 1;	// Game on!	
  			file.play();			
			break;
		case 1: 	// Game loop
			cmanager.transform(delta_t);
			cmanager.collide(W, H, delta_t);//, terrain);
			blood.update();
			blood.draw();
			cmanager.draw();
			if (cmanager.nZombies == 100) {
				zombiesWinTime = time.getAbsolute() / 1000;
				gameState = 2;
			}
			break;
		case 2:		// Game over
			textSize(50);
			fill(200, 0, 0);
			textAlign(CENTER, CENTER);
			text("Game Over", W / 2, H / 2 - 40);
			textSize(20);
			fill(130, 130, 130);
			text("Zombies won in " + zombiesWinTime + " seconds", W / 2, H / 2 - 5);
			break;
	}
	weather.rain();
	weather.thunder();
	weather.leaves(delta_t);
	//drawGrid();
}

void keyPressed() {
	if (key == 'r')			// if r key is pressed while Game Over, restart game
		if (gameState == 2)
			gameState = 0;
}

void drawGrid() {
	for (int n = 0; n < terrain.length; n++) {
		stroke(255, 0, 0);
		strokeWeight(3);
		rect(terrain[n][0], terrain[n][1], terrain[n][2], terrain[n][3]);
	}
}
