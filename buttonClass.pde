
class Button {
  String bText;
  int x, y;
  
  void display() {
    rectMode(CENTER);
    fill(0);
    stroke(255);
    rect(x, y, 100, 50);
    fill(255);
    textSize(40);
    text(bText, x, y);
    rectMode(CORNER);
  }
  
  Button(String bText, int x, int y){
    this.bText = bText;
    this.x = x;
    this.y = y;
  }
}
