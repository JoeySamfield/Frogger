class Car {
  float x; // was 830.0
  float y;
  float time; // was 0.0
  float diameter = 40.0;
  float speed; // 0.0015
  boolean left; // determines direction
  
  void display() {
    pushMatrix();
    fill(200, 100, 0);
    translate(x, y);
    ellipse(0, 0, diameter, diameter);
    popMatrix();
  }
  
  void advance() {
    if (left) {
      this.x = lerp(830.0, -30.0, time);
      time += speed;
      if (time > 1.0) {
        time = 0.0;
      }
    }
    else {
      this.x = lerp(-30.0, 830.0, time);
      time += speed;
      if (time > 1.0) {
        time = 0.0;
      }
    }
  }
  
  // Hop functions -- should change universal coords.
  void hopUp() {
    this.y += 50.0;
  }
  
  void hopDown() {
    this.y -= 50.0;
  }
  
  Car(float x, float y, float time, float speed, boolean left) {
    this.x = x;
    this.y = y;
    this.time = time;
    this.speed = speed;
    this.left = left;
    //this.time = 0.0; // Or init at top? What's the difference?
  }
}
