// =====================
//       Functions
// =====================

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

public void Greyscale() {
    for (int y = 0; y < loadedImage.height; y++) {
      for (int x = 0; x < loadedImage.width; x++) {
  
        color thisPix = loadedImage.get(x, y);
        float r = red(thisPix);
        color newColour = color(r, r, r);
        outputImage.set(x, y, newColour);      
      }
    } 
}

public color Convolution(int Xcen, int Ycen, float[][] matrix, int matrixsize, PImage originalImage)
{
  float rTotal = 0.0;
  float gTotal = 0.0;
  float bTotal = 0.0;
  int offset = matrixsize / 2;

  for (int i = 0; i < matrixsize; i++){
    for (int j= 0; j < matrixsize; j++){
      
      int xloc = Xcen+i-offset;
      int yloc = Ycen+j-offset;
      
      if( xloc < 0 || xloc >= originalImage.width) continue;
      if( yloc < 0 || yloc >= originalImage.height) continue;
        
      // Convolution Formula
      color col = originalImage.get(xloc,yloc);
      rTotal += (red(col) * matrix[i][j]);
      gTotal += (green(col) * matrix[i][j]);
      bTotal += (blue(col) * matrix[i][j]);
    }
  }
  
  rTotal = constrain(rTotal, 0, 255);
  gTotal = constrain(gTotal, 0, 255);
  bTotal = constrain(bTotal, 0, 255);
  
  return color(rTotal, gTotal, bTotal);
}
