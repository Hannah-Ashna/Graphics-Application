// =====================
//    GUI Settings
// =====================

// Variables
GCustomSlider brightness, contrast;
GDropList filterOptions;
GLabel lblBrightness, lblContrast, lblFilter;
GButton loadFile, saveFile, reset, saveImage, HSVButton, RGBButton, rectButton, ellipseButton, lineButton, selectButton;
GWindow canvas;

public void GUI(){

  // Load and Save file Buttons
  loadFile = new GButton(this, 20, 15, 100, 18);
  loadFile.setText("Load File");
  loadFile.setTextBold();
  saveFile = new GButton(this, 125, 15, 100, 18);
  saveFile.setText("Save File");
  saveFile.setTextBold();
  
  // Load and Save file Buttons
  saveImage = new GButton(this, 20, 38, 100, 18);
  saveImage.setText("Save");
  saveImage.setTextBold();
  reset = new GButton(this, 125, 38, 100, 18);
  reset.setText("Reset");
  reset.setTextBold();
  
  // Brightness Slider
  lblBrightness = new GLabel(this, 20, 20, 80, 100);
  lblBrightness.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  lblBrightness.setText("Brightness:");
  lblBrightness.setTextBold();
  brightness = new GCustomSlider(this, 20, 20, 200, 150, "grey_blue");
  brightness.setShowDecor(false, true, true, true);
  brightness.setNbrTicks(5);
  brightness.setLimits(50, 0, 100);
  
  // Contrast Slider
  lblContrast = new GLabel(this, 20, 20, 80, 220);
  lblContrast .setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  lblContrast .setText("Contrast");
  lblContrast .setTextBold();
  contrast = new GCustomSlider(this, 20, 20, 200, 270, "grey_blue");
  contrast.setShowDecor(false, true, true, true);
  contrast.setNbrTicks(5);
  contrast.setLimits(50, 0, 100);
  
  // HSV Button
  HSVButton = new GButton(this, 20, 200, 100, 18);
  HSVButton.setText("HSV");
  HSVButton.setTextBold();
  
  // HSV Button
  RGBButton = new GButton(this,125, 200, 100, 18);
  RGBButton.setText("RGB");
  RGBButton.setTextBold();
  
  // Filters Dropdown Options
  lblFilter = new GLabel(this, 20, 20, 80, 470);
  lblFilter.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  lblFilter.setText("Filters:");
  lblFilter.setTextBold();
  String[] options = {"None", "Negative", "Greyscale", "Blur", "Sharpen", "Edge"};
  filterOptions = new GDropList(this, 22, 270, 80, 100, 6);
  filterOptions.setItems(options, 0);
  
  // Drawing Buttons
  rectButton = new GButton(this, 20, 300, 85, 18);
  rectButton.setText("Rectangle");
  rectButton.setTextBold();
  ellipseButton = new GButton(this, 20, 325, 85, 18);
  ellipseButton.setText("Ellipse");
  ellipseButton.setTextBold();
  lineButton = new GButton(this, 20, 350, 85, 18);
  lineButton.setText("Line");
  lineButton.setTextBold();
  selectButton = new GButton(this, 20, 375, 85, 18);
  selectButton.setText("Select");
  selectButton.setTextBold();
  
}

// For Selection within the Canvas
class UIRect{
  
  float left,top,right,bottom;
  public UIRect(){
    
  }

  public UIRect(PVector upperleft, PVector lowerright){
    setRect(upperleft.x,upperleft.y,lowerright.x,lowerright.y);
  }
  
  void setRect(UIRect other){
    setRect(other.left, other.top, other.right, other.bottom);
  }
  
  
  void setRect(float x1, float y1, float x2, float y2){
    this.left = min(x1,x2);
    this.top = min(y1,y2);
    this.right = max(x1,x2);
    this.bottom = max(y1,y2);
  }
  
  
  boolean equals(UIRect other){
    if(left == other.left && top == other.top && 
       right == other.right && bottom == other.bottom) return true;
    return false;
  }
  
  PVector getCentre(){
    float cx = this.left + (this.right - this.left)/2.0;
    float cy = this.top + (this.bottom - this.top)/2.0;
    return new PVector(cx,cy);
  }
  
  boolean isPointInside(PVector p){
    // inclusive of the boundries
    if(   this.isBetweenInc(p.x, this.left, this.right) && this.isBetweenInc(p.y, this.top, this.bottom) ) return true;
    return false;
  }
  
  boolean isPointInside(float x, float y){
    PVector v = new PVector(x,y);
    return isPointInside(v);
  }
  
  boolean isBetweenInc(float v, float lo, float hi){
  if(v >= lo && v <= hi) return true;
  return false;
 }

}
