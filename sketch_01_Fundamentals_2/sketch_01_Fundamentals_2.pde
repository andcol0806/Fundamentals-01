// Andreas Collvin, GP20 aka. Qbvet
int[][][] fontData = new int[256][13][13];
int[] rightTrim = new int[256];

void setup()
{
  size(768, 432);
  noSmooth();
  background(0, 0, 0);
  fill(color(255, 255, 255));
 
  // Draw ASCII table, and store pixel data into my font.
  for (int nChar = 0; nChar < 256; nChar++)
    text(char(nChar), (nChar % 16) * 14, 23 + (nChar / 16) * 14);
      
  for (int nChar = 0; nChar < 256; nChar++)
  {
    int trimGrade = 0;
    for (int x = 0; x < 13; x++)
      for (int y = 0; y < 13; y++) 
      { 
        if (get(x + (nChar % 16) * 14, 12 + y + (nChar / 16) * 14) == color(255, 255, 255))
        {  
          fontData[nChar][y][x] = 1;
          if (x > trimGrade)
            trimGrade = x;
        }
      }  
    rightTrim[nChar] = (trimGrade + 2);   // To get rid of excess space
  }
}

boolean hasPixel(int[][] letter, int x, int y)
{
  // Does the letter (or char...) have a pixel at (x, y)?
  if ((y >= 0) && (y < letter.length))
    if ((x >= 0) && (x < letter[y].length))
      if (letter[y][x] == 1)
        return true;
  return false;
}

void drawLetter(int[][] letter, int xPos, int yPos, int size, int spread, int thunder)
{
  // Clip character out of view.
  if (xPos < -(12 * size) || xPos > 767)
    return;

  // Draw one character. Spice it up with my own font.
  for (int y = 0; y < letter.length; y++)
    for (int x = 0; x < letter[y].length; x++)
    {
      if (letter[y][x] != 0) 
      {
        int x1, x2, y1, y2, tx1, tx2, ty1, ty2;
        for (int nY = -1; nY < 2; nY++)
          for (int nX = -1; nX < 2; nX++)
          {
            // Check the current pixel's pixel neighbours.
            if (hasPixel(letter, x + nX, y + nY))
            {
              x1 = xPos + x * size;
              y1 = yPos + y * size;
              x2 = xPos + (nX + x) * size;
              y2 = yPos + (nY + y) * size;
              for (int t = 0; t < thunder; t++)
              {
                int rand = int(random(255));
                int r = 255 - rand;
                int g = 255 - rand;
                int b = 255 - rand / 10;
                stroke(r, g, b);
                strokeWeight(int(random(10)));

                tx1 = x1 - spread / 2 + int(random(spread));
                ty1 = y1 - spread / 2 + int(random(spread));
                tx2 = x2 - spread / 2 + int(random(spread));
                ty2 = y2 - spread / 2 + int(random(spread));
                line (tx1, ty1, tx2, ty2);
              }
            }
          }
      }
    }
}

void drawText(String txt, int x, int y, int size, int spread, int thunder)
{
  int xOffset = x;
  for (int n = 0; n < txt.length(); n++)
  {
    drawLetter(fontData[txt.charAt(n)], xOffset, y, size, spread, thunder);
    xOffset += (rightTrim[txt.charAt(n)] + 2) * size;
  }
}

int scroll = 0;
//int nFrame = 0; // For gif
void draw()
{
  background(0, 0, 0);
  drawText("-- QBVET", 0, 300, 10, 15, 5);
  drawText("    [INSERT CHEESY POEM]", scroll, 100, 15, 24, 10);
  scroll -= 15;
  
  //saveFrame("qbvet" + str(nFrame++) + ".gif");  
  int paus = millis() + 100; 
  while (paus > millis()) {
  }
}
