import processing.video.*;
import java.util.ArrayList;

ArrayList<PVector> locs;
Capture myCap;

void setup() {
  size(600, 480);
  myCap = new Capture(this, 600, 480);
  myCap.start();  
  locs = new ArrayList<PVector>();
}

void draw() {
  if (myCap.available()) {
    myCap.read();
    myCap.loadPixels();
    
    locs.clear();  // Clear previous locations

    // Draw the current video frame
    image(myCap, 0, 0);  // Draw the video frame at the top-left corner

    for (int x = 0; x < myCap.width; x++) {
      for (int y = 0; y < myCap.height; y++) {
        int loc = x + y * myCap.width;
        float r = red(myCap.pixels[loc]);
        float g = green(myCap.pixels[loc]);
        float b = blue(myCap.pixels[loc]);

        // Check if the red is prominent enough
        if (r > 120 && g < 100 && b < 100) {
          locs.add(new PVector(x, y));
        }
      }
    }

    // Draw ellipses over the video
    for (PVector v : locs) {
      stroke(255);  // Change stroke color to white for better visibility
      fill(255, 0, 0, 150);  // Optional: Fill color with some transparency
      ellipse(v.x, v.y, 4, 4);  // Slightly larger ellipse
    }
  }
}
