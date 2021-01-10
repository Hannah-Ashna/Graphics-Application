// =====================
//    Event listeners
// =====================

float brightnessVal;
float contrastVal;
float blurVal;

// Convolusion Matrixes
float[][] edge_matrix = { { 0,  -2,  0 },
                          { -2,  8, -2 },
                          { 0,  -2,  0 } }; 
                     
float[][] blur_matrix = {  {0.1,  0.1,  0.1 },
                           {0.1,  0.1,  0.1 },
                           {0.1,  0.1,  0.1 } };                      

float[][] sharpen_matrix = {  { 0, -1, 0 },
                              {-1, 5, -1 },
                              { 0, -1, 0 } };  
                         
float[][] gaussianblur_matrix = { { 0.000,  0.000,  0.001, 0.001, 0.001, 0.000, 0.000},
                                  { 0.000,  0.002,  0.012, 0.020, 0.012, 0.002, 0.000},
                                  { 0.001,  0.012,  0.068, 0.109, 0.068, 0.012, 0.001},
                                  { 0.001,  0.020,  0.109, 0.172, 0.109, 0.020, 0.001},
                                  { 0.001,  0.012,  0.068, 0.109, 0.068, 0.012, 0.001},
                                  { 0.000,  0.002,  0.012, 0.020, 0.012, 0.002, 0.000},
                                  { 0.000,  0.000,  0.001, 0.001, 0.001, 0.000, 0.000}
                                  };

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
        color convolution = Convolution(x, y, gaussianblur_matrix, gaussianblur_matrix.length, loadedImage);
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
}
