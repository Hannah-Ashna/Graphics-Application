// =====================
//    GUI Settings
// =====================

// Variables
GCustomSlider brightness, contrast;
GDropList filterOptions;
GLabel lblBrightness, lblContrast, lblFilter;
GButton loadFile, saveFile, reset, saveImage, HSVButton, RGBButton;
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
  
}
