import g4p_controls.*;
   
PImage outputImage;

void setup(){
  size(900, 800);
  
  // Custom Cursor
  cursor(CROSS);
  
  // Setup the GUI
  GUI();
}

void draw() {
  background(134, 136, 138);
  
  if (loadedImage != null) {
    outputImage = loadedImage.copy();
    image(outputImage, 280, 80);
  }
  
}


// =====================
//    Event listeners
// =====================

// Button Events Listener
public void handleButtonEvents(GButton button, GEvent event) {
  if(button == loadFile && event == GEvent.CLICKED){
    println("Opening File!");
    openFile();
  }
  
  if(button == saveFile && event == GEvent.CLICKED){
    println("Saving File! - Pending");
  }
}

// Slider Events Listener
public void handleSliderEvents(GValueControl slider, GEvent event) {
  if (slider == brightness && event == GEvent.RELEASED){
    println("Brightness value: " + slider.getValueI());
  }
  
  if (slider == contrast && event == GEvent.RELEASED){
  println("Contrast value: " + slider.getValueI());
  }
}
