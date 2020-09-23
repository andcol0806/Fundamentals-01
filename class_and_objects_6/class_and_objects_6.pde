final int W = 640;
final int H = 480;
final int R = 20;

int gameState; 			// Game state; 0 = Init; 1 = Game On! 2 = Game Over
Player player;
BallManager balls;
Time time;

void settings() {
	size(W, H);
}

void setup () {
	player = new Player(W / 2, H / 2, R);
	balls = new BallManager(W, H, 10, 100);
	time = new Time();
	gameState = 1;
  	((java.awt.Canvas) surface.getNative()).requestFocus();
	textAlign(CENTER, CENTER);  	
}

void draw () {
	float delta_t = time.getDelta() / 100;
	background(0);
	switch (gameState) {
		case 0: // Init
			player = new Player(W / 2, H / 2, R);
			balls = new BallManager(W, H, 10, 100);
			gameState = 1;
			break;
		case 1:
			score();
			// Everything player...
			player.getInput();
			player.transform(delta_t);
			player.edgeCollide(W, H);
			player.draw();
			// Everything enemy...					
			if (balls.collide(player))
				gameState = 2;
			balls.spawn(W, H, player, 3000);
			balls.transform(delta_t);
			balls.edgeCollide(W, H);
			balls.draw();
			break;
		case 2: // Game Over
			gameOverScreen();
			break;
	}
	//debugInfo(delta_t);
}

void score() {
	fill(255);
	stroke(255);
	textSize(15);
	text("Balls spawned: " + balls.ballsSpawned, 80, 10);
}

void keyPressed() {
	player.keyPressed();
}

void keyReleased() {
	player.keyReleased();
} 

void debugInfo(float delta_t) {
	strokeWeight(3);
	stroke(255);
	text("Delta Time: " + delta_t, 10, 10);
	text("x: " + player.pos.x, 10, 20);
	text("y: " + player.pos.y, 10, 30);
	text("xv: " + player.vel.x, 10, 40);
	text("yv: " + player.vel.y, 10, 50);
	text("acc x: " + player.acc.x, 10, 60);
	text("acc y: " + player.acc.y, 10, 70);
}

void gameOverScreen() {
	stroke(255, 0, 0);
	fill(255, 0, 0);
	textSize(30);
	text("Game Over!", W / 2, H / 2 - 20);
	stroke(255, 0, 0);
	fill(255, 0, 0);
	textSize(15);			
	text(" - esc to exit", W / 2, H / 2 + 20);
	text(" - r to restart", W / 2, H / 2 + 30);
	if (player.keys[4]) exit();
	if (player.keys[5]) gameState = 0;
}
