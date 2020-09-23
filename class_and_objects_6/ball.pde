class Ball {
	PVector pos, vel;
	int r;
	color c;
	Ball(float x, float y, int _r) {
		pos = new PVector(x, y);
		vel = new PVector();
		vel.x = -5 + random(11);
		vel.y = -5 + random(11);
		r = _r;
		c = color(random(256) * 0.7, random(256) * 0.7, random(256) * 0.7);
	}

	void transform(float delta_t) {
		pos.x += vel.x * delta_t;
		pos.y += vel.y * delta_t;
	}

	void edgeCollide(int w, int h) {
		if ((pos.x + r/2 >= w) || (pos.x - r/2 <= 0)) 
			vel.x = -vel.x;
		if ((pos.y + r/2 >= h) || (pos.y - r/2 <= 0)) 
			vel.y = -vel.y;
	}

	void draw() {
		stroke(c);
		fill(c);
		circle(pos.x, pos.y, r);
	}

	boolean enemyCollision(BallManager bmanager) {
		for (Ball b : bmanager.balls) {
			//stroke(255, 255, 255);
			//line (pos.x, pos.y, b.pos.x, b.pos.y);
			float xd = pos.x - b.pos.x;
			float yd = pos.y - b.pos.y;
			if ((xd * xd + yd * yd) < (r/2 + b.r/2) * (r/2 + b.r/2))
				return true;
		}
		return false;
	}

}