SimpleUI UI;

PImage loadedImage;

void setup(){
  // Window Size: 900 x 700
  size(900,700);
  
  // Instantiate the UI
  UI = new SimpleUI();

  // Create Save/Load file Menu
  String[] fileMenuItems = {"Load", "Save"};
  UI.addMenu("File", 5, 5, fileMenuItems);
  
}


void draw(){
  background(200);

  if( loadedImage != null ){  
    image(loadedImage,250,80);
  }
  
  // Update UI
  UI.update();
  
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
  
  
  
}
