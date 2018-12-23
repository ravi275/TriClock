// Processing 3.3.6

/*
Author : Raviraju Paidimala
E-mail : raviraju606@gmail.com
*/
/*
  The font "Lato" is designed by Łukasz Dziedzic (http://www.latofonts.com/).
  This font is licensed under the SIL Open Font License 1.1 (http://scripts.sil.org/OFL).
*/

PFont Font;
color backGround, lightGreen, darkGreen, orange;
TriangleClockFace face;
ArrayList<TriangleClockHand> hands;
TriangleClockComponent triangle;


void setup() {
  size(320,320);
  smooth(8);

  // Prepare font
  Font = createFont("Lato-Regular.ttf", 24, true);

  // Prepare colors
  colorMode(HSB, 360f, 100f, 100f, 100f);
  backGround = color( #0A111D );
  lightGreen = color( #3CAB58 );
  darkGreen = color( #12C740 );
  orange = color( #FF4848 );
  
  float clockFaceRadius = height*0.45f;
  
  face = new TriangleClockFace(clockFaceRadius,Font);
  hands = new ArrayList<TriangleClockHand>();
  hands.add(new TriangleHourHand(clockFaceRadius * 0.85f, 1f, orange, 30f, true));
  hands.add(new TriangleMinuteHand(clockFaceRadius * 0.85f , 1f ,orange ,22f,true));
  hands.add(new TriangleSecondHand(clockFaceRadius * 0.85f , 1f ,orange ,20f,false));
  triangle = new TriangleClockComponent(clockFaceRadius * 0.85f);
  
}

void draw() {
  
  
  pushMatrix();
  background(backGround);
  translate(width * 0.5f, height * 0.5f);
  
  face.display();
  for (TriangleClockHand currentHand : hands) { currentHand.display(); }
  triangle.display();
  
  popMatrix();
    
}



// Utility

float hourFloat() {
  return float(hour()) + norm(minuteFloat(), 0f, 60f);
}
float minuteFloat() {
  return float(minute()) + norm(float(second()), 0f, 60f);
}

float hourToRadians24(float h) {
  return map(h, 0f, 24f, 0f, TWO_PI);
}
float hourToRadians12(float h) {
  return map(h, 0f, 24f, 0f, TWO_PI * 2);
}
float minuteToRadians(float m) {
  return map(m, 0f, 60f, 0f, TWO_PI);
}
float secondToRadians(float s) {
  return map(s, 0f, 60f, 0f, TWO_PI);
}
