class Zombie extends Character {
	long clock, treshold, brainCrave, hands;
	long transition;
	Character currentTarget;
	PVector[] handsAnim = new PVector[2];
	Zombie(float x, float y, int size, PVector newDir) {
		super(x, y, size);
		super.vel = newDir;
		c = color (20, 250, 20);
		vel.mult(0.6);
		clock = 0;
		treshold = (long)random(50, 100);
		brainCrave = 0;//100;
		currentTarget = null;
		handsAnim[0] = new PVector();
		handsAnim[1] = new PVector();
		hands = 0;
		transition = 300;
	}

	void draw() {
		super.draw();

		float angle = atan2(vel.y, vel.x);

		pushMatrix();
		strokeWeight(3);
		stroke(c);
		translate(pos.x, pos.y);
		translate(-1 + random(3), -1 + random(3));
		rotate(angle);
		line (0, - size / 2, size + handsAnim[0].x, - size / 2 + handsAnim[0].y);
		line (0, + size / 2, size + handsAnim[1].x, + size / 2 + handsAnim[1].y);
		stroke(255, 0, 0);
		strokeWeight(2);
		circle(4, -5, 1);
		circle(4, 5, 1);
		stroke(0);
		ellipse(7, 0, 2, 4);
		popMatrix();

		if (brainCrave-- > 0)
			brainCrave();
	}

	void chase(Character target) {
		if (currentTarget != target) {
			if (clock++ == treshold) {
				super.chase(target);
				clock = 0;
				treshold = (long)random(130, 150);
				if ((int)random(10) == 0)
					brainCrave = 70;
				if (currentTarget != null) {
					currentTarget.state = 0;
					currentTarget.c = color(168, 148, 140);
				}
				vel.mult(2);
				currentTarget = target;
				currentTarget.state = 1;
			}
			
			if (brainCrave > 0)
				vel.mult(0.95);
		}
	}

	void brainCrave() {
		stroke(255);
		fill(255);
		circle (pos.x - size / 2, pos.y - size / 2, 4);
		circle (pos.x - size / 2 - 5, pos.y - size / 2 - 10, 8);
		pushMatrix();
		translate(pos.x - size / 2 - 2, pos.y - size / 2 - 30);
		ellipse (0, 0, size * 1.2, size);
		stroke(255, 180, 180);
		fill(255, 160, 160);
		strokeWeight(1);
		ellipse(-3, -2, 5, 6);
		ellipse(-1, -2, 5, 6);
		ellipse(1, -3, 5, 6);
		ellipse(3, 1, 5, 6);
		ellipse(3, -1, 4, 4);
		ellipse(1, 1, 5, 6);
		ellipse(1, -3, 5, 6);
		ellipse(-3, 0, 5, 6);
		ellipse(-5, 0, 5, 6);
		popMatrix();
		strokeWeight(1);
	}


	void transform(float delta_t) {
		super.transform(delta_t);

		if (int(random(50)) == 0) {	
			blood.spawn(pos.x, pos.y, 1);
		}

		if (hands-- == 0) {
			handsAnim[0].x = -10 + random(4);
			handsAnim[0].y = -3 + random(6);
			handsAnim[1].x = -10 + random(4);			
			handsAnim[1].y = -3 + random(6);			
			hands = 10;
		}
	}
}