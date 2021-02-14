// =====================
//       Functions
// =====================

// Brighten - Slider
public PImage Brightness(PImage img){
    for (int y = 0; y < img.height; y++) {
      for (int x = 0; x < img.width; x++) {
  
        color thisPix = img.get(x, y);
        float r = red(thisPix) * brightnessVal;
        float g = green(thisPix) * brightnessVal;
        float b = blue(thisPix) * brightnessVal;
        color newColour = color(r, g, b);
        img.set(x, y, newColour);
      }
    }
    
    return img;
}

// Contrast - Slider (LUT)
public PImage Contrast(PImage img){
  int[] lut = makeSigmoidLUT();
  img = applyPointProcessing(lut, lut, lut, img);
  
  return img;
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

public PImage toHSV(PImage img) {
    for (int y = 0; y < img.height; y++) {
      for (int x = 0; x < img.width; x++){
        
        color thisPix = img.get(x,y);
        int r = (int) (red(thisPix));
        int g = (int) (green(thisPix));
        int b = (int) (blue(thisPix));
        
        float[] hsv = RGBtoHSV(r,g,b);
        float hue = hsv[0];
        float sat = hsv[1];
        float val = hsv[2];
        
        // do some operation on the hsv values here
        // NOTE: hue is in the range 0...360
        // sat is in the range 0...1
        // val is in the range 0...1
      
        hue += 30;
        if( hue < 0 ) hue += 360;
        if( hue > 360 ) hue -= 360;
        
        color newRGB =   HSVtoRGB(hue,  sat,  val);
        img.set(x, y, newRGB);
      }
    
    }
    
    return img;
}
// RGB to HSV Conversion
public float[] RGBtoHSV(float r, float g, float b){
  
  
  float minRGB = min( r, g, b );
  float maxRGB = max( r, g, b );
    
    
  float value = maxRGB/255.0; 
  float delta = maxRGB - minRGB;
  float hue = 0;
  float saturation;
  
  float[] returnVals = {0f,0f,0f};
  

   if( maxRGB != 0 ) {
    // saturation is the difference between the smallest R,G or B value, and the biggest
      saturation = delta / maxRGB; }
   else { // it’s black, so we don’t know the hue
       return returnVals;
       }
       
  if(delta == 0){ 
         hue = 0;
        }
   else {
    // now work out the hue by finding out where it lies on the spectrum
      if( b == maxRGB ) hue = 4 + ( r - g ) / delta;   // between magenta, blue, cyan
      if( g == maxRGB ) hue = 2 + ( b - r ) / delta;   // between cyan, green, yellow
      if( r == maxRGB ) hue = ( g - b ) / delta;       // between yellow, Red, magenta
    }
  // the above produce a hue in the range -6...6, 
  // where 0 is magenta, 1 is red, 2 is yellow, 3 is green, 4 is cyan, 5 is blue and 6 is back to magenta 
  // Multiply the above by 60 to give degrees
   hue = hue * 60;
   if( hue < 0 ) hue += 360;
   
   returnVals[0] = hue;
   returnVals[1] = saturation;
   returnVals[2] = value;
   
   return returnVals;
}

// HSV to RGB Conversion
// expects values in range hue = [0,360], saturation = [0,1], value = [0,1]
public color HSVtoRGB(float hue, float sat, float val)
{
  
    hue = hue/360.0;
    int h = (int)(hue * 6);
    float f = hue * 6 - h;
    float p = val * (1 - sat);
    float q = val * (1 - f * sat);
    float t = val * (1 - (1 - f) * sat);

    float r,g,b;


    switch (h) {
      case 0: r = val; g = t; b = p; break;
      case 1: r = q; g = val; b = p; break;
      case 2: r = p; g = val; b = t; break;
      case 3: r = p; g = q; b = val; break;
      case 4: r = t; g = p; b = val; break;
      case 5: r = val; g = p; b = q; break;
      default: r = val; g = t; b = p;
    }
    
    return color(r*255,g*255,b*255);
}

// ---------------- Other Filters (Dropdown Menu) --------------------------

public PImage Negative(PImage img) {
    int MaxIntensity = 255;
    for (int y = 0; y < img.height; y++) {
      for (int x = 0; x < img.width; x++) {
  
        color thisPix = img.get(x, y);
        float r = MaxIntensity - red(thisPix);
        float g = MaxIntensity - green(thisPix);
        float b = MaxIntensity - blue(thisPix);
        color newColour = color(r, g, b);
        img.set(x, y, newColour);
      }
    } 
    
    return img;
}

public PImage Greyscale(PImage img) {
    for (int y = 0; y < img.height; y++) {
      for (int x = 0; x < img.width; x++) {
  
        color thisPix = img.get(x, y);
        float r = red(thisPix);
        color newColour = color(r, r, r);
        img.set(x, y, newColour);      
      }
    } 
    
    return img;
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

// ---------------- Curve Function --------------------------
void romcatmullCurve(ArrayList<PVector> points){
   noFill();
   beginShape();
   PVector startPoint = points.get(0);
   curveVertex(startPoint.x, startPoint.y);
   
   for (PVector p: points) {
      curveVertex(p.x, p.y);
    }
    
   PVector endPoint = points.get(points.size()-1);
   curveVertex(endPoint.x, endPoint.y);    

}

void polygon (ArrayList<PVector> points){
  beginShape();
  for (PVector p: points) {
    float sx = p.x;
    float sy = p.y;
    vertex(sx, sy);
  }
}

void polyLine (ArrayList<PVector> points){
  noFill();
  beginShape();
  for (PVector p: points) {
    float sx = p.x;
    float sy = p.y;
    vertex(sx, sy);
  }
}
