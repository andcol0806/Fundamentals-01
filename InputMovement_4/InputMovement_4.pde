character man;
float lastTime;
boolean[] keys;
boolean gravity;

void setup () {
	size(640, 480);
	man = new character();
	lastTime = millis();
	keys = new boolean[5];
  	keys[0] = false;
  	keys[1] = false;
  	keys[2] = false;
  	keys[3] = false;
  	gravity = false;
}

void draw () {
	long now = millis();
	float delta_t = (now - lastTime) / 1000;
	lastTime = now;
	background(0);
	strokeWeight(3);
	stroke(255);
	text("Delta Time: " + delta_t, 10, 10);
	text("x: " + man.pos.x, 10, 20);
	text("y: " + man.pos.y, 10, 30);
	text("xv: " + man.vel.x, 10, 40);
	text("yv: " + man.vel.y, 10, 50);
	text("acc x: " + man.acc.x, 10, 60);
	text("acc y: " + man.acc.y, 10, 70);
	text("gravity: " + gravity, 10, 80);

	man.transform(delta_t);
	man.checkCollision();
	man.draw(delta_t);

	getInput();
}

void getInput() {
	if (keys[0] == true) man.acc.x += 300; 
	if (keys[1] == true) man.acc.x -= 300; 
	if (keys[2] == true) man.acc.y += 300;
	if (keys[3] == true) man.acc.y -= 300; 	
}

void keyPressed()
{
  if (keyCode == RIGHT) keys[0] = true;
  if (keyCode == LEFT) keys[1] = true;
  if (keyCode == DOWN) keys[2] = true;
  if (keyCode == UP) keys[3] = true;
}

void keyReleased()
{
  if (keyCode == RIGHT) keys[0] = false;
  if (keyCode == LEFT) keys[1] = false;
  if (keyCode == DOWN) keys[2] = false;
  if (keyCode == UP) keys[3] = false;
  if (key == 'g') gravity = !gravity; //keys[4] = false;
} 



class character {
	PVector pos, vel, acc, drag;

	character () {
		pos = new PVector(320, 240);
		vel = new PVector(0, 0);
		acc = new PVector(0, 0);
		drag = new PVector(0, 0);
	}

	void draw(float delta_t) {
		int ellipseX = 100, ellipseY = 100;
		if (pos.y > (480 - ellipseY/2)) {
			ellipseY = (480 - (int)pos.y) * 2;
			ellipseX = ((int)pos.y - (480 - (100 / 2))) * 2 + 100;
			float elasticity = 1000 * (pos.y - 440);
			acc.y -= elasticity * delta_t;
		}
		stroke(255, 255, 255);
		strokeWeight(2);
		fill(0, 255, 255);
		ellipse(pos.x, pos.y, ellipseX, ellipseY);
	}
	
	void checkCollision() {
		if (pos.x < -50)
			pos.x = 590;
		if (pos.x > 690)
			pos.x = 50;
		if (pos.y >= 440) {
			pos.y = 440;
			acc.y = 0;
			vel.y = -vel.y * 0.3;		
		}
		if (pos.y < 50) {
			pos.y = 50;
			acc.y = 0;			
			vel.y = 0;
		}

		if (pos.x < 50 && pos.x > -50) {
			stroke(255, 255, 255);
			strokeWeight(2);
			fill(0, 255, 255);
			ellipse(640 + pos.x, pos.y, 100, 100);
		} 
		if (pos.x > 590 && pos.x < 690) {
			stroke(255, 255, 255);
			strokeWeight(2);
			fill(0, 255, 255);
			ellipse(pos.x - 640, pos.y, 100, 100);
		}
	}

	void transform(float delta_t) {
		drag.x = -vel.x * 0.4;
		drag.y = -vel.y * 0.4;
		
		vel.x += (acc.x * delta_t) + (drag.x * delta_t);
		vel.y += (acc.y * delta_t) + (drag.y * delta_t);

		if (abs(vel.x) < 4) vel.x = 0;
		if (abs(vel.y) < 4) vel.y = 0;

		pos.x += vel.x * delta_t;
		pos.y += vel.y * delta_t;

		acc.x = 0;
		if (gravity == false) {
			acc.y = 0;
		} else {
			acc.y += 16000 * delta_t;
		}
	}
}