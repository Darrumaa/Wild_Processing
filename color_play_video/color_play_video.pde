import processing.video.*;
Capture myCap;

void setup() {
  size(600, 480);
  String[] cameras = Capture.list();
    if (cameras.length > 0) {
        for (String camera : cameras) {
            println(camera); 
        }
        myCap = new Capture(this, 640, 480, cameras[2]);
        myCap.start();
    } else {
        println("No cameras found.");
    }
  myCap.start();  
}

void draw() {
  if (myCap.available()) {
    myCap.read(); 
    myCap.loadPixels();
    for (int x = 0; x < myCap.width; x++){
      for (int y = 0; y < myCap.height; y++){
        int loc = x + y * myCap.width;
        float r = red(myCap.pixels[loc]);
        float g = green(myCap.pixels[loc]);
        float b = blue(myCap.pixels[loc]);
        float m = max(r, g, b);
        color c = color(0);
        
        // randomizes on the basis of max but the corresponding max color gets the high range in random
        
        //if (m == r){
        //  c = color(random(120,255), random(0, 40), random(0, 40));
        //}
        //else if (m == g){
        //  c = color(random(0, 40), random(120,255), random(0, 40));
        //}
        //else if (m == b){
        //  c = color(random(0, 40), random(0, 40), random(120,255));
        //}
        
        
        // Sharp black and white:
        
        //if (m == r){
        //  c = color(random(r));
        //}
        //else if (m == g){
        //  c = color(random(g));
        //}
        //else if (m == b){
        //  c = color(random(b));
        //}
        
        
        //IDK tf is this but looks kinda cartoony:
        
        if (m == r){
          c = color(255, random(0, g), random(0, b));
        }
        else if (m == g){
          c = color(random(0, r), 255, random(0, b));
        }
        else if (m == b){
          c = color(random(0, r), random(0, g), 255);
        }
        myCap.pixels[loc] = c;
      }
    }
  }
  
  image(myCap, 0, 0);
}
