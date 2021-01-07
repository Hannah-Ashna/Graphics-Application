SimpleUI UI;

PImage loadedImage;
PImage outputImage;

void setup(){
  // Window Size: 900 x 700
  size(900,700);
  
  // Instantiate the UI
  UI = new SimpleUI();

  // Create Save/Load file Menu
  String[] fileMenuItems = {"Load", "Save"};
  UI.addMenu("File", 5, 5, fileMenuItems);
  
  UI.addRadioButton("Slider", 5, 70, "RGB Selection").setSelected(true);
  // RGB Sliders
  UI.addSlider("Red:", 5, 110);
  UI.addSlider("Green:", 5, 150);
  UI.addSlider("Blue:", 5, 190);
  
  UI.addRadioButton("Text", 120, 70, "RGB Selection");
  // add text input boxes
  UI.addTextInputBox("Red", 120, 110, "0");
  UI.addTextInputBox("Green", 120, 150, "0");
  UI.addTextInputBox("Blue", 120, 190, "0");
  
  // Brightness Slider
  UI.addSlider("Brightness:", 5, 250);
  
}


void draw(){
  background(200);

  if(loadedImage != null){  
    image(loadedImage, 280, 70);
    outputImage = loadedImage.copy();
  }
  
  
  // Update UI
  UI.update();
  
  // Declare floats for R G B Values
  float R = 0, G = 0, B = 0;
  
  // RGB Slider
  if (UI.getToggleButtonState("Slider") ) {
    R = UI.getSliderValue("Red:")*255;
    G = UI.getSliderValue("Green:")*255;
    B = UI.getSliderValue("Blue:")*255;
  }
  
  // RGB Manual Input via Text
  if (UI.getToggleButtonState("Text") ) {
    R = int(UI.getText("Red"));
    G = int(UI.getText("Green"));
    B = int(UI.getText("Blue"));
  }
  
}


void Brightness() {
  for (int y = 0; y < loadedImage.height; y++){
    for (int x = 0; x <loadedImage.width; x++) {
      
      float Brightness = UI.getSliderValue("Brightness:");
      color thisPixel = loadedImage.get(x, y);
      float R = red(thisPixel) * Brightness;
      float G = green(thisPixel) * Brightness;
      float B = blue(thisPixel) * Brightness;
        
      color newColour = color(R, G, B);
      outputImage.set(x, y, newColour);
      }
    }
}

// you MUST have this function declared.. 
// it receives all the user-interface events
void handleUIEvent(UIEventData uied){
  // here we just get the event to print its self
  // with "verbosity" set to 1, (1 = low, 3 = high, 0 = do not print anything)
  uied.print(2);
  
  // Load File
  if(uied.eventIsFromWidget("Load")){
    UI.openFileLoadDialog("load an image");
  }
  
  if(uied.eventIsFromWidget("fileLoadDialog")){
    loadedImage = loadImage(uied.fileSelection);
  }
  
  
  // Save File
  if(uied.eventIsFromWidget("Save")){
    UI.openFileSaveDialog("save an image");
  }
  
  //this catches the file save information when the file save dialogue's "save" button is hit
  if(uied.eventIsFromWidget("fileSaveDialog")){
    loadedImage.save(uied.fileSelection);
  }
  
  if(uied.eventIsFromWidget("Brightness:")){
    Brightness();
    image(outputImage, 280, 70);
  }
  
  
}
