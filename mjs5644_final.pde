import processing.sound.*;
SoundFile sans;

// Score input
String username = "";

JSONArray scores;
// Time variable
float m;
float mAtPause;
float mToToss;

// Menu Booleans
boolean mainMenu = true;
boolean pauseMenu = false;
boolean gameOn = false;
boolean victory = false;
boolean fatal = false; // Putting here so Pause can alter and reset board.
// Images
PImage frog;
// Player
Player player = new Player();
// Buttons
Button playButt;
// Cars
ArrayList<Car> carList = new ArrayList<Car>();
// (x, y, time)
Car car1 = new Car(830.0, 450.0, 0.0, 0.0015, true); // Why did it not work when I tried "Car car1;" here, and 
                           // "Car car1 = new Car(600.0);" in setup? I got a 
                           // nullPointerException, so why doesn't drawPlay see the 
                           // line when it's in setup()?
//carList.add(new Car(450.0)); // Likewise, I couldn't add to list here.
                               // Supposed syntax error.

                           
Car car2 = new Car(830.0, 450.0, 0.33, 0.0015, true);
Car car3 = new Car(830.0, 450.0, 0.66, 0.0015, true);

Car car4 = new Car(830.0, 400.0, 0.5, 0.002, false);
Car car5 = new Car(830.0, 400.0, 0.1, 0.002, false);
Car car6 = new Car(830.0, 400.0, 0.8, 0.002, false);

Car car7 = new Car(830.0, 350.0, 0.2, 0.001, true);
Car car8 = new Car(830.0, 350.0, 0.6, 0.001, true);
Car car9 = new Car(830.0, 350.0, 0.9, 0.001, true);

Car car10 = new Car(830.0, 300.0, 0.7, 0.0025, false);
Car car11 = new Car(830.0, 300.0, 0.4, 0.0025, false);
Car car12 = new Car(830.0, 300.0, 0.05, 0.0025, false);

// Logs
ArrayList<Log> logList = new ArrayList<Log>();
Log log1 = new Log(875.0, 125.0, 0.0, 150.0, 40.0, 0.0015, true);
Log log2 = new Log(-75.0, 75.0, 0.0, 150.0, 40.0, 0.001, false);
Log log3 = new Log(875.0, 25.0, 0.3, 150.0, 40.0, 0.0015, true);

// Land

Land asphalt = new Land(0.0, 275.0, 800.0, 200.0, color(0, 0, 0));
Land finish = new Land(0.0, 25.0, 800.0, 50.0, color(255, 255, 0));
Water pond = new Water(0.0, 75.0, 800.0, 150.0, log1, log2, log3);


void setup() {
  JSONArray scores = loadJSONArray("scores.json");
  
  sans = new SoundFile(this, "sans.mp3");
  if (mainMenu) {
    sans.play();
  }
  else {
    sans.stop();
  }
  //Car car1 = new Car(450.0);
  //Car car2 = new Car(450.0);
  //Car car3 = new Car(450.0);
  logList.add(log1);
  logList.add(log2);
  logList.add(log3);
  
  carList.add(car1);
  carList.add(car2);
  carList.add(car3);
  carList.add(car4);
  carList.add(car5);
  carList.add(car6);
  carList.add(car7);
  carList.add(car8);
  carList.add(car9);
  carList.add(car10);
  carList.add(car11);
  carList.add(car12);
  
  frog = loadImage("frogbert.jpg");
  frog.loadPixels();
  size(800, 900);
  // Time variables
  m = 0.0;
  mAtPause = 0.0;
  mToToss = 0.0;
}

void draw() {
  if (mainMenu) {
    drawMainMenu();
    mToToss = (millis() + 0.0)/1000.0;
  }
  // When game on, with no Pause or Victory Screen
  if (gameOn && !pauseMenu && !victory) {
    drawPlay();
    m = (millis()/1000.0) - mToToss;
  }
  if (pauseMenu) {
    drawPause();
    mToToss = (millis()/1000.0) - m; // 

  }
  if (victory){
    drawVictory(m);
  }
  //println(m);
}

void drawMainMenu() {
  // Increment for drawing Scores
  int text_incr = 50;
  // Background
  background(50, 200, 50);
  
  // Title Text
  textSize(50);
  fill(220);
  textAlign(CENTER, CENTER);
  text("FROGGER", width/2, 50);
  
  // Menu Image
  frog.loadPixels();
  image(frog, (width/2) - (249/2), 150); // 249 wide
  
  // Buttons
  Button playButt = new Button("PLAY", width/2, 450);  // why here? Is setup okay?
  Button timeButt = new Button("TIMES", width/2, 505);
  playButt.display();
  timeButt.display();
  if (mousePressed && mainMenu) {
    // Play Button functionality
    if (mouseX > (playButt.x - 50) && mouseX < (playButt.x + 50) 
        && mouseY > (playButt.y - 25) && mouseY < (playButt.y + 25)) {
          //ellipse(300, 300, 50, 50); ... 
          sans.stop();
          mainMenu = false;
          gameOn = true;
          println("Play pressed");
        }
        // Times Button functionality
    if ((mouseX > (timeButt.x - 50)) && (mouseX < (timeButt.x + 50)) && 
    (mouseY > (timeButt.y - 25)) && (mouseY < (timeButt.y + 25))) {
      text("Most Recent Times:", 400, timeButt.y + text_incr);
      JSONArray scores = loadJSONArray("scores.json");
      for (int i = 0; i < scores.size(); i++) {
        if (i > (scores.size() - 5)) {
          text_incr += 50;
          JSONObject curScoreObj = scores.getJSONObject(i);
          float curScore = curScoreObj.getFloat("score");
          text("Time: " + curScore, 400, timeButt.y + text_incr);
        }
      }
    }
  }
}

void drawVictory(float score) {
  background(120);
  println(score, "SCORE!");
  fill(255, 255, 0);
  rectMode(CENTER);
  rect(400, 400, 400, 400);
  textSize(40);
  //textAlign(CENTER);
  fill(255);
  text("Win! Your time was", 400, 250);
  text(score + " seconds!", 400, 300);
  //text("Win! Your time was " + score + " seconds!", 400, 250, 200, 200);
  Button submit = new Button("DONE", width/2, 560);
  submit.display();
  JSONArray scores = loadJSONArray("scores.json");
  // Submit button functionality
  if (mousePressed) {
    if ((mouseX > (submit.x - 50)) && (mouseX < (submit.x + 50)) && 
    (mouseY > (submit.y - 25)) && (mouseY < (submit.y + 25))) {
      JSONObject newScore = new JSONObject();
      newScore.setFloat("score", score);
      scores.append(newScore);
      saveJSONArray(scores, "scores.json");
      victory = false;
      gameOn = false;
      mainMenu = true;
    }
  }
}

void drawPause() {
  fill(0, 255, 0);
  rectMode(CENTER);
  rect(400, 750, 200, 200);
  // Pause buttons
  Button resume = new Button("BACK", width/2, 700);
  resume.display();
  Button toMain = new Button("MAIN", width/2, 800);
  toMain.display();
  if (mousePressed) {
    if ((mouseX > (resume.x - 50)) && (mouseX < (resume.x + 50)) && 
        (mouseY > (resume.y - 25)) && (mouseY < (resume.y + 25))) {
          pauseMenu = false;
          println("Resume pressed");
    }
    // Main Menu button resets all coordinates
    else if ((mouseX > toMain.x - 50) && (mouseX < (toMain.x + 50)) && 
        (mouseY > (toMain.y - 25)) && (mouseY < (toMain.y + 25))) {
          //mainMenu = true;
          //pauseMenu = false;
          gameOn = false;
          pauseMenu = false;
          mainMenu = true;
          //fatal = true;
          sans.play();
          //mainMenu = true;
          println("Return to Main pressed");
          for(int i = 0; i < player.total_up; i++){
            for (Car thisCar : carList) {
              thisCar.hopDown();
            }
            asphalt.hopDown();
            pond.hopDown();
            finish.hopDown();
            //player.total_up = 0;  
          }
          player.total_up = 0;
    
          player.x = 400.0;
          player.total_right = 0.0;
    }
  }
}

void drawPlay() {
  background(120);
  
  // contact boolean
  boolean fatal = false;
  //boolean victory = false;
  boolean log_contact = false;
  boolean logDir = false;;
  float conLogSpeed = 0.0;
  float playerPush = 0.0;
  
  // Display Land
  asphalt.display();
  pond.display();
  finish.display();
  // Display player
  player.display();
  // Display objects
  for (Car thisCar : carList) {
    thisCar.display();
  }
  
  // Check for collisions
  for (Car thisCar : carList) {
    float d = sqrt( pow(thisCar.x - player.x, 2) + pow(thisCar.y - player.y, 2));
    if (d < (thisCar.diameter/2 + player.diameter/2)) {
      //fill(255, 0, 0);
      //ellipse(100, 100, 50, 50);
      fatal = true;
    }
  }
  for (Log thisLog : logList) {
    //ellipse(thisLog.x, thisLog.y + pond.y, 40, 40);
    if (player.y < ((thisLog.y + pond.y) + (thisLog.h/2)) && 
        player.y > ((thisLog.y + pond.y) - (thisLog.h/2)) &&
        player.x < (thisLog.x + (thisLog.w/2)) &&
        player.x > (thisLog.x - (thisLog.w/2))) {
          fill(0, 0, 255);
          ellipse(700, 0, 50, 50);
          log_contact = true;
          conLogSpeed = thisLog.speed;
          logDir = thisLog.left;
    }
  }
  // If finish line position indicates player has reached it...
  if (finish.y == 475.0) { // "Win"
    victory = true;
  }
  // Drowning detection
  if (!log_contact) {
    if (pond.y >= 375.0 && pond.y <= 475.0) {
      fatal = true;
    }
  }
  // Out of bounds detection
  if (player.x > 800.0 || player.x < 0.0) {
    fatal = true;
  }
  // Log contact
  if (log_contact) {
    //float playerPush
    if(logDir == false){
      playerPush = (950/(1/conLogSpeed));
    }
    else if (logDir) {
      playerPush = -(950/(1/conLogSpeed));
    }
  }

  // check for pause key
  if (keyPressed) {
    if (key == 'q' || key == 'Q') {
      pauseMenu = true;
    }
  }
  // if not paused, advance all objects. 
  if (!pauseMenu && !victory) {
    for (Car thisCar : carList) {
      thisCar.advance();
    }
    pond.advance();
    if (log_contact) {
      player.x += playerPush;
    }
  }
  // Reset coordinates upon death or win
  if (fatal || victory) {
    for(int i = 0; i < player.total_up; i++){
      for (Car thisCar : carList) {
        thisCar.hopDown();
      }
      asphalt.hopDown();
      pond.hopDown();
      finish.hopDown();
    }
    player.total_up = 0;
    player.x = 400.0;
    player.total_right = 0.0;
  }
}

// Keystroke actions
void keyPressed() {
  if (key == 'w' || key == 'W') {
    if (pauseMenu == false) {
      for (Car thisCar : carList) {
        thisCar.hopUp();
      }
      asphalt.hopUp();
      pond.hopUp();
      finish.hopUp();
      player.total_up += 1;
    }
    
  }
  if (key == 's' || key == 'S') {
    if (pauseMenu == false && player.total_up > 0) {
      for (Car thisCar : carList) {
        thisCar.hopDown();
      }
      asphalt.hopDown();
      pond.hopDown();
      finish.hopDown();
      player.total_up -= 1;
    }
  }
  if (key == 'a' || key == 'A') {
    player.hopLeft();
  }
  if (key == 'd' || key == 'D') {
    player.hopRight();
  }
}
