ArrayList<Nyoro> nyoroList;

void mouseClicked() {
  setup();
}

void setup() {
  size(500, 500);
  noStroke();
  background(255);
  colorMode(HSB, 255);
  
  nyoroList = new ArrayList<Nyoro>();
  for (int i = 0; i < 30; i++)
    nyoroList.add(new Nyoro());
}

void draw() {
  fill(0, 0, 0, 1);
  rect(0, 0, width, height);
  
  for (Nyoro nyoro : nyoroList) {
    nyoro.move();
    nyoro.draw();
  }
}

class Nyoro {
  float x;
  float y;
  float angle;
  float size;
  float hue;
  float speed;
  
  Nyoro() {
    x = width / 2 + random(10) - 5;
    y = height / 2 + random(10) - 5;
    angle = random(TWO_PI);
    size = random(15) + 5;
    hue = random(255);
    speed = random(1) + 1;
  }
  
  void move() {
    float awayAngle = 0;
    int cnt = 0;
    
    for (Nyoro nyoro : nyoroList) {
      float dx = x - nyoro.x;
      float dy = y - nyoro.y;
      if (sqrt(dx*dx+dy*dy) < 200) {
        awayAngle += atan2(dy, dx);
        cnt++;
      }
    }
    
    awayAngle /= cnt;
    if (awayAngle < 0) awayAngle += TWO_PI;
    if (angle < 0) angle += TWO_PI;
    angle += (awayAngle - angle) > 0 ? 0.017 : -0.017;

    float mx = mouseX - x;
    float my = mouseY - y;
    if (sqrt(mx*mx+my*my) < 200) {
      awayAngle += atan2(my, mx);
      if (awayAngle < 0) awayAngle += TWO_PI;
      if (angle < 0) angle += TWO_PI;
      angle += (awayAngle - angle) > 0 ? 0.08 : -0.08;
    }

    float dx = cos(angle) * speed;
    float dy = sin(angle) * speed;
    x += dx;
    y += dy;

    if (x < 0)      { x = 0;      angle = atan2(dy, -dx); }
    if (x > width)  { x = width;  angle = atan2(dy, -dx); }
    if (y < 0)      { y = 0;      angle = atan2(-dy, dx); }
    if (y > height) { y = height; angle = atan2(-dy, dx); }
  }
  
  void draw() {
    float dx = mouseX - x;
    float dy = mouseY - y;
    float d = sqrt(dx*dx+dy*dy);
    float v = (200 - d) / 200.0;
    float sat = (v > 0) ? v * 55 + 200 : 200;
    float bri = (v > 0) ? v * 55 + 200 : 200;
    fill(hue, sat, bri);
    ellipse(x, y, size, size);
  }  
}

