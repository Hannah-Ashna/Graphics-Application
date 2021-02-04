// =====================
//    GUI Settings
// =====================

// Variables
GCustomSlider brightness, contrast, thickness;
GDropList filterOptions;
GLabel lblBrightness, lblContrast, lblFilter, lblShape, lblStroke, lblThickness, lblFill;
GButton loadFile, saveFile, reset, saveImage, HSVButton, RGBButton;
GButton rectButton, ellipseButton, lineButton, curveButton, polyButton; 
GButton selectButton, deleteButton, resetButton, resizeButton, moveButton;
GKnob RStroke, GStroke, BStroke, RFill, GFill, BFill;

int kx, ky, r, g, b;
int kx2, ky2, r2, g2, b2;

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
  lblShape = new GLabel(this, 20, 20, 200, 570);
  lblShape.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  lblShape.setText("Shapes & Curves:");
  lblShape.setTextBold();
  rectButton = new GButton(this, 20, 320, 85, 18);
  rectButton.setText("Rectangle");
  rectButton.setTextBold();
  ellipseButton = new GButton(this, 20, 345, 85, 18);
  ellipseButton.setText("Ellipse");
  ellipseButton.setTextBold();
  lineButton = new GButton(this, 20, 370, 85, 18);
  lineButton.setText("Line");
  lineButton.setTextBold(); 
  curveButton = new GButton(this, 20, 395, 85, 18);
  curveButton.setText("Curve");
  curveButton.setTextBold();
  polyButton = new GButton(this, 20, 420, 85, 18);
  polyButton.setText("Polyline");
  polyButton.setTextBold();
  
  selectButton = new GButton(this, 125, 320, 85, 18);
  selectButton.setText("Select");
  selectButton.setTextBold();
  deleteButton = new GButton(this, 125, 345, 85, 18);
  deleteButton.setText("Delete");
  deleteButton.setTextBold();
  moveButton = new GButton(this, 125, 370, 85, 18);
  moveButton.setText("Move");
  moveButton.setTextBold();
  resizeButton = new GButton(this, 125, 395, 85, 18);
  resizeButton.setText("Resize");
  resizeButton.setTextBold();  
  resetButton = new GButton(this, 125, 420, 85, 18);
  resetButton.setText("Reset");
  resetButton.setTextBold();

  
  // Stroke RGB Knobs
  kx = 10;
  ky = 470;
  r = g = b = 0;

  lblStroke = new GLabel(this, 45, 20, 80, 880);
  lblStroke.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  lblStroke.setText("Stroke:");
  lblStroke.setTextBold();
  
  RStroke = new GKnob(this, kx, ky, 120, 120, 0.8);
  RStroke.setTurnRange(150, 270);
  RStroke.setTurnMode(G4P.CTRL_ANGULAR);
  RStroke.setArcPolicy(true, true, true);
  RStroke.setLimits(r, 0, 255);
  RStroke.setNbrTicks(9);
  RStroke.setLocalColorScheme(G4P.RED_SCHEME);

  GStroke = new GKnob(this, kx, ky, 120, 120, 0.8);
  GStroke.setTurnRange(270, 30);
  GStroke.setTurnMode(G4P.CTRL_ANGULAR);
  GStroke.setArcPolicy(true, true, true);
  GStroke.setLimits(g, 0, 255);
  GStroke.setNbrTicks(9);
  GStroke.setLocalColorScheme(G4P.GREEN_SCHEME);

  BStroke = new GKnob(this, kx, ky, 120, 120, 0.8);
  BStroke.setTurnRange(30, 150);
  BStroke.setTurnMode(G4P.CTRL_ANGULAR);
  BStroke.setArcPolicy(true, true, true);
  BStroke.setLimits(b, 0, 255);
  BStroke.setNbrTicks(9);
  BStroke.setLocalColorScheme(G4P.BLUE_SCHEME);   //<>//

  // Stroke Thickness Slider
  lblThickness = new GLabel(this, 20, 20, 200, 1290);
  lblThickness .setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  lblThickness .setText("Stroke Thickness:");
  lblThickness .setTextBold();
  thickness = new GCustomSlider(this, 20, 20, 200, 1350, "grey_blue");
  thickness.setShowDecor(false, true, true, true);
  thickness.setNbrTicks(5);
  thickness.setLimits(4, 1, 10);
  
  // Fill RGB Knobs
  kx2 = 140;
  ky2 = 470;
  r2 = g2 = b2 = 140;
  
  lblFill = new GLabel(this, 185, 20, 80, 880);
  lblFill.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  lblFill.setText("Fill:");
  lblFill.setTextBold();
  
  RFill = new GKnob(this, kx2, ky2, 120, 120, 0.8);
  RFill.setTurnRange(150, 270);
  RFill.setTurnMode(G4P.CTRL_ANGULAR);
  RFill.setArcPolicy(true, true, true);
  RFill.setLimits(r, 0, 255);
  RFill.setNbrTicks(9);
  RFill.setLocalColorScheme(G4P.RED_SCHEME);

  GFill = new GKnob(this, kx2, ky2, 120, 120, 0.8);
  GFill.setTurnRange(270, 30);
  GFill.setTurnMode(G4P.CTRL_ANGULAR);
  GFill.setArcPolicy(true, true, true);
  GFill.setLimits(g, 0, 255);
  GFill.setNbrTicks(9);
  GFill.setLocalColorScheme(G4P.GREEN_SCHEME);

  BFill = new GKnob(this, kx2, ky2, 120, 120, 0.8);
  BFill.setTurnRange(30, 150);
  BFill.setTurnMode(G4P.CTRL_ANGULAR);
  BFill.setArcPolicy(true, true, true);
  BFill.setLimits(b, 0, 255);
  BFill.setNbrTicks(9);
  BFill.setLocalColorScheme(G4P.BLUE_SCHEME);  
  
 //<>//
}

// For Selection within the Canvas
class UIRect{
  
  float left,top,right,bottom;
  public UIRect(){
    
  }

  public UIRect(PVector upperleft, PVector lowerright){
    setRect(upperleft.x,upperleft.y,lowerright.x,lowerright.y);
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
