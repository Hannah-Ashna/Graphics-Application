import g4p_controls.*;
   
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
