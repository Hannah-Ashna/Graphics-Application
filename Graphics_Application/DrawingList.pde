// =======================
//    Drawing List Class
// =======================

class DrawingList {
  ArrayList<Shape> shapesList = new ArrayList<Shape>();
  
  // Used for image-shapes
  PImage ImageShape;
  
  public Shape currentlyDrawnShape = null;
  
  public DrawingList() {}
  
  public void drawShapes() {
    for (Shape s : shapesList){
      s.drawShapes();
    }
  }
  
  void setImage (PImage img){
    ImageShape = img;
    loadNewImage(ImageShape);
  }
  
  // No longer used
  // Being part of the drawing list meant that it would cover any image that was loaded (Can be used if image editing is not used)
  public void initCanvas() {
      println("Initialising Canvas");
      PVector canvasLoc = new PVector(280, 80);
      Shape newShape = new Shape("initial");
      newShape.startDrawing(canvasLoc);
      shapesList.add(newShape);
      currentlyDrawnShape = newShape;
      canvasLoc.set(880, 680);
      currentlyDrawnShape.endDrawing(canvasLoc);
  }  
  
  // Create a new image shape object
  public void loadNewImage(PImage img) {
    Shape newShape = new Shape("image");
    newShape.setImage(img);
    shapesList.add(newShape);
    newImage = false;
  }
  
  // Capture mouse events to decide what shape to draw
  public void mouseDrawEvent (String shapeType, int eventType, PVector mouseLoc){
    
    if (eventType == 1) {
      println("Mouse Pressed");
      Shape newShape = new Shape(shapeType);
      newShape.startDrawing(mouseLoc);
      shapesList.add(newShape);
      currentlyDrawnShape = newShape;
      if (shapeType == "poly" || shapeType == "curve"){
        currentlyDrawnShape.addPolyPoints(mouseLoc);        
      }
      
    }
    
    if (eventType == 4) {
      println("Mouse Dragged");
      
      // Draw the curve to allow user to see the curve being moved
      if (shapeType == "curve"){
        if (keyPressed == true) {
          currentlyDrawnShape.addPolyPoints(mouseLoc);
        }
      }
      
      if (shapeType == "poly"){
        if (keyPressed == true) {
          currentlyDrawnShape.addPolyPoints(mouseLoc);
          currentlyDrawnShape.drawPolygon();
        }
      }
      
      currentlyDrawnShape.duringDrawing(mouseLoc);
    }

    if (eventType == 2) {
      println("Mouse Released");
      
      // Draw the final curve
      if (shapeType == "curve"){
          currentlyDrawnShape.addPolyPoints(mouseLoc);
          currentlyDrawnShape.drawCurve();
      }
           
      if (shapeType == "poly"){
          currentlyDrawnShape.addPolyPoints(mouseLoc);
          currentlyDrawnShape.drawPolygon();
      }
      
      currentlyDrawnShape.endDrawing(mouseLoc);      
    }
  }
  
  // Select an existing shape object
  public void selectObject(int eventType, PVector mouseLoc) {
    if (eventType == 1) {
      for (Shape s : shapesList) {
        boolean selectionMade = s.toggleSelect(mouseLoc);
        if (selectionMade) break;
      }
    }
  } 
  
  // Delete an existing shape object
  public void deleteObject() {
    ArrayList<Shape> tempShapeList = new ArrayList<Shape>();
    for (Shape s : shapesList) {
      if (s.isSelected == false) tempShapeList.add(s);
    }
    
    shapesList = tempShapeList;
  }
  
  // Resize an existing shape object
  public void resizeObject(PVector mouseLoc, int eventType){
    for (Shape s : shapesList) {
      if (s.isSelected == true && eventType == 4) {
        s.resizePoints(mouseLoc);
      }
    }
  }
  
  // Move an existing shape object
  public void moveObject(PVector mouseLoc, int eventType){
    for (Shape s : shapesList) {
      if (s.isSelected == true && eventType == 4) {
        PVector modifier;
        modifier = new PVector(mouseLoc.x, mouseLoc.y);
        modifier.sub(s.pointA);
        s.movePoints(modifier);
      }
    }
  }
  
  // Save and store an image file locally
  public void saveImageFile(){
    for (Shape s : shapesList) {
      if (s.isSelected == true) {
        s.saveImage();
      }
    }
  }
  
  public void applyEffect(String effect){
    for (Shape s : shapesList) {
      if (s.returnImage() != null) {
        
        if (effect.equals("Brightness")){
          s.updateImage(Brightness(s.returnImage()));
          imageStyle = "";
        }
        
        if (effect.equals("Contrast")){
          s.updateImage(Contrast(s.returnImage()));
          imageStyle = "";
        }
        
        if (effect.equals("HSV")){
          s.updateImage(toHSV(s.returnOutputImage()));
          imageStyle = "";
        }        
        
        if (effect.equals("None")){
          s.updateImage(s.returnImage());
          imageStyle = "";
        }
        
        if (effect.equals("Negative")){
          s.updateImage(Negative(s.returnImage()));
          imageStyle = "";
        }
        
        if (effect.equals("Greyscale")){
          s.updateImage(Greyscale(s.returnImage()));
          imageStyle = "";
        }
        
        if (effect.equals("Blur")){
          PImage tempImg = s.returnImage();
          PImage outputImg = tempImg.copy();
          for (int y = 0; y < tempImg.height; y++) {
            for (int x = 0; x < tempImg.width; x++) {
              color convolution = Convolution(x, y, blur_matrix, blur_matrix.length, tempImg);
              outputImg.set(x, y, convolution);
            }
          }
          s.updateImage(outputImg);
          imageStyle = "";
        }
        
        if (effect.equals("Sharpen")){
          PImage tempImg = s.returnImage();
          PImage outputImg = tempImg.copy();
          for (int y = 0; y < tempImg.height; y++) {
            for (int x = 0; x < tempImg.width; x++) {
              color convolution = Convolution(x, y, sharpen_matrix, sharpen_matrix.length, tempImg);
              outputImg.set(x, y, convolution);   
            }
          }
          s.updateImage(outputImg);
          imageStyle = "";
        }
        
        if (effect.equals("Edge")){
          PImage tempImg = s.returnImage();
          PImage outputImg = tempImg.copy();
          for (int y = 0; y < tempImg.height; y++) {
            for (int x = 0; x < tempImg.width; x++) {
              color convolution = Convolution(x, y, edge_matrix, edge_matrix.length, tempImg);
              outputImg.set(x, y, convolution);
            }
          }
          s.updateImage(outputImg);
          imageStyle = "";
        }        
      }
    }
  }
  
  // Reset canvas
  public void reset(){
    ArrayList<Shape> tempShapeList = new ArrayList<Shape>();
    shapesList = tempShapeList;
  }

}
