import spacebrew.*;

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

void setup(){
  size( appWidth, appHeight );
  
  sb = new Spacebrew(this);
  sb.addPublish("doneExquisite", "boolean", false);
  sb.addSubscribe("startExquisite", "boolean");
  
  // add any of your own subscribers here!
  sb.addSubscribe( "remote_slider", "range" );
  
  sb.connect( server, name, desc );
  
  //DELETE THIS LINE
  corpseStarted = millis();
}

void draw(){
  // this will make it only render to screen when in EC draw mode
  
  //DELETE THIS LINE AND UNCOMMENT THE NEXT LINE
  //if (!bDrawing) return;
  
  // blank out your background once
  if ( bNeedToClear ){
    bNeedToClear = false;
    background(0); // feel free to change the background color!
  }
  
  // ---- start person 1: nicole ---- //
  if ( millis() - corpseStarted < 10000 ){
    fillColor = map(remote_slider_val, -10, 10, 0, 255);
    fill(fillColor, 244, 244);
    stroke(255);
    rect(0,0, width / 3.0, height );
    fill(255);
  
  // ---- start person 2 ---- //
  } else if ( millis() - corpseStarted < 20000 ){
    noFill();
    stroke(255);
    rect(width / 3.0,0, width / 3.0, height );
    fill(255);
    
  // ---- start person 3 ---- //
  } else if ( millis() - corpseStarted < 30000 ){
    noFill();
    stroke(255);
    rect(width * 2.0/ 3.0,0, width / 3.0, height );
    fill(255);
  
  // ---- we're done! ---- //
  } else {
    sb.send( "doneExquisite", true );
    bDrawing = false;
  }
}

void mousePressed(){
  // for debugging, comment this out!
  sb.send( "doneExquisite", true );
}

void onBooleanMessage( String name, boolean value ){
  if ( name.equals("startExquisite") ){
    // start the exquisite corpse process!
    bDrawing = true;
    corpseStarted = millis();
    bNeedToClear = true;
  }
}

//NICOLE: changed to receive onRange values
void onRangeMessage( String name, int value ){
  println("got range message " + name + " : " + value);
  remote_slider_val = value;
}

void onStringMessage( String name, String value ){
}


