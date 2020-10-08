class GameOfLife {
	final int[] neighbours = {1, 1, 1, 1, 0, 1, 1, 1, 1};
	final int[] deadOrAlive = {0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0};
	int[] gamefield;
	int[] gamefieldNew;
	float[] colorMap;
	int w, h;
	int cellW, cellH;

	GameOfLife(int w, int h, int cellW, int cellH) {
		this.w = w / cellW;
		this.h = h / cellH;
		this.cellW = cellW;
		this.cellH = cellH;
		gamefield = new int[this.w * this.h];
		gamefieldNew = new int[this.w * this.h];
		colorMap = new float[this.w * this.h];
		randomize();
	}
	
	int nNeighbours(int at) {
		int n = 0;
		for (int i = 0; i < 9; i++)
			n += neighbours[i] * gamefield[(at - w - 1 + i % 3) + i / 3 * w];
		return n;
	}

	void checkNeighbours() {
		for (int n = w + 1; n < ((w - 1) * (h - 1)); n++) {
			gamefieldNew[n] = deadOrAlive[nNeighbours(n) + gamefield[n] * 9];
			colorMap[n] = (float)nNeighbours(n);
		}
	}	

	void filter() {
		for (int n = w + 1; n < (w - 1) * (h - 1); n++) {
			colorMap[n] = (colorMap[n] + colorMap[n - w] + colorMap[n + w] + 
				colorMap[n - 1] + colorMap[n + 1] + colorMap[n - w - 1] + 
				colorMap[n - w + 1] + colorMap[n + w - 1] + colorMap[n + w + 1]) / 9;
		}
	}

	void draw() {	
		checkNeighbours();
		arrayCopy(gamefieldNew, gamefield);
		filter();
		filter();
		filter();
		strokeWeight(0);
		
		fft.forward(transAm.mix);
	
		for (int n = 0; n < (w * h); n++) {
			float x = (n % w);
			float y = (n / w);
			float x0 = -200 + y * cellW;
			float y0 = 400 + y * cellH;
			PShape s = new PShape();
			switch (colorMode) {
				case 0: fill (colorMap[n] * 100 * n / w, colorMap[n] * 10 * n % w, 0, 128); 
						s = createShape(RECT, x0 + x * cos(-0.3) * cellW, y0 + x * sin(-0.3) * cellH, 10, -colorMap[n] * 25);
						break;
			
				case 1: fill (255 - colorMap[n] * 100, colorMap[n]*100, 255, 150);
						s = createShape(RECT, x0 + x * cos(-0.3) * cellW, y0 + x * sin(-0.3) * cellH, 10, -colorMap[n] * 25);
						break;

				case 2: fill (255 - colorMap[n], n % w, cos(n / 100) * 255, 64);
						s = createShape(RECT, x0 + x * cos(-0.3) * cellW, y0 + x * sin(-0.3) * cellH, 10, -colorMap[n] * 25);
						break;
			
				case 3: fill (colorMap[n], colorMap[n] *100, 255 + n / w, 255);
						strokeWeight(2);
						double l = fft.getBand(n * fft.specSize() / (w * h));
						s = createShape(RECT, x0 + x * cos(-0.3) * cellW, y0 + x * sin(-0.3) * cellH, 10, -(colorMap[n] * 25 + (float)l/10));
						break;
			}
			shape(s);
		}
	}

	void randomize() {
		for (int n = 0; n < w * h; n++)
			gamefield[n] = (int)random(0, 4) / 3;
	}
}