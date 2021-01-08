// =====================
//    Event listeners
// =====================

float brightnessVal;
float contrastVal;

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
}

// Droplist Events Listener
public void handleDropListEvents(GDropList list, GEvent event) {
    if(list == filterOptions && event == GEvent.SELECTED && list.getSelectedText() == " - " && loadedImage != null){
    println("Revert to original");
    outputImage = loadedImage.copy();
  }
  
    if(list == filterOptions && event == GEvent.SELECTED && list.getSelectedText() == "Greyscale" && loadedImage != null){
    println("Greyscale Filter!");
    Greyscale();
  }
  if(list == filterOptions && event == GEvent.SELECTED && list.getSelectedText() == "Negative" && loadedImage != null){
    println("Negative Filter!");
    Negative();
  }
  
    if(list == filterOptions && event == GEvent.SELECTED && list.getSelectedText() == "Greyscale" && loadedImage != null){
    println("Greyscale Filter!");
    Greyscale();
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
}
