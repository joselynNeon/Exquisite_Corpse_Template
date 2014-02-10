import spacebrew.*;

// Spacebrew stuff
String server = "sandbox.spacebrew.cc";
String name   = "ExquisiteJoselyn";
String desc   = "Some stuff!";

Spacebrew sb;
// App Size: you should decide on a width and height
// for your group
int appWidth  = 1280;
int appHeight = 720;

// EC stuff
//turn these back to false - and change your time jos!!
int corpseStarted   = 0;
boolean bDrawing    = false;
boolean bNeedToClear = false;

//Joselyn's stuff
int numFrames = 13;  // The number of frames in the animation
int frame = 0;
PImage[] images = new PImage[numFrames];
PImage star, star4, fonzie, mouth, donuts; 
float x,x2; 
float y,y2; 
int i = 1;
int rotate;
float offset = 0;
float easing = 0.05;

//end Joselyn's stuff

void setup(){
  size( appWidth, appHeight );
  
  sb = new Spacebrew(this);
  sb.addPublish("doneExquisite", "boolean", false);
  sb.addSubscribe("startExquisite", "boolean");
  //joselyns stuff
  sb.addSubscribe("pressButtonYes", "boolean");
  //

  // add any of your own subscribers here!
  
  sb.connect( server, name, desc );
  
  //Joselyn's stuff
  frameRate(10);
  x = random(850, 900);
  y = random(-30, 300); 
 star4 = loadImage("star3.jpg"); 
  star = loadImage("star.jpg"); 
 fonzie = loadImage("fonzie.jpg"); 
 mouth = loadImage("mouth.jpg"); 
 int g = 1; 
  images[0]  = loadImage("donut1.png");
  images[1]  = loadImage("donut2.png"); 
  images[2]  = loadImage("donut6.png");
  images[3]  = loadImage("donut3.png"); 
  images[4]  = loadImage("donut5.png");
  images[5]  = loadImage("donut1.png"); 
  images[6]  = loadImage("donut4.png");
  images[7]  = loadImage("donut3.png"); 
  images[8]  = loadImage("donut2.png");
  images[9]  = loadImage("donut5.png"); 
  images[10] = loadImage("donut1.png");
  images[11] = loadImage("donut5.png"); 
  images[12] = loadImage("donut6.png");
  donuts = loadImage("donuts.gif"); 
} 

void draw(){
  // this will make it only render to screen when in EC draw mode
  if (!bDrawing) return;
  // blank out your background once
  if ( bNeedToClear ){
    bNeedToClear = false;
  }
  corpseStarted = millis();
  // ---- start person 1 ---- //
  if ( millis() - corpseStarted < 10000 ){
    noFill();
    stroke(255);
    rect(0,0, width / 3.0, height );
    fill(255);//
  
  // ---- start person 2 ---- //
  } else if ( millis() - corpseStarted < 20000 ){
    noFill();
    stroke(255);
    rect(width / 3.0,0, width / 3.0, height );
    fill(255);
    
  // ---- start p erson 3 ---- //
  } else*/ if (millis() - corpseStarted < 30000 ){
 image(star, width*2.0/3.0, 0, width/3.0, height);
  println(x); 
   image(images[int(random(i))], random(850, 1000), random(-20, 300)); 
   if (rotate==1){
     i+=1; 
     if (i >= 12){
    i = int(random(1, 12)); 
   } 
     //image(star4, width*2.0/3.0, 0, width/3.0, height);
    float dx = (mouseX-star4.width/2) - offset;   
    tint(255, 127);
    image(star4,width*2.0/3.0, 0, width/3.0, height); 
   }
   }
 //end Joselyn's stuff 

  // ---- we're done! ---- //
  else {
    sb.send("doneExquisite", true);
    bDrawing = false;
  }
  }

void onBooleanMessage( String name, boolean value ){
  if ( name.equals("startExquisite") ){
     start the exquisite corpse process!
    bDrawing = true;
    corpseStarted = millis();
    bNeedToClear = true;
  if (name.equals("pressButtonYes") && value == true){
    rotate = 1; 
    println(value); 
}
  }
void onRangeMessage( String name, int value ){
}

void onStringMessage( String name, String value ){
}


