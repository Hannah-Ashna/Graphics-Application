import g4p_controls.*;

void setup(){
  size(800, 700);
  
  // Custom Cursor
  cursor(CROSS);
  
  // Setup the GUI
  GUI();
}

void draw() {
  background(134, 136, 138);
}


// =====================
//    Event listeners
// =====================

// Dropdown Events Listener
public void handleDropListEvents(GDropList list, GEvent event) {
  if(list == fileOptions && event == GEvent.SELECTED && list.getSelectedText() == "Load File"){
    println("Test!");
  }
  
  if(list == fileOptions && event == GEvent.SELECTED && list.getSelectedText() == "Save File"){
    println("Test2!");
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
