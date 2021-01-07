// Variables
GCustomSlider brightness, contrast;
GDropList fileOptions;

public void GUI(){
  
  // Load/Save Drop Down Options
  String[] options = {"Load File", "Save File"};
  fileOptions = new GDropList(this, 20, 20, 100, 60, 2);
  fileOptions.setItems(options, 0);
  
  // =========================
  
  // Brightness Slider
  brightness = new GCustomSlider(this, 20, 20, 200, 150, "grey_blue");
  brightness.setShowDecor(false, true, true, true);
  brightness.setNbrTicks(5);
  brightness.setLimits(50, 0, 100);
  
  // Contrast Slider
  contrast = new GCustomSlider(this, 20, 20, 200, 220, "grey_blue");
  contrast.setShowDecor(false, true, true, true);
  contrast.setNbrTicks(5);
  contrast.setLimits(50, 0, 100);
}
