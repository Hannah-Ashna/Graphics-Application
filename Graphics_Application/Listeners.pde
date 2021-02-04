// =====================
//    Event listeners
// =====================

float brightnessVal, contrastVal, blurVal;
int thicknessVal = 1;


// Convolusion Matrixes
float[][] sharpen_matrix = { { 0,  -2,  0 },
                          { -2,  8, -2 },
                          { 0,  -2,  0 } }; 
                     
float[][] blur_matrix = {  {0.1,  0.1,  0.1 },
                           {0.1,  0.1,  0.1 },
                           {0.1,  0.1,  0.1 } };                      

float[][] edge_matrix = {  { 0, -1, 0 },
                              {-1, 5, -1 },
                              { 0, -1, 0 } };  
                     

// Button Events Listener
public void handleButtonEvents(GButton button, GEvent event) {
  if(button == loadFile && event == GEvent.CLICKED){
    println("Opening File!");
    openFile();
  }
  
  if(button == saveFile && event == GEvent.CLICKED && loadedImage != null){
    println("Saving File!");
    closeFile();
  }
  
  if(button == saveImage && event == GEvent.CLICKED && loadedImage != null){
    println("Saving updates to Image");
    saveImage();
  }
  
  if(button == reset && event == GEvent.CLICKED && originalImage != null){
    println("Resetting Image");
    loadedImage = originalImage.copy();
    outputImage = originalImage.copy();
  }
  
  if(button == HSVButton && event == GEvent.CLICKED && loadedImage != null){
    println("Converting to HSV!");
    toHSV();
  }
  
  if(button == RGBButton && event == GEvent.CLICKED && loadedImage != null){
    println("Converting to RGB!");
    outputImage = originalImage.copy();
  }
  
  if(button == rectButton && event == GEvent.CLICKED){
    println("Drawing Rectangles Mode!");
    toolMode = "rect";
  }
  
  if(button == ellipseButton && event == GEvent.CLICKED){
    println("Drawing Ellipses Mode!");
    toolMode = "ellipse";
  }
  
  if(button == lineButton && event == GEvent.CLICKED){
    println("Drawing Lines Mode!");
    toolMode = "line";
  }
  
  if(button == selectButton && event == GEvent.CLICKED){
    println("Selecting Drawn Object!");
    toolMode = "select";
  }
  
  if(button == deleteButton && event == GEvent.CLICKED){
    println("Deleting Drawn Object!");
    toolMode = "delete";
  }
  
  if(button == curveButton && event == GEvent.CLICKED){
    println("Drawing a Curve!");
    toolMode = "curve";
  }
  
  if(button == resetButton && event == GEvent.CLICKED){
    println("Resetting Canvas!");
    toolMode = "reset";
  }
}

// Droplist Events Listener
public void handleDropListEvents(GDropList list, GEvent event) {
  if(list == filterOptions && event == GEvent.SELECTED && list.getSelectedText() == "None" && loadedImage != null){
    println("Revert to original");
    outputImage = loadedImage.copy();
  }
  
  if(list == filterOptions && event == GEvent.SELECTED && list.getSelectedText() == "Negative" && loadedImage != null){
    println("Negative Filter!");
    Negative();
  }
  
  if(list == filterOptions && event == GEvent.SELECTED && list.getSelectedText() == "Greyscale" && loadedImage != null){
    println("Greyscale Filter!");
    Greyscale();
  }
  
  if(list == filterOptions && event == GEvent.SELECTED && list.getSelectedText() == "Blur" && loadedImage != null){
    println("Blur Filter!");
    for (int y = 0; y < loadedImage.height; y++) {
      for (int x = 0; x < loadedImage.width; x++) {
        color convolution = Convolution(x, y, blur_matrix, blur_matrix.length, loadedImage);
        outputImage.set(x, y, convolution);
      }
    }
  }
  
  if(list == filterOptions && event == GEvent.SELECTED && list.getSelectedText() == "Sharpen" && loadedImage != null){
    println("Sharpen Filter!");
    for (int y = 0; y < loadedImage.height; y++) {
      for (int x = 0; x < loadedImage.width; x++) {
        color convolution = Convolution(x, y, edge_matrix, edge_matrix.length, loadedImage);
        outputImage.set(x, y, convolution);
      }
    }
  }
  
  if(list == filterOptions && event == GEvent.SELECTED && list.getSelectedText() == "Edge" && loadedImage != null){
    println("Edge Filter!");
    for (int y = 0; y < loadedImage.height; y++) {
      for (int x = 0; x < loadedImage.width; x++) {
        color convolution = Convolution(x, y, sharpen_matrix, sharpen_matrix.length, loadedImage);
        outputImage.set(x, y, convolution);
      }
    }
  }
}

// Slider Events Listener
public void handleSliderEvents(GValueControl slider, GEvent event) {
  if (slider == brightness && event == GEvent.RELEASED && loadedImage != null){
    println("Brightness value: " + slider.getValueI());
    brightnessVal = map(slider.getValueF(), 0, 100, 0.1, 2);
    Brightness();
  }
  
  if (slider == contrast && event == GEvent.RELEASED && loadedImage != null){
    println("Contrast value: " + slider.getValueI());
    contrastVal = map(slider.getValueF(), 0, 100, 1, 0);
    Contrast();
  }
  
  if (slider == thickness && event == GEvent.RELEASED){
    println("Stroke Weight value: " + slider.getValueI());
    thicknessVal = slider.getValueI();
  }
}

// RGB Knobs Events Listener
void handleKnobEvents(GValueControl knob, GEvent event) {
  
  // Stroke
  if((knob == RStroke || knob == GStroke || knob == BStroke)){
     if (knob == RStroke) 
       r = knob.getValueI();
     else if (knob == GStroke)
       g = knob.getValueI();
     else if (knob == BStroke)
       b = knob.getValueI();
  }  
  
  // Fill
  if((knob == RFill || knob == GFill || knob == BFill)){
     if (knob == RFill) 
       r2 = knob.getValueI();
     else if (knob == GFill)
       g2 = knob.getValueI();
     else if (knob == BFill)
       b2 = knob.getValueI();
  }
  


}
