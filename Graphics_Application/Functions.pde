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

public color Convolution(int Xcen, int Ycen, float[][] matrix, int matrixsize, PImage sourceImage)
{
  float rtotal = 0.0;
  float gtotal = 0.0;
  float btotal = 0.0;
  int offset = matrixsize / 2;
  // this is where we sample every pixel around the centre pixel
  // according to the sample-matrix size
  for (int i = 0; i < matrixsize; i++){
    for (int j= 0; j < matrixsize; j++){
      
      //
      // work out which pixel are we testing
      int xloc = Xcen+i-offset;
      int yloc = Ycen+j-offset;
      
      // Make sure we haven't walked off our image
      if( xloc < 0 || xloc >= sourceImage.width) continue;
      if( yloc < 0 || yloc >= sourceImage.height) continue;
      
      
      // Calculate the convolution
      color col = sourceImage.get(xloc,yloc);
      rtotal += (red(col) * matrix[i][j]);
      gtotal += (green(col) * matrix[i][j]);
      btotal += (blue(col) * matrix[i][j]);
    }
  }
  // Make sure RGB is within range
  rtotal = constrain(rtotal, 0, 255);
  gtotal = constrain(gtotal, 0, 255);
  btotal = constrain(btotal, 0, 255);
  // Return the resulting color
  return color(rtotal, gtotal, btotal);
}
