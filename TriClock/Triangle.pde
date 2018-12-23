final class TriangleClockFace {
  float radius;
  PFont font;
  
  TriangleClockFace(float rad, PFont fnt) {
    radius=rad;
    font=fnt;
  }

  void display() {
    pushStyle();
    
    // Background
    float areaRadius = radius * 0.85f;
    ellipseMode(RADIUS);
    fill(backGround);
    stroke(lightGreen);
    strokeWeight(1.5f);
    ellipse(0f, 0f, areaRadius, areaRadius);
    
    stroke(lightGreen, 30f);
    strokeWeight(1.5f);
    for (int k = 0; k < 12; k++) {
      float angle1 = k * TWO_PI / 12 - HALF_PI;
      for(int m = 0; m < 4; m++) {
        float angle2 = m * TWO_PI / 4 - HALF_PI;
        line(areaRadius * cos(angle1), areaRadius * sin(angle1), areaRadius * cos(angle2), areaRadius * sin(angle2));
      }
    }

    // Ticks
    drawHourTickMarks(0.1f, 1f, lightGreen, 0.1f);
    drawHourNumbers(0.08f, darkGreen, 0f);

    popStyle();
  }
  
    void drawHourTickMarks(float tickSizeFactor, float tickWeight, color tickColor, float paddingFactor) {
    pushStyle();
    strokeCap(SQUARE);
    stroke(tickColor);
    strokeWeight(tickWeight);
    int tickCount = 12;
    for (int i = 0; i < tickCount; i++) {
      float  tickangle = i * TWO_PI / tickCount - HALF_PI;
      float x = cos(tickangle) * radius * (1f - paddingFactor);
      float y = sin(tickangle) * radius * (1f - paddingFactor);

      pushMatrix();
      translate(x, y);
      rotate(tickangle);
      line(- radius * tickSizeFactor, 0f, 0f, 0f);
      popMatrix();
    }
    popStyle();
  }
 
  void drawHourNumbers(float numberSizeFactor, color numberColor, float paddingFactor) {
    pushStyle();
    fill (numberColor);
    int tickCount = 12;
    for (int i = 0; i < tickCount; i++) {
      float tickangle = i * TWO_PI / tickCount - HALF_PI;
      int currentHour = i;
      if (currentHour == 0) {
        currentHour = 12;
      }
      float x = cos(tickangle) * radius * (1f - paddingFactor);
      float y = sin(tickangle) * radius * (1f - paddingFactor);

      textFont(font, radius * numberSizeFactor);
      textAlign(CENTER, BASELINE);
    
      pushMatrix();
      translate(x, y);
      float valignFactor = 1.20;  // Different for each font
      text(currentHour, 0f, (textAscent() - textDescent()) * valignFactor / 2f);
      popMatrix(); 
    }
    
    popStyle();
  }
}


abstract class TriangleClockHand {
  float handLength;
  float handWeight;
  color handColor;
  float handSize;
  boolean isFilled;

  TriangleClockHand(float len, float wgt, color col, float sz, boolean fl) {
    handLength=len;
    handWeight=wgt;
    handColor=col;
    handSize = sz;
    isFilled = fl;
  }

  abstract float getAngle();

  void display() {
    pushStyle();
    stroke(handColor);
    strokeWeight(handWeight);
    if (isFilled) {
      fill(handColor);
    }
    else {
      noFill();
    }
    ellipseMode(CENTER);
    ellipse(handLength * cos(getAngle()), handLength * sin(getAngle()), handSize, handSize);
    popStyle();
  }
}

final class TriangleHourHand extends TriangleClockHand {
  TriangleHourHand(float len, float wid, color col, float sz, boolean fl) {
    super(len, wid, col, sz, fl);
  }

  float getAngle() {
    return hourToRadians12(hourFloat()) - HALF_PI;
  }
}

final class TriangleMinuteHand extends TriangleClockHand {
  TriangleMinuteHand(float len, float wid, color col, float sz, boolean fl) {
    super(len, wid, col, sz, fl);
  }

  float getAngle() {
    return minuteToRadians(minuteFloat()) - HALF_PI;
  }
}

final class TriangleSecondHand extends TriangleClockHand {
  TriangleSecondHand(float len, float wid, color col, float sz, boolean fl) {
    super(len, wid, col, sz, fl);
  }

  float getAngle() {
    return secondToRadians(float(second())) - HALF_PI;
  }
}


final class TriangleClockComponent {
  float radius;
  
  TriangleClockComponent(float rad) {
    radius = rad;
  }
  
  void display() {
    pushStyle();
    stroke(darkGreen);
    strokeWeight(3f);
    noFill();
    float hourAngle = hourToRadians12(hourFloat()) - HALF_PI;
    float minuteAngle = minuteToRadians(minuteFloat()) - HALF_PI;
    float secondAngle = secondToRadians(float(second())) - HALF_PI;
    triangle(radius * cos(hourAngle), radius * sin(hourAngle), radius * cos(minuteAngle), radius * sin(minuteAngle), radius * cos(secondAngle), radius * sin(secondAngle));
    popStyle();
  }
}
