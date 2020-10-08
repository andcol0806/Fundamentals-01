class Weather {
	long thunderClock;
	long[][] drops;
	float[][] leaves;
	int[] col;
	long w, h;
	float wind[];

	Weather(int _w, int _h) {
		w = _w;
		h = _h;
		thunderClock = 0;
		drops = new long[300][3];
		for (int n = 0; n < 300; n++) {
			drops[n][0] = (int)random(W);
			drops[n][1] = -50 + (int)random(H);
			drops[n][2] = 0;
		}
		leaves = new float[300][6];
		col = new int[300];
		for (int n = 0; n < 300; n++) {
			float a = random(6.28);
			leaves[n][0] = 630 + (random(150) * cos(a));
			leaves[n][1] = 240 + (random(150) * sin(a));
			leaves[n][2] = -1;
			leaves[n][3] = 1;
			leaves[n][4] = 0;
			float v = int(random(40));
			col[n] = color(70-v, 55-v, 50-v);
		}
		wind = new float[2];
		wind[0] = 3.1415/1.5;
		wind[1] = 400;
	}

	void thunder() {
		if (thunderClock-- < 0) {
			if ((int)random(200) == 0)
				thunderClock = 1 + (int)random(15);
			fill (0, 0, 0, 120);
		} else 
			fill (0, 0, 0, 0);
		stroke(0);
		rect(0, 0, 835, 655);
	}

	void rain() {
		for (int n = 0; n < 300; n++) {
			stroke(40, 40, 60);
			strokeWeight(2);
			line (drops[n][0], drops[n][1] + (drops[n][2] / 10 * 30), drops[n][0], drops[n][1] + 10 + (drops[n][2] / 10 * 30));
			if (drops[n][2]++ == 40) {
				drops[n][0] = (int)random(w);
				drops[n][1] = -50 + (int)random(h);
				drops[n][2] = 0;
			}
		}
	}

	void leaves(float delta_t) {
		float x, y;
		for (int n = 0; n < 300; n++) {
			if (leaves[n][4] == 1) {
				leaves[n][0] += leaves[n][2];
				leaves[n][1] += leaves[n][3];
				
				if (wind[1]-- == 0) {
					wind[0] += -0.1 + random(0.2);
					wind[1] = 14;
					leaves[n][2] += -0.3 + random(0.6);
					leaves[n][3] += -0.3 + random(0.6);
				}

			
				if (leaves[n][0] < -10 || leaves[n][0] > W + 10 ||
					leaves[n][1] < -10 || leaves[n][1] > H + 10) {
					float a = random(6.28);
					leaves[n][0] = 550 + (int)(random(220) * cos(a));
					leaves[n][1] = 240 + (int)(random(150) * sin(a));
					leaves[n][2] = cos(wind[0]);
					leaves[n][3] = sin(wind[0]);
					leaves[n][4] = 0;
				}

				pushMatrix();
				translate(leaves[n][0], leaves[n][1]);
				strokeWeight(1);
				stroke(col[n]);
				fill(col[n]);
				rotate(atan2(leaves[n][3], leaves[n][2]) + 3.1415/2);
				ellipse(0, 0, 3, 7);
				popMatrix();
			} else {
				if ((int)random(5000) == 0) {
					leaves[n][4] = 1;
				}
			}

		}
	}
}