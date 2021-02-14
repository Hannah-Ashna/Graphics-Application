// =====================
//      Shape Class
// =====================

class Shape {

  String drawingMode = "";
  String imageStyle = "";
  PVector pointA;
  PVector pointB;

  int R = r, G = g, B = b;
  int R2 = r2, G2 = g2, B2 = b2;
  int weight = thicknessVal;
  
  boolean isSelected = false;
  boolean isBeingDrawn = false;
  boolean curveReady = false;
  boolean polygonReady = false;
//boolean moveReady = false;
  
  //Used to store ImageShape
  PImage shapeImage, outputImage;
  
  ArrayList<PVector> polyPoints = new ArrayList<PVector>();
  
  // Initialise drawn object
  public Shape (String drawingMode) {
    this.drawingMode = drawingMode;
  }

  void setImage(PImage img){
    shapeImage = img.copy();
    outputImage = img.copy();
    PVector start = new PVector (290, 90);
    this.pointA = start; 
    PVector end = new PVector (290 + shapeImage.width, 90 + shapeImage.height);
    this.pointB = end;
  }
  
  void updateImage(PImage img){
    outputImage = img.copy();
  }
  
  public void setImageStyle(String effect){
    this.imageStyle = effect;
  }
  
  public PImage returnImage(){
    if (shapeImage != null) {
      return shapeImage.copy();
    }
    return null;
  }
  
  public PImage returnOutputImage(){
    if (shapeImage != null) {
      return outputImage.copy();
    }
    return null;
  }  
  
  // Start the drawing of shape object
  public void startDrawing(PVector start) {
    this.isBeingDrawn = true;
    this.pointA = start;
    this.pointB = start;
  }

  // During the drawing of shape object
  public void duringDrawing(PVector dragPoint) {
    if (this.isBeingDrawn) {
      this.pointB = dragPoint;
    }
  }

  // End the drawing of shape object
  public void endDrawing(PVector end) {
    this.pointB = end;
    this.isBeingDrawn = false;
  }

  public void addPolyPoints(PVector point) {
    polyPoints.add(point);
  }

  // Select a drawn shape object
  public boolean toggleSelect(PVector point) {
    UIRect selectionRegion = new UIRect(pointA, pointB);

    if (selectionRegion.isPointInside(point)) {
      this.isSelected = !this.isSelected;
      return true;
    }
    return false;
  }

  // Used in the resize function
  public void resizePoints(PVector point) {
    float diffX, diffY;
    diffX = this.pointA.x - point.x;
    diffY = this.pointA.y - point.y;
    this.pointA.x = point.x;
    this.pointA.y = point.y;
    
    this.pointB.x = pointB.x + (diffX);
    this.pointB.y = pointB.y + (diffY);
    
  }

  // Used in the move function
  public void movePoints(PVector modifier) {
    this.pointA.x += modifier.x;
    this.pointA.y += modifier.y;
    this.pointB.x += modifier.x;
    this.pointB.y += modifier.y;
  }
  
  // Save an image
  public void saveImage(){
    closeFile(shapeImage);
    storeImage = false;
  }



  // Draw the shape object
  public void drawShapes() {
    float x1 = this.pointA.x;
    float y1 = this.pointA.y;
    float x2 = this.pointB.x;
    float y2 = this.pointB.y;
    
    float w = x2-x1;
    float h = y2-y1;


    if (this.isSelected) {
      setSelectedDrawingStyle();
    } else {
      setDefaultDrawingStyle();
    }

    if (drawingMode == "rect") {
      rect(x1, y1, w, h);
    }

    if (drawingMode == "ellipse") {
      ellipse(x1+ w/2, y1 + h/2, w, h);
    }

    if (drawingMode == "line") {
      line(x1, y1, x2, y2);
    }

    if (drawingMode == "curve") {
      romcatmullCurve(polyPoints);
      if (this.curveReady == true) {
        endShape();
      }
    }
    
    if (drawingMode == "poly") {      
      if (this.polygonReady == true) {
        
        int length = polyPoints.size();
        PVector endPoint = polyPoints.get(length - 1);
        PVector startPoint = polyPoints.get(0);
        
        if (endPoint.x == startPoint.x && endPoint.y == startPoint.y){
          polygon(polyPoints);
          endShape(CLOSE);
        }
        
        else {
          polyLine(polyPoints);
          endShape();
        }
      }
    }
    
    if (drawingMode == "image" && outputImage != null){
      rect(x1 - 1, y1 - 1, w + 1, h + 1);
      image(outputImage, x1, y1, w, h);
      
    }

    // Not used due to Canvas issue -- See DrawingList initCanvas() method
    if ( drawingMode == "initial") {
      strokeWeight(2);
      stroke(0, 0, 0);
      fill(255, 255, 255);
      square(280, 80, 600);
    }
  }

  // Change the drawing style of selected shape objects
  void setSelectedDrawingStyle() {
    strokeWeight(2);
    stroke(0, 0, 0);
    fill(255, 100, 100);
  }

  // Set the default drawing style based on user choice (RGB Knobs)
  void setDefaultDrawingStyle() {
    strokeWeight(weight);
    stroke(R, G, B);
    fill(R2, G2, B2);
  }

  // Using begin and end shape created a duplication issue
  // This boolean ensures that the shape is only ended once we're done with the curve
  public void drawCurve() {
    this.curveReady = true;
  }
  
  public void drawPolygon() {
    this.polygonReady = true;
  }
  
}
