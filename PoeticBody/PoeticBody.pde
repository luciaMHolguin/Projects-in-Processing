import processing.video.*;
// Variable for capture device
Capture webcam;
// Previous Frame
PImage prevFrame;
PImage bg;


// How different must a pixel be to be a "motion" pixel
float threshold = 50;
int count;


int maxImages = 14; // Total # of images
int imageIndex = 0; // Initial image to be displayed is the first

// Declaring an array of images.
PImage[] images = new PImage[maxImages]; 
PImage img = createImage(649, 480, RGB);

int haiku_start, haiku_end, haiku_index;

int[] haiku_Start = {0, 4, 7, 11};
int[] haiku_End = {4, 7, 11, 14};

Haiku[] haiku1 = new Haiku[images.length];//This is an array of the object called haiku, in which images of the array are stored and displayed


void setup() {

  size(640, 480);


  haiku_index = 0;
  haiku_start = haiku_Start[haiku_index];
  haiku_end = haiku_End[haiku_index];


  webcam = new Capture(this, width, height, 30);
  // Create an empty image the same size as the video
  prevFrame = createImage(webcam.width, webcam.height, RGB);
  webcam.start();
  frameRate(30);


  updates(haiku_start, haiku_end);
  
} 


void draw() {

  if (webcam.available()) {
    // Save previous frame for motion detection!!
    prevFrame.copy(webcam, 0, 0, webcam.width, webcam.height, 0, 0, webcam.width, webcam.height); // Before we read the new frame, we always save the previous frame for comparison!
    prevFrame.updatePixels();
    webcam.read();
  }

  loadPixels();
  webcam.loadPixels();
  prevFrame.loadPixels();

  count = 0;

  // Begin loop to walk through every pixel
  for (int x = 0; x < webcam.width; x ++ ) {
    for (int y = 0; y < webcam.height; y ++ ) {

      int loc = x + y*webcam.width;            // Step 1, what is the 1D pixel location
      color current = webcam.pixels[loc];      // Step 2, what is the current color
      color previous = prevFrame.pixels[loc]; // Step 3, what is the previous color

      // Step 4, compare colors (previous vs. current)
      float r1 = red(current); 
      float g1 = green(current); 
      float b1 = blue(current);
      float r2 = red(previous); 
      float g2 = green(previous); 
      float b2 = blue(previous);
      float diff = dist(r1, g1, b1, r2, g2, b2);

      // Step 5, How different are the colors?
      // If the color at that pixel has changed, then there is motion at that pixel.
      if (diff > threshold) { 
        // If motion, display black
        pixels[loc] = img.pixels[loc];
        count++;
      } else {
        // If not, display white
        pixels[loc] = bg.pixels[loc];
      }
    }
  }
  updatePixels();



  if (frameCount > 10)
  {
    if (count > 80000)
    {

      haiku_index = int(random(0, 4));


      haiku_start = haiku_Start[haiku_index];
      haiku_end = haiku_End[haiku_index];
      updates(haiku_start, haiku_end);
    }
  }
}
