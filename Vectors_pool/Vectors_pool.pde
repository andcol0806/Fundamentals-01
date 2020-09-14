final int tableWidth = 830;
final int tableHeight = 396;
final int tableOffsetX = (1080 - tableWidth) / 2;
final int tableOffsetY = (720 - tableHeight) / 2;
final int ballSize = 25;
int[][] holes = {{0, 0}, {415, 0}, {830, 0},
				 {0, 394}, {415, 394}, {830, 394}};

ArrayList<ball> balls = new ArrayList<ball>();
PImage poolTable;
float power, savedPower;
int state; 
int time;

void setup() {
  size(1080, 720);
  poolTable = loadImage("pooltable.jpg");
  power = 0.0f;
  state = 0; // 0 = aim. 1 = applying force
  time = 0;  // start time for applying force
  balls.add(new ball(620, 131 + ballSize * 2, color(255, 255, 255)));
  balls.add(new ball(220, 131, color(255, 0, 0)));
  balls.add(new ball(220, 131 + 1 * ballSize, color(255, 0, 0)));
  balls.add(new ball(220, 131 + 2 * ballSize, color(255, 0, 0)));
  balls.add(new ball(220, 131 + 3 * ballSize, color(255, 0, 0)));
  balls.add(new ball(220, 131 + 4 * ballSize, color(255, 0, 0)));
  balls.add(new ball(220 + 1 * ballSize - 2, 131 + ballSize / 2, color(255, 0, 0))); // next column
  balls.add(new ball(220 + 1 * ballSize - 2, 131 + ballSize / 2 + ballSize, color(255, 0, 0)));
  balls.add(new ball(220 + 1 * ballSize - 2, 131 + ballSize / 2 + ballSize * 2, color(255, 0, 0)));
  balls.add(new ball(220 + 1 * ballSize - 2, 131 + ballSize / 2 + ballSize * 3, color(255, 0, 0)));
  balls.add(new ball(220 + 2 * ballSize - 4, 131 + ballSize, color(255, 0, 0))); // ...	
  balls.add(new ball(220 + 2 * ballSize - 4, 131 + ballSize * 2, color(255, 0, 0)));
  balls.add(new ball(220 + 2 * ballSize - 4, 131 + ballSize * 3, color(255, 0, 0)));
  balls.add(new ball(220 + 3 * ballSize - 6, 131 + ballSize / 2 + ballSize, color(255, 0, 0))); // ...
  balls.add(new ball(220 + 3 * ballSize - 6, 131 + ballSize / 2 + ballSize * 2, color(255, 0, 0)));
  balls.add(new ball(220 + 4 * ballSize - 8, 131 + ballSize * 2, color(255, 0, 0))); // front ball
}


void draw() {
	background(color(192, 192, 192));
	drawPoolTable(tableOffsetX, tableOffsetY);
	drawBalls(tableOffsetX, tableOffsetY);
	//drawHoles(tableOffsetX, tableOffsetY);
	transformBalls(tableOffsetX, tableOffsetY);
	drawCue(tableOffsetX, tableOffsetY, power);
	stateMachine();
}

void stateMachine() {
	if (state == 0 && mousePressed) {
		time = millis();
		state = 1;
	}
	if (state == 1 && mousePressed) {
		power = (millis() - time) / 20;
		if (power >= 100) power = 100;
	} else if (state == 1 && !mousePressed) {
		state = 2;
		savedPower = power;
		time = millis();
	}
	if (state == 2) {
		power -= (millis() - time) / 20;
		if (power <= 0) {
			balls.get(0).direction.set((balls.get(0).pos.x + tableOffsetX) - mouseX, (balls.get(0).pos.y + tableOffsetY) - mouseY);
			balls.get(0).direction.mult(0.08f * savedPower / 100);
			state = 3;
		}
	}
	if (state == 3) {
		if (balls.get(0).direction.x == 0 && balls.get(0).direction.y == 0) {
			state = 0;
			power = 0;
			savedPower = 0;
		}
	}
}


void drawCue(int x, int y, float power) {
		if (state == 3)
			return;
		float angle = atan2((balls.get(0).pos.y + y) - mouseY, (balls.get(0).pos.x + x) - mouseX);
		stroke(255, 255, 255);
		strokeWeight(3);
		line (balls.get(0).pos.x + x + (ballSize + power) * cos(angle + 3.1415), 
			  balls.get(0).pos.y + y + (ballSize + power) * sin(angle + 3.1415), 
			  balls.get(0).pos.x + x + (ballSize + power + 2) * cos(angle + 3.1415), 
			  balls.get(0).pos.y + y + (ballSize + power + 2) * sin(angle + 3.1415));
		stroke(210, 148, 84);
		strokeWeight(4);
		line (balls.get(0).pos.x + x + (ballSize + power + 3) * cos(angle + 3.1415), 
			  balls.get(0).pos.y + y + (ballSize + power + 3) * sin(angle + 3.1415), 
			  balls.get(0).pos.x + x + (ballSize + power + 300) * cos(angle + 3.1415), 
			  balls.get(0).pos.y + y + (ballSize + power + 300) * sin(angle + 3.1415));
		stroke(128, 64, 30);
		strokeWeight(6);
		line (balls.get(0).pos.x + x + (ballSize + power + 100) * cos(angle + 3.1415), 
			  balls.get(0).pos.y + y + (ballSize + power + 100) * sin(angle + 3.1415), 
			  balls.get(0).pos.x + x + (ballSize + power + 300) * cos(angle + 3.1415), 
			  balls.get(0).pos.y + y + (ballSize + power + 300) * sin(angle + 3.1415));
}




// ------------------------

class ball {
	PVector pos;
	PVector direction;
	PVector acc;
	color c;
	boolean active;
	ball (int _x, int _y, color _c) {
		pos = new PVector(_x, _y);
		direction = new PVector(0, 0);
		acc = new PVector(0, 0);
		direction.limit(1);
		c = _c;
		active = true;
	}
	void draw(int xOffset, int yOffset) {
		int x = xOffset, y = yOffset;
		strokeWeight(1);
		stroke(c);
		fill(c);
		circle(pos.x + xOffset, pos.y + yOffset, ballSize);
		/*stroke(255, 255, 0);
		strokeWeight(2);
		line (pos.x + x, pos.y + y, pos.x + direction.x * 100 + x, pos.y + direction.y * 100 + y);
		stroke(0, 0, 255);
		line (pos.x + x, pos.y + y, pos.x + direction.x * 100 + x, pos.y + direction.y * 100 + y);*/
	}
}


void drawPoolTable(int xOffset, int yOffset) {
	image(poolTable, (1080 - poolTable.width) / 2, (720 - poolTable.height) / 2);
}

void drawBalls(int xOffset, int yOffset) {
	for (ball b : balls) {
		if (b.active == true) {
			b.draw(xOffset, yOffset);		
		}
	}
}

void drawHoles(int xOffset, int yOffset) {
	for (int n = 0; n < 6; n++) {
		stroke(255, 0, 0);
		fill(255, 0, 0);
		circle (xOffset + holes[n][0], yOffset + holes[n][1], ballSize);
	}
}

void transformBalls(int x, int y) {
	for (ball b : balls) {
		if (b.active == true) {
			b.acc.x = -b.direction.x * 0.008f;
			b.acc.y = -b.direction.y * 0.008f;
			b.direction.add(b.acc);
			b.pos.add(b.direction);
		
			if (b.pos.x > tableWidth - (ballSize / 2)) {
				b.pos.sub(b.direction);
				b.direction.x = -b.direction.x;
			}
			if (b.pos.x < (ballSize / 2)) {
				b.pos.sub(b.direction);
				b.direction.x = -b.direction.x;
			}
			if (b.pos.y > tableHeight - (ballSize / 2)) {
				b.pos.sub(b.direction);
				b.direction.y = -b.direction.y;
			}
			if (b.pos.y < (ballSize / 2)) {
				b.pos.sub(b.direction);
				b.direction.y = -b.direction.y;
			}

			if (abs(b.direction.x * b.direction.x + b.direction.y * b.direction.y) < 0.01f) {
				b.direction.x = 0;
				b.direction.y = 0;
			}
	
			for (int nHole = 0; nHole < 6; nHole++) {
				float xD = holes[nHole][0] - b.pos.x;
				float yD = holes[nHole][1] - b.pos.y;
				if ((xD * xD + yD * yD) < (ballSize * ballSize)) {
					// Goes in hole!
					b.active = false;
				}
			}
		}
	}
	
	double xDist, yDist;
	for(int i = 0; i < balls.size(); i++) {
		ball A = balls.get(i);
		if (A.active == true) {
			for(int j = i+1; j < balls.size(); j++) {
				ball B = balls.get(j);
				if (B.active == true) {
					xDist = A.pos.x - B.pos.x;
					yDist = A.pos.y - B.pos.y;
					double distSquared = xDist*xDist + yDist*yDist;
					//Check the squared distances instead of the the distances, same result, but avoids a square root.
					if(distSquared <= (ballSize * ballSize)) {
						double xVelocity = B.direction.x - A.direction.x;
						double yVelocity = B.direction.y - A.direction.y;
						double dotProduct = xDist*xVelocity + yDist*yVelocity;
						//Neat vector maths, used for checking if the objects moves towards one another.
						if(dotProduct > 0) {
							double collisionScale = dotProduct / distSquared;
							double xCollision = xDist * collisionScale;
							double yCollision = yDist * collisionScale;
							A.direction.x += xCollision;
							A.direction.y += yCollision;
							B.direction.x -= xCollision;
							B.direction.y -= yCollision;
						}
					}
				}
			}
		}
	}
}

