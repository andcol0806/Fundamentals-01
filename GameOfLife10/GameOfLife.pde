class GameOfLife {
	final int neighbours[] = {1, 1, 1, 1, 0, 1, 1, 1, 1};
	final int deadOrAlive[] = {0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0};
	int[] gamefield;
	int[] gamefieldNew;
	int w, h;
	int cellW, cellH;

	GameOfLife(int w, int h, int cellW, int cellH) {
		this.w = w / cellW;
		this.h = h / cellH;
		this.cellW = cellW;
		this.cellH = cellH;
		gamefield = new int[this.w * this.h];
		gamefieldNew = new int[this.w * this.h];
		randomize();
	}
	
	int nNeighbours(int at) {
		int n = 0;
		for (int i = 0; i < 9; i++)
			n += neighbours[i] * gamefield[(at - w - 1 + i % 3) + i / 3 * w];
		return n;
	}

	void checkNeighbours() {
		for (int n = w + 1; n < ((w - 1) * (h - 1)); n++)
			gamefieldNew[n] = deadOrAlive[nNeighbours(n) + gamefield[n] * 9];
	}	

	void draw() {	
		checkNeighbours();
		updateNew();
		for (int n = 0; n < (w * h); n++) {
			fill(255 * gamefield[n], 0, 0);
			rect(n % w * cellW, n / w * cellH, cellW, cellH);
		}
	}

	void randomize() {
		for (int n = 0; n < w * h; n++)
			gamefield[n] = (int)random(0, 4) / 3;
	}

	void updateNew() {
		for (int n = 0; n < w * h; n++)
			gamefield[n] = gamefieldNew[n];
	}
}
