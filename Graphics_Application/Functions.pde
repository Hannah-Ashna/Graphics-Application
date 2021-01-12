// =====================
//       Functions
// =====================

// Brighten - Slider
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

// Contrast - Slider (LUT)
public void Contrast(){
  int[] lut = makeSigmoidLUT();
  outputImage = applyPointProcessing(lut, lut, lut, loadedImage);
}

// Contrast - Sigmoid Curve
public float sigmoidCurve(float v){  
  float f =  (1.0 / (1 + exp(-12 * (v  - contrastVal))));
  return f;
}

// Contrast - Create SigmoidLUT
public int[] makeSigmoidLUT(){
  int[] lut = new int[256];
  for(int n = 0; n < 256; n++) {
    
    float p = n/255.0f;  // p ranges between 0...1
    float val = sigmoidCurve(p);
    lut[n] = (int)(val*255);
  }
  return lut;
}

// Apply Point Processing
public PImage applyPointProcessing(int[] redLUT, int[] greenLUT, int[] blueLUT, PImage inputImage){
  
  PImage outputImage = createImage(inputImage.width,inputImage.height,RGB);
 
  for (int y = 0; y < inputImage.height; y++) {
    for (int x = 0; x < inputImage.width; x++) {
    
    color c = inputImage.get(x,y);
    
    int r = (int)red(c);
    int g = (int)green(c);
    int b = (int)blue(c);
    
    int lutR = redLUT[r];
    int lutG = redLUT[g];
    int lutB = redLUT[b];
    
    
    outputImage.set(x,y, color(lutR,lutG,lutB));
    
    }
  }
  
  return outputImage;
}

// ---------------- RGB - HSV Slider --------------------------
public void HSVConversion() {
   float r = 128/255.0;
   float g = 128/255.0;
   float b = 0/255.0;
        
   // (H)ue, (S)aturation and (V)alue
   float cMax = max(r, g, b);
   float cMin = min(r, g, b);
   float diff = cMax - cMin;
   float h = -1, s = -1;
        
    if (cMax == cMin){
     h = 0;
    }
        
    else if (cMax == r){
      h = (60 * ((g -b) / diff) + 360) % 360;
    }
        
    else if (cMax == g){
      h = (60 * ((b - r) / diff) + 360) % 360;
    }
        
    else if (cMax == b){
      h = (60 * ((r - g) / diff) + 360) % 360;
    }
        
    if (cMax == 0){
      s = 0;
    }
        
    else {
      s = (diff / cMax) * 100;
    }
        
    float v = cMax * 100;
    println(h, s, v);

}

// ---------------- Other Filters (Dropdown Menu) --------------------------

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
