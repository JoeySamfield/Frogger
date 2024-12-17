class Water {
  float x;
  float y;
  float w;
  float h;
  Log log1;
  Log log2;
  Log log3;
  
  void display() {
    pushMatrix();
    rectMode(CORNER);
    fill(100, 100, 255);
    translate(x, y);
    rect(0, 0, w, h);
    // Logs
    log1.drawAt(log1.x, log1.y);
    log2.drawAt(log2.x, log2.y);
    log3.drawAt(log3.x, log3.y);
    
    popMatrix();
  }
  
  void advance() {
    log1.advance();
    log2.advance();
    log3.advance();
  }
  
  void hopUp(){
    this.y += 50.0;
  }
  void hopDown(){
    this.y -= 50.0;
  }
  
  Water(float x, float y, float w, float h, Log log1, Log log2, Log log3){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.log1 = log1;
    this.log2 = log2;
    this.log3 = log3;
  }
}
