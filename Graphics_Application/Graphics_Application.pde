import g4p_controls.*;
   
float brightnessVal;
void setup(){
  size(900, 800);
  
  // Custom Cursor
  cursor(CROSS);
  
  // Setup the GUI
  GUI();
}

void draw() {
  background(134, 136, 138);
  
  if (outputImage != null) {
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
  if (slider == brightness && event == GEvent.RELEASED && loadedImage != null){
    println("Brightness value: " + slider.getValueI());
    brightnessVal = map(slider.getValueF(), 0, 100, 2, 0.1);
    Brightness();
  }
  
  if (slider == contrast && event == GEvent.RELEASED && loadedImage != null){
  println("Contrast value: " + slider.getValueI());
  }
}
