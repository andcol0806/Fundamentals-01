// Mitt nickname: Qbvet

int[][] Q = {{0, 1, 1, 1, 1, 0}, 
             {1, 0, 0, 0, 0, 1}, 
             {1, 0, 0, 0, 0, 1}, 
             {1, 0, 0, 1, 0, 1}, 
             {0, 1, 1, 1, 1, 0}, 
             {0, 0, 0, 0, 0, 1}};

int[][] b = {{1, 0, 0, 0, 0, 0}, 
             {1, 0, 0, 0, 0, 0}, 
             {1, 1, 1, 0, 0, 0}, 
             {1, 0, 0, 1, 0, 0}, 
             {1, 0, 0, 1, 0, 0}, 
             {1, 1, 1, 0, 0, 0}};

int[][] v = {{0, 0, 0, 0, 0, 0}, 
             {0, 0, 0, 0, 0, 0}, 
             {1, 0, 0, 0, 1, 0}, 
             {0, 1, 0, 1, 0, 0}, 
             {0, 1, 0, 1, 0, 0}, 
             {0, 0, 1, 0, 0, 0}};

int[][] e = {{0, 0, 0, 0, 0, 0}, 
             {0, 1, 1, 1, 0, 0}, 
             {1, 0, 0, 0, 1, 0}, 
             {1, 1, 1, 1, 0, 0}, 
             {0, 1, 0, 0, 0, 0}, 
             {0, 0, 1, 1, 1, 0}};

int[][] t = {{0, 0, 1, 0, 0, 0}, 
             {0, 0, 1, 0, 0, 0}, 
             {1, 1, 1, 1, 1, 0}, 
             {0, 0, 1, 0, 0, 0}, 
             {0, 0, 1, 0, 0, 0}, 
             {0, 0, 0, 1, 0, 0}};

//int nFrame = 0; // till gif-animationen

void setup()
{
  size(768, 432);
  strokeWeight(1);
}

boolean foundNeighbour(int[][] letter, int x, int y)
{
  if ((y >= 0) && (y < letter.length))
    if ((x >= 0) && (x < letter[y].length))
      if (letter[y][x] == 1)
        return true;
  return false;
}

void drawLetter(int[][] letter, int xPos, int yPos)
{
  for (int y = 0; y < letter.length; y++)
    for (int x = 0; x < letter[y].length; x++)
    {
      if (letter[y][x] != 0) 
      {
        int x1, x2, y1, y2, tx1, tx2, ty1, ty2;
        for (int nY = -1; nY < 2; nY++)
          for (int nX = -1; nX < 2; nX++)
          {
            if (foundNeighbour(letter, x + nX, y + nY))
            {
              x1 = xPos + x * 25;
              y1 = yPos + y * 25;
              x2 = xPos + (nX + x) * 25;
              y2 = yPos + (nY + y) * 25;
              for (int thunder = 0; thunder < 4; thunder++)
              {
                int rand = int(random(255));
                int r = 255 - rand;
                int g = 255 - rand;
                int b = 255 - rand / 10;
                stroke(r, g, b);
                strokeWeight(int(random(10)));
                
                tx1 = x1 - 7 + int(random(15));
                ty1 = y1 - 7 + int(random(15));
                tx2 = x2 - 7 + int(random(15));
                ty2 = y2 - 7 + int(random(15));
                line (tx1, ty1, tx2, ty2);
              }
            }
          }
      }
    }
}



void draw()
{
  background(0, 0, 0);
  drawLetter(Q, 50, 140);
  drawLetter(b, 220, 140);
  drawLetter(v, 320, 140);
  drawLetter(e, 460, 140);
  drawLetter(t, 600, 140);
  //saveFrame("qbvet" + str(nFrame++) + ".gif");  // spara frames till gif-animation
  int paus = millis() + 100; 
  while (paus > millis()) {}
}
