import processing.video.*;
Capture myCap;

void setup() {
  size(600, 480);
  myCap = new Capture(this, 600, 480);
  myCap.start();  
}

void draw() {
  if (myCap.available()) {
    myCap.read(); 
   
    myCap.loadPixels();
    
    for (int x = 0; x < myCap.width; x++) {  
      for (int y = 0; y < myCap.height; y++) { 
        
        int loc = x + y * myCap.width;
        float b = brightness(myCap.pixels[loc]);
        
        if (b >= mouseX){
          myCap.pixels[loc] = color(random(120,255), random(0, 60), random(60, 120));
        }
        else{
          myCap.pixels[loc] = color(0);
        }
        
      }
    }
    myCap.updatePixels();
  }
  image(myCap, 0, 0);
  
  // Save each frame as an image
  saveFrame("output/frame-####.png");  // Saves frames as "frame-0001.png", "frame-0002.png", etc.
}
