class Log {
  float x; // 875.0,  
  float y; // 125.0, 
  float time;
  float w;
  float h;
  float speed;
  boolean left;
  //float true_y = y + 75.0; This wouldn't have worked, but why? It just returned 75
                              // so how can I init variable as relative to another?
  
  void drawAt(float x, float y) {
    pushMatrix();
    translate(x, y);
    rectMode(CENTER);
    fill(85, 69, 69);
    rect(0, 0, 150, 40);
    popMatrix();
  }
  
  void advance() {
    if (left) {
      this.x = lerp(875.0, -75.0, time);
      time += speed;
      if (time > 1.0) {
        time = 0.0;
      }
    }
    else {
      this.x = lerp(-75.0, 875.0, time);
      time += speed;
      if (time > 1.0) {
        time = 0.0;
      }
    }
  }
  
  Log(float x, float y, float time, float w, float h, float speed, boolean left) {
    this.x = x;
    this.y = y;
    this.time = time;
    this.w = w;
    this.h = h;
    this.speed = speed;
    this.left = left;
  }
}
