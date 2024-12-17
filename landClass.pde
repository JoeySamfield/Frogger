class Land {
  float h;
  float w;
  float x;
  float y;
  color c;
  
  void display() {
    pushMatrix();
    rectMode(CORNER);
    fill(c);
    translate(x, y);
    rect(0, 0, w, h);
    popMatrix();
  }
  
  void hopUp() {
    this.y += 50.0;
  }
  void hopDown() {
    this.y -= 50.0;
  }
  
  
  Land(float x, float y, float w, float h, color c) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.c = c;
  }
}
