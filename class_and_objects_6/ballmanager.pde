class BallManager {
	ArrayList<Ball> balls;
	Time time;
	int maxBalls, ballsSpawned;

	BallManager(int w, int h, int startBalls, int _maxBalls) {
  		balls = new ArrayList<Ball>(_maxBalls);
  		time = new Time();
  		maxBalls = _maxBalls;
  		ballsSpawned = startBalls;
  		for (int n = 0; n < startBalls; n++) {	
  			balls.add(new Ball(random(w), random(h), (int)random(5, 20)));	
  		}
	}

	void spawn(int w, int h, Player player, long treshold) {
		if (ballsSpawned < maxBalls && time.getAbsolute() > treshold) {
			boolean spawnedOnPlayer;
			float x, y;
			int r;
			do {
				spawnedOnPlayer = false;
				x = random(w);
				y = random(h);
				r = (int)random(5, 20);
				for (Ball b : balls) {
					if (overlap(player.pos.x, player.pos.y, player.r / 2, x, y, r / 2))
						spawnedOnPlayer = true;
				}
			} while (spawnedOnPlayer == true);
			balls.add(new Ball(x, y, r));
			ballsSpawned++;
			time = new Time();
		}
	}

	void draw() {
		for (Ball ball : balls) {
			ball.draw();
		}	
	}

	void edgeCollide(int w, int h) {
		for (Ball ball : balls) {
			ball.edgeCollide(w, h);
		}	
	}

	void transform(float delta_t) {
		for (Ball ball : balls) {
			ball.transform(delta_t);
		}		
	}


	boolean collide(Player player) {
		for (Ball b : balls) {
			//stroke(255, 255, 255);
			//line (pos.x, pos.y, b.pos.x, b.pos.y);
			if (overlap(player.pos.x, player.pos.y, player.r / 2, b.pos.x, b.pos.y, b.r / 2))
				return true;
		}
		return false;
	}

	boolean overlap(float x1, float y1, float r1, float x2, float y2, float r2) {
		float xd = x1 - x2;
		float yd = y1 - y2;
		if ((xd * xd + yd * yd) < (r1 + r2) * (r1 + r2))
			return true;
		return false;
	}
}