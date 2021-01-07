public void Brightness(){
    for (int y = 0; y < loadedImage.height; y++) {
      for (int x = 0; x < loadedImage.width; x++) {
  
        color thisPix = loadedImage.get(x, y);
        float r = red(thisPix) * brightnessVal;
        float g = green(thisPix) * brightnessVal;
        float b = blue(thisPix) * brightnessVal;
        color newColour = color(r, g, b);
        outputImage.set(x, y, newColour);
      }
  }
}

public void Contrast(){
    for (int y = 0; y < loadedImage.height; y++) {
      for (int x = 0; x < loadedImage.width; x++) {
        color thisPix = loadedImage.get(x, y);
        float r = (red(thisPix) * contrastVal) + brightnessVal;
        float g = (green(thisPix) * contrastVal) + brightnessVal;
        float b = (blue(thisPix) * contrastVal) + brightnessVal;
        color newColour = color(r, g, b);
        outputImage.set(x, y, newColour);
      }
  }
}


public void Negative() {
    int MaxIntensity = 255;
    for (int y = 0; y < loadedImage.height; y++) {
      for (int x = 0; x < loadedImage.width; x++) {
  
        color thisPix = loadedImage.get(x, y);
        float r = MaxIntensity - red(thisPix);
        float g = MaxIntensity - green(thisPix);
        float b = MaxIntensity - blue(thisPix);
        color newColour = color(r, g, b);
        outputImage.set(x, y, newColour);      
      }
    } 
}
