class Player {
  float x = 400.0; // Setting this as (width/2) returns 50.0? But width/2 println = 400
  float y = 500.0;
  float diameter = 30.0;
  float total_up = 0.0;
  float total_right = 0.0;
  
  void display() {
    pushMatrix();
    fill(0, 255, 0);
    stroke(0, 0, 255);
    //println(width/2);
    translate(x, y);
    //println(width/2);
    ellipse(0, 0, diameter, diameter);
    popMatrix();
    
  }
  
  void hopRight() {
    x += 40.0;
    total_right += 1.0;
  }
  void hopLeft() {
    x -= 40.0;
    total_right -= 1.0;
  }
  
  Player() {
    // nothing...
  }
}
