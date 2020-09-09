PVector mouseVector;
PVector ballVector;
PVector directionVector;

final int RADIUS = 100;
final int ELASTICITY = 20;

void setup() {
  	size(640, 640);
	fill(0, 255, 0);
	strokeWeight(3);
	stroke(0, 255, 0);
  	mouseVector = new PVector(mouseX, mouseX);
  	ballVector = new PVector(320, 320);
  	directionVector = new PVector(0, 0);
  	directionVector.limit(5);
}

void draw() {
	background(0);
  	ballVector.add(directionVector);
  	if (mousePressed == true) {
  		line (ballVector.x, ballVector.y, mouseX, mouseY);
  		mouseVector.set(mouseX, mouseY);
  	}
  	collisionCheck();
  	drawBall();
  	motionBlur();
}

void mouseReleased () {
	mouseVector.set(mouseX, mouseY);
	directionVector = PVector.sub(mouseVector, ballVector);
	directionVector.mult(0.01);
}

void collisionCheck () {
 	if (ballVector.x > 639 - ELASTICITY) directionVector.x = -directionVector.x;
  	if (ballVector.x < 0 + ELASTICITY) directionVector.x = -directionVector.x;
  	if (ballVector.y > 639 - ELASTICITY) directionVector.y = -directionVector.y;
	if (ballVector.y < 0 + ELASTICITY) directionVector.y = -directionVector.y;
}

void drawBall() {
	int ellipseX = RADIUS;
	int ellipseY = RADIUS;
        // If up against a wall, adjust the radii to simulate an elastic bounce.
	if (ballVector.x > (640 - ellipseX / 2)) {
		ellipseX = (640 - (int)ballVector.x) * 2;
		ellipseY = ((int)ballVector.x - (640 - (RADIUS / 2))) * 2 + RADIUS;
	} elseif (ballVector.x < ellipseX / 2) {
		ellipseX = (int)ballVector.x * 2;
		ellipseY = ((RADIUS / 2) - (int)ballVector.x) * 2 + RADIUS;
	}
	if (ballVector.y > (640 - ellipseY / 2)) {
		ellipseY = (640 - (int)ballVector.y) * 2;
		ellipseX = ((int)ballVector.y - (640 - (RADIUS / 2))) * 2 + RADIUS;
	} elseif (ballVector.y < ellipseX / 2) {
		ellipseY = (int)ballVector.y * 2;
		ellipseX = ((RADIUS / 2) - (int)ballVector.y) * 2 + RADIUS;
	}
	ellipse(ballVector.x, ballVector.y, ellipseX, ellipseY);
}


void motionBlur() {
	loadPixels();
	for (int i = 0; i < (width * height); i++) {
  		color c = pixels[i];
  		int r = (c >> 16) & 0xFF;
  		int g = (c >> 8) & 0xFF;
  		int b = c & 0xFF;
  		int alpha = 25;
  		pixels[i] = (alpha << 24) + (r << 16) + (g << 8) + b;
	}
	updatePixels();
}
