PImage bg;
PImage banana;
ArrayList<String> backgrounds;
boolean[] moveRobot;
Robot mainRobot = new Robot();
Monkey mainMonkey = new Monkey(500, 50);
Monkey mainMonkey2 = new Monkey(100, 200);
Monkey mainMonkey3 = new Monkey(200, 25);
Monkey mainMonkey4 = new Monkey(300, 25);
Monkey mainMonkey5 = new Monkey(400, 227);
Monkey mainMonkey6 = new Monkey(600, 337);
Monkey mainMonkey7 = new Monkey(700, 448);
Monkey mainMonkey8 = new Monkey(800, 500);
Bucket mainBucket = new Bucket();
float xban = 100;
float yban = -50;
int x = 10; 
int y = 500;
int counter = 0;
int score=0;                   
int lives=3;                   
boolean lost=false;
float speed = 2;

void setup() {
  moveRobot = new boolean[2];
  moveRobot[0] = false;
  moveRobot[1] = false;
  //Backgrounds arraylist
  backgrounds = new ArrayList<String>();
  backgrounds.add("junglewalk.jpg");
  backgrounds.add("banana.png");
  //Border
  size(1000, 711);
  //Loading the Image
  bg = loadImage(backgrounds.get(0));
  banana =loadImage(backgrounds.get(1));
  textSize(13); 
}

//Drawing Image
void draw() {
  background(bg);
  image(banana, xban, yban);
  smooth();
  mainRobot.drawRobot();
  
  mainMonkey.drawMonkey();
  mainMonkey2.drawMonkey();
  mainMonkey3.drawMonkey();
  mainMonkey4.drawMonkey();
  mainMonkey5.drawMonkey();
  mainMonkey6.drawMonkey();
  mainMonkey7.drawMonkey();
  mainMonkey8.drawMonkey();
  keyPressed();
  
    if ((keyPressed == true) && ((key == 'a') || (key == 'A'))) {
    moveRobot[0] = true;
    }
    if ((keyPressed == true) && ((key == 'd') || (key == 'D'))) {
    moveRobot[1] = true;
    }
  
        if(x > 0 & x < width & moveRobot[0]){
        x = x - 5;
        moveRobot[0] = false;
      }
      
        if(x >= 0 & x < width - 80 & moveRobot[1]){
        x = x + 5;
        moveRobot[1] = false;
      }
      if(mouseX > (x-150) & mouseX < (x+150) & mouseY > 500){
        mainBucket.drawBucket();
      }
      
      yban += speed;
      if (yban > 600){
        yban = - 50;
        lives--;
        xban = random(900);
        }
  
      
    text("score = "+score,10,10);                  
    text("lives = "+lives,width-80,10);            
    if (lives<=0)                                 
    {
      textSize(20);
      text("Click to Restart", 125,175);
      noLoop();                                    
      lost=true;
      textSize(13);
    }
    
    if((xban <= (mouseX+50)) && (xban >= (mouseX)) && (yban <= mouseY) && (yban >= 500))
    {
       score += 1;
       yban = - 50;
       xban = random(900);
       if (speed <= 6){
         speed += 0.1;
       }
    }
}

void mousePressed()                              
{
  if (lost==true)                                 
  {                                    
    lives=3;
    score=0;
    lost=false;
    speed = 2;
    loop();                                     
  }
}


class Robot{
  

  void drawRobot()
{
  pushMatrix();
  translate(x, y);
  fill(255, 255, 0);
  rect(20, 0, 38, 30); // head
  rect(14, 32, 50, 50); // body
  drawLeftArm();
  drawRightArm();
  rect(22, 84, 16, 50); // left leg
  rect(40, 84, 16, 50); // right leg
  
  fill(222, 222, 249);
  ellipse(30, 12, 12, 12); // left eye
  ellipse(47, 12, 12, 12);  // right eye
  popMatrix();
}

void drawLeftArm()
{
  float angle = atan2(mouseY - 500 , mouseX - x);
  pushMatrix();
  translate(12, 32);
  rotate(angle - HALF_PI);
  rect(-12, 0, 12, 37);
  popMatrix();
}

void drawRightArm()
{
  float angle = atan2(mouseY - 500 , mouseX - x);
  pushMatrix();
  translate(66, 32);
  rotate(angle - HALF_PI);
  rect(0, 0, 12, 37);
  popMatrix();
}

int getXAxis(){
  return x;
}
}

class Monkey extends Robot{

  float xMonkey, yMonkey;
  
Monkey(int xMon, int yMon){
  xMonkey = xMon;
  yMonkey = yMon;
}
  
void drawMonkey()
{
  pushMatrix();
  translate(xMonkey,yMonkey);
  noStroke();
  scale(0.5,0.5);
  fill(139,69,19);
  ellipse(50, 30, 50, 50); // head
  
  fill(222, 222, 249);
  ellipse(40, 30, 12, 12); // left eye
  ellipse(60, 30, 12, 12); // right eye
  
  fill(0,0,0);
  ellipse(40, 33, 4, 4); // left eye
  ellipse(60, 33, 4, 4); // right eye
  
  fill(139,69,19);
  rect(27,53,45,80);
  
  rect(33,125,10,50);
  rect(57,125,10,50);
  drawLeftArm();
  drawRightArm();
  moveMonkey();
  popMatrix();
}

void drawLeftArm()
{
  pushMatrix();
  translate(34, 67);
  rotate(QUARTER_PI);
  rect(-12, 0, 12, 37);
  popMatrix();
}

void drawRightArm()
{
  pushMatrix();
  translate(76, 67);
  rotate(QUARTER_PI);
  rect(0, 0, 12, 37);
  popMatrix();
}

void moveMonkey(){
  float randomMovement = random(100);
  do{
  if(randomMovement <= 50){
    xMonkey = xMonkey - 0.01;
  }
  else{
    xMonkey = xMonkey + 0.01;
  }
  counter++;
  }while(counter != 45);
  counter = 0;
}

}

class Bucket extends Robot{
  
  void drawBucket(){
    float angle = atan2(mouseY - 500 , mouseX - x);
    pushMatrix();
    translate(mouseX,mouseY);
    stroke(153);
    strokeWeight(4);
    fill(192,192,192);
    rect(25,30,50,50);
    ellipse(50, 30, 50, 25); // head
    popMatrix();
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      moveRobot[0] = true;
    }
    if (keyCode == RIGHT) {
      moveRobot[1] = true;
    }
  }
  }