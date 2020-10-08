class Character {
	PVector pos, vel;
	int size;
	color c;
	int state;

	Character(float x, float y, int _size) {
		pos = new PVector(x, y);
		vel = new PVector();
		vel.x = -5 + random(11);
		vel.y = -5 + random(11);
		size = _size;
		c = color(255, 255, 255);
		state = 0; // regular behaviour.
	}

	void transform(float delta_t) {
		pos.x += vel.x * delta_t;
		pos.y += vel.y * delta_t;
	}

	void edgeCollide(int w, int h) {
		// Screen-wrap:
		if (pos.x > w + size / 2)
			pos.x = - size / 2;
		else if (pos.x < -(size / 2))
			pos.x = w + size / 2;

		if (pos.y > h + size / 2)
			pos.y = - size / 2;		
		else if (pos.y < -(size / 2))
			pos.y = h + size / 2;
	}

	void backgroundCollide(long[][] terrain, float delta_t) {
		if (withinTerrain(terrain)) {
			pos.x -= vel.x * delta_t;
			pos.y -= vel.y * delta_t;
			vel.x = -vel.x;
			vel.y = -vel.y;					
			//pos.x += vel.x * 2;
			//pos.y += vel.y * 2;
		}
	}

	boolean withinTerrain(long[][] terrain) {
		long x1, y1, x2, y2;
		for (int n = 0; n < terrain.length; n++) {
			x1 = terrain[n][0];
			y1 = terrain[n][1];
			x2 = terrain[n][0] + terrain[n][2];
			y2 = terrain[n][1] + terrain[n][3];
			if ((pos.x + size / 2 > x1) && (pos.x - size / 2 < x2) && 
				(pos.y + size / 2 > y1) && (pos.y - size / 2 < y2))
				return true;
		}
		return false;
	}

	void draw() {
		stroke(c);
		strokeWeight(1);
		fill(c);
		circle(pos.x, pos.y, size);
	}

	void chase(Character target) {
		float angle = atan2(pos.y - target.pos.y, pos.x - target.pos.x);
		vel.x = cos(angle + 3.14) * 2.5;
		vel.y = sin(angle + 3.14) * 2.5;
	}

	void runFrom(Character source) {
		float angle = atan2(pos.y - source.pos.y, pos.x - source.pos.x);
		vel.x = cos(angle) * 1.9;
		vel.y = sin(angle) * 1.9;
	}
}