// =====================
//    GUI Settings
// =====================

// Variables
GCustomSlider brightness, contrast;
GDropList filterOptions;
GLabel lblBrightness, lblContrast, lblFilter;
GButton loadFile, saveFile;

public void GUI(){
  
  // Load and Save file buttons
  loadFile = new GButton(this, 20, 15, 100, 18);
  loadFile.setText("Load File");
  loadFile.setTextBold();
  saveFile = new GButton(this, 125, 15, 100, 18);
  saveFile.setText("Save File");
  saveFile.setTextBold();
  
  // Filters Dropdown Options
  lblFilter = new GLabel(this, 20, 20, 80, 470);
  lblFilter.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  lblFilter.setText("Filters:");
  lblFilter.setTextBold();
  String[] options = {" - ", "Negative", "Greyscale", "Blur", "Sharpen", "Edge"};
  filterOptions = new GDropList(this, 22, 270, 80, 100, 6);
  filterOptions.setItems(options, 0);
  
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
  
}
