class Human extends Character {
	long clock, treshold;
	long zombieTransition, hands;
	boolean dead;
	PVector[] handsAnim = new PVector[2];
	

	Human(float x, float y, int size) {
		super(x, y, size);
		c = color(168, 148, 140);
		//c = color(20, 20, 240);
		clock = 0;
		treshold = (long)random(50, 100);
		zombieTransition = -1;
		dead = false;
		hands = 0;
		handsAnim[0] = new PVector();
		handsAnim[1] = new PVector();
	}
	
	void transform(float delta_t) {
		if (clock++ == treshold) {
			clock = 0;
			float angle, speed;
			if (zombieTransition > -1) {
				treshold = (long)random(0, 20);
				angle = atan2(vel.y, vel.x) - 3.1415 / 2 + random(0, 3.1415);
				speed = 5 + random(5);
			} else {
				if (state == 1) {
					treshold = (long)random(10, 20);
					angle = atan2(vel.y, vel.x) - 1 + random(2);
					speed = 4 + random(4);
				}
				else {
					treshold = (long)random(50, 100);
					angle = atan2(vel.y, vel.x) - 3.1415 / 2 + random(0, 3.1415);
					speed = 3 + random(2);
				}
			}
			vel.x = cos(angle) * speed;
			vel.y = sin(angle) * speed;
		}

		if (zombieTransition > -1) {
			state = 2;
			float f = (100 - (float)zombieTransition) / 100;
			super.c = color(168 - (168 - 20) * f, 
							148 + (250 - 148)  * f, 
							140 - (140 - 20) * f);
				//c = color (20, 250, 20);
			if (zombieTransition-- == 0)
				dead = true;
			if ((int)random(1, 10) == 1)
				blood.spawn(pos.x, pos.y, 0);
		}

		if (hands-- == 0) 
			hands = 28;
		switch (state) {
			case 0:
			case 1:
				handsAnim[0].x = 10 - int(hands / 14) * 5;
				handsAnim[0].y = 0;
				handsAnim[1].x = 5 + int(hands / 14) * 5;
				handsAnim[1].y = 0;
				break;
			case 2:
				handsAnim[0].x = -2 + random(20);
				handsAnim[0].y = 0;
				handsAnim[1].x = -2 + random(20);			
				handsAnim[1].y = 0;
				break;
		}

		super.transform(delta_t);
	}

	void draw() {
		super.draw();
		float angle = atan2(vel.y, vel.x);

		pushMatrix();
		translate(pos.x, pos.y);
		rotate(angle);
		switch (super.state) {
			case 0: // smile
				smile();
				break;
			case 1: // worried
				worried();
				break;
			case 2: // "/!(&#"!
				goingZombie();
				break;
		}
		popMatrix();
	}

	void smile() {
		strokeWeight(1);
		stroke(140, 100, 100);
		fill(140, 100, 100);
		ellipse (2, 0, 15, 15);

		color(130, 118, 40);
		strokeWeight(4);
		line (0, -10, handsAnim[0].x, -10 + handsAnim[0].y);
		line (0, 10, handsAnim[1].x, 10 - handsAnim[1].y);
		strokeWeight(1);
		stroke(255);
		arc(0, 0, 15, 15, -3.14 / 5, 3.14 / 5);
		circle(2, -5, 2);
		circle(2, 5, 2);
	}

	void worried() {
		strokeWeight(1);
		stroke(240, 100, 100);
		fill(240, 100, 100);
		ellipse (2, 0, 15, 15);
		stroke(140, 100, 100);
		fill(140, 100, 100);
		strokeWeight(4);
		line (0, -10, handsAnim[0].x, -10 + handsAnim[0].y);
		line (0, 10, handsAnim[1].x, 10 - handsAnim[1].y);
		stroke(255);
		strokeWeight(1);
		line (7, -5, 7, 5);
		circle(3, -5, 2);
		circle(3, 5, 2);
	}

	void goingZombie() {
		translate(-2 + random(4), -2 + random(4));
		strokeWeight(4);
		line (0, -10, handsAnim[0].x , -10 + handsAnim[0].y);
		line (0, 10, handsAnim[1].x, 10 - handsAnim[1].y);
		strokeWeight(1);
		stroke(255, 0, 0);
		circle(-5, -5, 2);
		circle(-5, 5, 2);
		stroke(255);
		line(5, -5, 3, -3);
		line(3, -3, 5, -1);
		line(5, -1, 3, 2);
		line(3,  2, 5, 4);
	}
}