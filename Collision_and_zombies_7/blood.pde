class BloodManager {
	ArrayList<Splatter> blood = new ArrayList<Splatter>(1000);
	class Splatter {
		PVector pos;
		color c;
		int size;
		float ttl;
		Splatter(float x, float y, int type) {
			pos = new PVector(x, y);			
			size = (int)random(1, 4);
			if (type == 0)
				c = color(255 - random(100), 0, 0);
			else 
				c = color(0, 255 - random(100), 0);
			ttl = 0;
		}
	}

	void spawn(float x, float y, int type) {
		for (int n = 0; n < (int)random(1, 5); n++)	{
			blood.add(new Splatter(x - 3 + random(6), y - 3 + random(6), type));
		}
	}

	void draw() {
		for (Splatter s : blood) {
			stroke(s.c, 255 - (s.ttl / 150) * 254);
			fill(s.c, 255 - (s.ttl / 150) * 254);
			circle (s.pos.x, s.pos.y, s.size);
		}
	}

	void update() {
		for (int n = 0; n < blood.size(); n++) {
			if (++blood.get(n).ttl == 150) {
				blood.remove(n);
			}
		}
	}
}