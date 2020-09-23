class Player {
	PVector pos, vel, acc, drag;
	boolean[] keys;
	int r;
	Player (int startX, int startY, int size) {
		pos = new PVector(startX, startY);
		vel = new PVector(0, 0);
		acc = new PVector(0, 0);
		drag = new PVector(0, 0);
		r = size;
		keys = new boolean[6];
  		for (int n = 0; n <= 5; n++)
	  		keys[n] = false;
	}

	void draw() {
		stroke(255, 255, 255);
		strokeWeight(2);
		fill(0, 255, 255);
		circle(pos.x, pos.y, r);
	}
	
	void edgeCollide(int w, int h) {
		if ((pos.x + r / 2) < 0)
			pos.x = w + r / 2;
		if (pos.x > w + r / 2)
			pos.x = -r / 2;
		if ((pos.y - r / 2) < 0) {
			pos.y = r / 2;
			vel.y = 0;
			acc.y = 0;
		}
		if (pos.y > h - r / 2) {
			pos.y = h - r / 2;
			vel.y = 0;
			acc.y = 0;
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
		acc.y = 0;
	}


	void getInput() {
		if (keys[0] == true) player.acc.x += 30; 
		if (keys[1] == true) player.acc.x -= 30; 
		if (keys[2] == true) player.acc.y += 30;
		if (keys[3] == true) player.acc.y -= 30; 	
	}

	void keyPressed()
	{
	  if (keyCode == RIGHT) keys[0] = true;
	  if (keyCode == LEFT) keys[1] = true;
	  if (keyCode == DOWN) keys[2] = true;
	  if (keyCode == UP) keys[3] = true;
	  if (keyCode == ESC) keys[4] = true;
	  if (key == 'r') keys[5] = true;
	}

	void keyReleased()
	{
	  if (keyCode == RIGHT) keys[0] = false;
	  if (keyCode == LEFT) keys[1] = false;
	  if (keyCode == DOWN) keys[2] = false;
	  if (keyCode == UP) keys[3] = false;
	  if (keyCode == ESC) keys[4] = false;
	  if (key == 'r') keys[5] = false;  
	} 
}