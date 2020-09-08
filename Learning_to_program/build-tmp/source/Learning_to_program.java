import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Learning_to_program extends PApplet {

int N_LINES = 30;

parabolicCurve pc;
axis axis1;
axis axis2;

public void setup() {
  
  axis1 = new axis(100, 100, 400, 150);
  axis2 = new axis(400, 400, 200, 100);
  pc = new parabolicCurve(axis1, axis2, 10);
}

int nFrame = 0;
public void draw() {
  background(0);
  stroke(12, 100, 1);
  strokeWeight(10);
  pc.draw();
  axis1.transform();
  axis2.transform();
  saveFrame("qbvet" + str(nFrame++) + ".gif");  
  int paus = millis() + 10; 
  while (paus > millis()) {
  }
}

class parabolicCurve {
  axis mAxis1, mAxis2;
  int mNLines;
  parabolicCurve(axis a1, axis a2, int n) {
    mAxis1 = a1;
    mAxis2 = a2;  
    mNLines = n;
  }
  
  public void draw() {
    for (int n = 0; n < mNLines; n++) {
      int x1 = mAxis1.getX1() + (mAxis1.getX2() - mAxis1.getX1()) *  n / (mNLines-1);
      int y1 = mAxis1.getY1() + (mAxis1.getY2() - mAxis1.getY1()) *  n / (mNLines-1);
      int x2 = mAxis2.getX1() + (mAxis2.getX2() - mAxis2.getX1()) *  n / (mNLines-1);
      int y2 = mAxis2.getY1() + (mAxis2.getY2() - mAxis2.getY1()) *  n / (mNLines-1);
      int r, g, b;
     
      strokeWeight(10);
      stroke(255, 0, 0);
      line(x1, y1, x2, y2);
      strokeWeight(4);
      stroke(0, 0, 0);
      line(x1, y1, x2, y2);
    }
  }
}

class axis {
  int mX1, mY1, mX2, mY2;
  int mXV1, mYV1, mXV2, mYV2;
  axis() {}
  axis(int x1, int y1, int x2, int y2) {
    set(x1, y1, x2, y2);
  }
  public int getX1() {return mX1;}
  public int getY1() {return mY1;}
  public int getX2() {return mX2;}
  public int getY2() {return mY2;}
 
  public void setV(int xv1, int yv1, int xv2, int yv2)
  {
    mXV1 = xv1;
    mYV1 = yv1;
    mXV2 = xv2;
    mYV1 = yv2;
  }
  public void set(int x1, int y1, int x2, int y2) {
    mX1 = x1; 
    mY1 = y1;
    mX2 = x2;
    mY2 = y2;   
    mXV1 = -20 + (int)random(40); 
    mYV1 = -20 + (int)random(40);
    mXV2 = -20 + (int)random(40);
    mYV2 = -20 + (int)random(40);
  }
  public void transform() {
    mX1 += mXV1;
    mY1 += mYV1;
    mX2 += mXV2;
    mY2 += mYV2;
    if (mX1 < 0 || mX1 > 639) mXV1 = -mXV1;
    if (mY1 < 0 || mY1 > 639) mYV1 = -mYV1;
    if (mX2 < 0 || mX2 > 639) mXV2 = -mXV2;
    if (mY2 < 0 || mY2 > 639) mYV2 = -mYV2;
  }
}

  public void settings() {  size(640, 640); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Learning_to_program" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
