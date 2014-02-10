// Holla I added to this!
import spacebrew.*;
import processing.video.*;

// Spacebrew stuff
String server = "sandbox.spacebrew.cc";
String name   = "ExquisiteCorpse_NICOLE";
String desc   = "Some stuff";

Spacebrew sb;

// App Size: you should decide on a width and height
// for your group
int appWidth  = 1280;
int appHeight = 720;

// EC stuff
int corpseStarted   = 0;
boolean bDrawing    = false;
boolean bNeedToClear = false;

float fillColor;
int remote_slider_val;

//Nicole: Variables
PImage cake;
PImage eating;
int remote_sliderX_val;
int remote_sliderY_val;
int pictureLength;
float pictureLengthMap;
int eatingWidth;
int eatingHeight;
float eatingWidthMap;
float eatingHeightMap;
Movie movieMatilda;
int cakeHeight = 0;

  // image variables timmy
  PImage cloud_one;
  PImage cloud_two;
  PImage cloud_three;
  PImage timmy;

  //starting cloud co-ordinates
  int yPos_one = 0;
  float xPos_one;
  int yPos_two = 300;
  float xPos_two;
  int yPos_three =200;
  float xPos_three;
  int yPos_four =400;
  float xPos_four;

  //starting timmy co-ordinates
  int timmy_pos;
  int timmy_input_speed = -1;


void setup(){
  bDrawing = true;
  size( appWidth, appHeight );

  sb = new Spacebrew(this);
  sb.addPublish("doneExquisite", "boolean", false);
  sb.addSubscribe("startExquisite", "boolean");

  // add any of your own subscribers here!
  sb.addSubscribe( "remote_slider", "range" );
  sb.addSubscribe( "remote_sliderX", "range" );
  sb.addSubscribe( "remote_sliderY", "range" );
  sb.addSubscribe( "remote_speed_timmy", "boolean" );

  sb.connect( server, name, desc );

  //Nicole: add image, video
  cake = loadImage("cake.png");
  eating = loadImage("eating.jpg");
  movieMatilda = new Movie(this, "bruce.mp4");
  movieMatilda.loop();
    
    //timmy init position
    timmy_pos = height;
  
    //starting cloud x positions
    xPos_one = width/3.0;
    xPos_two = width/3.0 + 200;
    xPos_three = width/3.0 + 100;
    xPos_four = width/3.0 + 250;
  
    // load images
    cloud_one = loadImage("clouds_03.png");
    cloud_two = loadImage("clouds_06.png");
    cloud_three = loadImage("clouds_10.png");
    timmy = loadImage("Timmy_sized.png");
}

void draw() {
  // this will make it only render to screen when in EC draw mode

  if (!bDrawing) return;

  // blank out your background once
  if ( bNeedToClear ) {
    bNeedToClear = false;
    background(0); // feel free to change the background color!
  }

  // ---- start person 1: nicole ---- //
  if ( millis() - corpseStarted < 10000 ) {
    fillColor = map(remote_sliderX_val, -10, 10, -100, 100);
    println("mapValue: " + fillColor);
    fill(fillColor, 244, 244);
    stroke(255);
    rect(0, 0, width / 3.0, height );
    fill(255);

    //eating cake image
    eatingWidthMap = map(remote_sliderX_val, -10, 10, -width/3, width/3);
    eatingWidth = int(abs(eatingWidthMap));
    eatingHeightMap = map(remote_sliderX_val, -10, 10, -height/3, height/3);
    eatingHeight = int(abs(eatingHeightMap));
    image(eating, 0, 0, eatingWidth, eatingHeight);
    image(eating, 0, height/3, eatingWidth, eatingHeight);
    image(eating, 0, 2*height/3, eatingWidth, eatingHeight);

    //cake image
    pictureLengthMap = map(remote_sliderX_val, -10, 10, -200, 200);
    pictureLength = int(abs(pictureLengthMap));
    image(cake, width/6-pictureLength/2, height/2, pictureLength, pictureLength);

    //audio from movie
    image(movieMatilda, 0, 0);
    println("y: " + remote_sliderY_val);
    
    //falling cake
      if (remote_sliderX_val == -10 || remote_sliderX_val==10) {
    image(cake, width/27, cakeHeight, 50, 50);
    image(cake, width/9, cakeHeight, 50, 50);
    image(cake, 5*width/27, cakeHeight, 50, 50);
    image(cake, 7*width/27, cakeHeight, 50, 50);
    cakeHeight += 10;
  }
  
  if (cakeHeight == height){
   cakeHeight = 0; 
  }

  // ---- start person 2 ---- //
  } else if ( millis() - corpseStarted < 20000 ){
    stroke(255);
    fill(93,196,232);
    rect(width / 3.0,0, width / 3.0, height );
    fill(255);
    
      //load cloud images
    image(cloud_one, xPos_one,yPos_one, 121, 81);
    image(cloud_two, xPos_two ,yPos_two);
    image(cloud_three, xPos_three,yPos_three);
    image(cloud_two, xPos_four,yPos_four);
    image(timmy, width/3.0+30, timmy_pos);
  
  //timmy's movement
  if(timmy_pos > -400) {
     timmy_pos -=  timmy_input_speed;
  }
  
  //movement of clouds and speed
  if(yPos_one <= height || yPos_two <= height || yPos_three <= height || yPos_four <= height ) {
    yPos_one += 5;
    yPos_two += 5;
    yPos_three += 5;
    yPos_four += 5;
  }
  
  //randomisations of where clouds next turn up
  if (yPos_one == height) {
    yPos_one = 0;
    xPos_one = random(width/3.0, (width/3.0+width/3.0-132));
  }
  if (yPos_two == height) {
    yPos_two = 0;
    xPos_two = random(width/3.0, (width/3.0+width/3.0-132));
  }
  if (yPos_three == height) {
    yPos_three = 0;
    xPos_three = random(width/3.0, (width/3.0+width/3.0-132));
  }
  if (yPos_four == height) {
    yPos_four = 0;
    xPos_four = random(width/3.0, (width/3.0+width/3.0-132));
  }
    
  // ---- start person 3 ---- //
  } else if ( millis() - corpseStarted < 30000 ){
    noFill();
    stroke(255);
    rect(width * 2.0/ 3.0, 0, width / 3.0, height );
    fill(255);

    // ---- we're done! ---- //
  } 
  else {
    sb.send( "doneExquisite", true );
    bDrawing = false;
  }
}

void mousePressed() {
  // for debugging, comment this out!
  sb.send( "doneExquisite", true );
}

void onBooleanMessage( String name, boolean value ) {
  if ( name.equals("startExquisite") ) {
    // start the exquisite corpse process!
    bDrawing = true;
    corpseStarted = millis();
    bNeedToClear = true;
  }
  //Timmy's input
  if (name.equals("remote_speed_timmy")) {
    if(timmy_pos > -400) {
        if(value == true) {
            timmy_input_speed = 9;
        } 
        if(value == false) {
            timmy_input_speed = -1;
    }
  }
  
}
}

//NICOLE: changed to receive onRange values
void onRangeMessage( String name, int value ) {
  //println("got range message " + name + " : " + value);
  if (name.equals("remote_sliderX")) {
    //do x stuff
    remote_sliderX_val = value;
  } 
  else if (name.equals("remote_sliderY")) {
    //do y stuff
    remote_sliderY_val = value;
  }
}

void onStringMessage( String name, String value ) {
}

