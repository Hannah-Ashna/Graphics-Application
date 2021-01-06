// SimpleUI_Classes version 5.0
// Started Dec 12th 2018
// This update July 2020
// Simon Schofield
// introduces image icons for buttons


//////////////////////////////////////////////////////////////////
// SimpleUI() is the only class you have to use in your 
// application to build and use the UI. 
// With it you can add buttons, sliders, menus and text boxes
// You can use a file dialogue to load and save files
//
//
// 
//
// Once a mouse event has been received by a UI item (button, menu etc) it calls a function called
// simpleUICallback(...) which you have to include in the 
// main part of the project (below setup() and draw() etc.)
//
// Also, you need to call uiManager.drawMe() in the main draw() function
//


public class SimpleUI{
  
    UIRect canvasRect;
    
    ArrayList<Widget> widgetList = new ArrayList<Widget>();
    
    String UIManagerName;
    
    UIRect backgroundRect = null;
    color backgroundRectColor; 

    // these are for capturing user events
    boolean pmousePressed = false;
    boolean pkeyPressed = false;
    String fileDialogPrompt = "";

    public SimpleUI(){
          UIManagerName = "";
          
      }
      
    public SimpleUI(String uiname){
          UIManagerName = uiname;
          
      }
      
   
   ////////////////////////////////////////////////////////////////////////////
   // file dialogue
   //
   
    public void openFileLoadDialog(String prompt) {
      fileDialogPrompt = prompt;
      selectInput(prompt, "fileLoadCallback", null, this);
    }
     
    void fileLoadCallback(File selection) {
      
      // cancelled
      if(selection == null){
      return;
      }
      
     
      // is directory not file
      if (selection.isDirectory()){
      return;
      }

      UIEventData uied = new UIEventData(UIManagerName, "fileLoadDialog" , "fileLoadDialog", "mouseReleased", mouseX, mouseY);
      uied.fileSelection = selection.getPath();
      uied.fileDialogPrompt = this.fileDialogPrompt;
      handleUIEvent( uied);
    }
    
    
    
    public void openFileSaveDialog(String prompt) {
      fileDialogPrompt = prompt;
      selectOutput(prompt, "fileSaveCallback", null, this);
    }
     
    void fileSaveCallback(File selection) {
      
      // cancelled
      if(selection == null){
      return;
      }
      
      String path = selection.getPath();
      println(path);

      UIEventData uied = new UIEventData(UIManagerName, "fileSaveDialog" , "fileSaveDialog", "mouseReleased", mouseX, mouseY);
      uied.fileSelection = selection.getPath();
      uied.fileDialogPrompt = this.fileDialogPrompt;
      handleUIEvent(uied);
    }
    
    ////////////////////////////////////////////////////////////////////////////
    // canvas creation
    //
    public void addCanvas(int x, int y, int w, int h){
      
      canvasRect = new UIRect(x,y,x+w,y+h);
    }
    
    public void checkForCanvasEvent(String mouseEventType, int x, int y){
       if(canvasRect==null) return;
       if(   canvasRect.isPointInside(x,y)) {
         UIEventData uied = new UIEventData(UIManagerName, "canvas" , "canvas", mouseEventType,x,y);
         handleUIEvent(uied);
       }

    }
    
    public void drawCanvas(){
      if(canvasRect==null) return;
      pushStyle();
      noFill();
      stroke(0,0,0);
      strokeWeight(1);
      rect(canvasRect.left, canvasRect.top, canvasRect.getWidth(), canvasRect.getHeight());
      popStyle();
    }
    
    ////////////////////////////////////////////////////////////////////////////
    // widget creation
    //
    
    boolean widgetNameAlreadyExists(String label, String  uiComponentType){
      
      for(Widget w: widgetList){
       if(w.UILabel.equals(label) && w.UIComponentType.equals(uiComponentType) ) {
         println("SimpleUI: that label name - ", label, " - already exists for widget of type ", uiComponentType);
         return true;
       }
      }
      return false;
    }
    
    // button creation
    public ButtonBaseClass addPlainButton(String label, int x, int y){
      if(widgetNameAlreadyExists(label,"ButtonBaseClass")) return null;
      ButtonBaseClass b = new ButtonBaseClass(UIManagerName,x,y,label);
      
      widgetList.add(b);
      return b;
    }
    
    public ButtonBaseClass addToggleButton(String label, int x, int y){
      if(widgetNameAlreadyExists(label,"ButtonBaseClass")) return null;
      ButtonBaseClass b = new ToggleButton(UIManagerName,x,y,label);
      
      widgetList.add(b);
      return b;
    }
    
    public ButtonBaseClass addToggleButton(String label, int x, int y, boolean initialState){
      if(widgetNameAlreadyExists(label,"ButtonBaseClass")) return null;
      ButtonBaseClass b = new ToggleButton(UIManagerName,x,y,label);
      
      b.selected = initialState;
      widgetList.add(b);
      return b;
    }
    
    public ButtonBaseClass addRadioButton(String label, int x, int y, String groupID){
      if(widgetNameAlreadyExists(label,"ButtonBaseClass")) return null;
      ButtonBaseClass b = new RadioButton(UIManagerName,x,y,label,groupID, this);
      
      widgetList.add(b);
      return b;
    }
    
    // label creation
    public SimpleLabel addLabel(String label, int x, int y,String txt){
      if(widgetNameAlreadyExists(label,"SimpleLabel")) return null;
      SimpleLabel sl = new SimpleLabel(UIManagerName,label,x,y,txt);
      
      widgetList.add(sl);
      return sl;
    }
  
    // menu creation
    public Menu addMenu(String label, int x, int y, String[] menuItems){
      if(widgetNameAlreadyExists(label,"Menu")) return null;
      Menu m = new Menu(UIManagerName,label,x,y,menuItems, this);
      
      widgetList.add(m);
      return m;
      }
    
    // slider creation
    public Slider addSlider(String label, int x, int y){
      if(widgetNameAlreadyExists(label,"Slider")) return null;
      Slider s = new Slider(UIManagerName,label,x,y);
      
      widgetList.add(s);
      return s;
    }
    

    // text input box creation
    public TextInputBox addTextInputBox(String label, int x, int y){
      int maxNumChars = 14;
      if(widgetNameAlreadyExists(label,"TextInputBox")) return null;
      TextInputBox tib = new TextInputBox(UIManagerName,label,x,y,maxNumChars);
      widgetList.add(tib);
      return tib;
    }
    
    public TextInputBox addTextInputBox(String label, int x, int y, String content){
      if(widgetNameAlreadyExists(label,"TextInputBox")) return null;
      TextInputBox tib = addTextInputBox( label,  x,  y);
      
      tib.setText(content);
      return tib;
    }
    


    void removeWidget(String uilabel){
      Widget w = getWidget(uilabel);
      if(w == null) return;
      widgetList.remove(w);
    }
    


    // getting widget data by lable
    //
    Widget getWidget(String uilabel){
      for(Widget w: widgetList){
       if(w.UILabel.equals(uilabel)) return w;
      }
      println(" getWidgetByLabel: cannot find widget with label ",uilabel);
      return null;
    }
    
    
    // get toggle state
    public boolean getToggleButtonState(String uilabel){
      Widget w = getWidget(uilabel);
      if( w.UIComponentType.equals("ToggleButton") || w.UIComponentType.equals("RadioButton")) return w.selected;
      println(" getToggleButtonState: cannot find widget with label ",uilabel);
      return false;
    }
   
    // get selected radio button in a group - returns the label name
    public String getRadioGroupSelected(String groupName){
       for(Widget w: widgetList){
        if( w.UIComponentType.equals("RadioButton")){
          if( ((RadioButton)w).radioGroupName.equals(groupName) && w.selected) return w.UILabel;
        }
    }
    return "";
    }
    
    
    
    public float getSliderValue(String uilabel){
      Widget w = getWidget(uilabel);
      if( w.UIComponentType.equals("Slider") ) return ((Slider)w).getSliderValue();
      return 0;
    }
    
    public void setSliderValue(String uilabel, float v){
      Widget w = getWidget(uilabel);
      if( w.UIComponentType.equals("Slider") )  ((Slider)w).setSliderValue(v);
      
    }
    
    
    
    
    
    
    public String getText(String uilabel){
      Widget w = getWidget(uilabel);
     
      if(w.UIComponentType.equals("TextInputBox")){
         return ((TextInputBox)w).getText();
      }
      
      if(w.UIComponentType.equals("SimpleLabel")){
         return ((SimpleLabel)w).getText();
      }
      return "";
    }
  
    public void setText(String uilabel, String content){
      Widget w = getWidget(uilabel);
      if(w.UIComponentType.equals("TextInputBox")){
            ((TextInputBox)w).setText(content); }
      if(w.UIComponentType.equals("SimpleLabel")){
            ((SimpleLabel)w).setText(content); }
      
    }
    
    
    
    // setting a background Color region for the UI. This is drawn first.
    // to do: this should also set an offset for subsequent placement of the buttons
    
    void setBackgroundRect(int left, int top, int right, int bottom, int r, int g, int b){
      backgroundRect = new UIRect(left,top,right,bottom);
      backgroundRectColor = color(r,g,b);
    }
    
    void setRadioButtonOff(String groupName){
      for(Widget w: widgetList){
        if( w.UIComponentType.equals("RadioButton")){
           if( ((RadioButton)w).radioGroupName.equals(groupName))  w.selected = false;
        }
      }
    }
    
    void setMenusOff(){
      for(Widget w: widgetList){
        if( w.UIComponentType.equals("Menu")){
          ((Menu)w).visible = false;
        }
      }
      
    }
    
    
    // this is an alternative to using the seperate event handlers provided by Processing
    // It therefor easier to use, but more sluggish in response
    void checkForUserInputEvents(){
      // this gets called in the drawMe() method, instead of having to link up
      // to the native mousePressed() etc. methods
      
       if( pmousePressed == false  && mousePressed){
          handleMouseEvent("mousePressed", mouseX, mouseY);
        }
 
      if( pmousePressed == true  && mousePressed == false){
         handleMouseEvent("mouseReleased", mouseX, mouseY);
        }
 
       if( (pmouseX != mouseX || pmouseY != mouseY) && mousePressed ==false){
         handleMouseEvent("mouseMoved", mouseX, mouseY);
       }
       if( (pmouseX != mouseX || pmouseY != mouseY) && mousePressed){
         handleMouseEvent("mouseDragged", mouseX, mouseY);
       }
       
       
       if( pkeyPressed == false && keyPressed == true){
         handleKeyEvent(key, keyCode, "pressed");
       }
       
       if( pkeyPressed == true && keyPressed == false){
        handleKeyEvent(key, keyCode, "released");
       }
       
      pmousePressed = mousePressed;
      pkeyPressed = keyPressed;
    }
      
      

    
    
    void handleMouseEvent(String mouseEventType, int x, int y){
      checkForCanvasEvent(mouseEventType,x,y);
      Widget widgetActing = null;
      
      for(Widget w: widgetList){
        boolean eventAbsorbed = w.handleMouseEvent(mouseEventType,x,y);
        
        if(eventAbsorbed) { widgetActing = w; }
        if(eventAbsorbed) break;
      }
      if(widgetActing == null) return;
      widgetActing.doEventAction(mouseEventType,x,y);
    }
    
    
    
    void handleKeyEvent(char k, int kcode, String keyEventType){
      for(Widget w: widgetList){
         w.handleKeyEvent( k,  kcode,  keyEventType);
      }
    }
    
    
    void update(){
      checkForUserInputEvents();
      
      if( backgroundRect != null ){
        pushStyle();
        fill(backgroundRectColor);
        rect(backgroundRect.left,backgroundRect.top,backgroundRect.getWidth(), backgroundRect.getHeight());
        popStyle();
      }
      
      drawCanvas();
      for(Widget w: widgetList){
         w.drawMe();
      }
      
    }
    
    void clearAll(){
      widgetList = new ArrayList<Widget>();
    }
    
   

  }// end of SimpleUIManager
  
  
  
//////////////////////////////////////////////////////////////////
// UIEventData
// when a UI component calls the simpleUICallback() function, it passes this object back
// which contains EVERY CONCEIVABLE bit of extra information about the event that you could imagine
//
public class UIEventData{
  // set by the constructor
  public String callingUIManager; // this is the name of the UIManager, because you might have more than one
  public String uiComponentType; // this is the type of widet e.g. ButtonBaseClass, ToggleButton, Slider - it is identical to the class name
  public String uiLabel; // this is the unique shown label for each widget, and is used to idetify the calling widget
  public String mouseEventType;
  public int mousex; // this is the x location of the recieved mouse event, in window space
  public int mousey;
  
  // extra stuff, which is specific to particular widgets
  public boolean toggleSelectState = false;
  public String radioGroupName = "";
  public String menuItem = "";
  public float sliderValue = 0.0;
  public String fileDialogPrompt = "";
  public String fileSelection = "";
  
  // key press and text content information for text widgets
  public char keyPress;
  public String textContent;
  
   public UIEventData(){
   }
   
   
   
   public UIEventData(String uiname, String thingType, String label, String mouseEvent, int x, int y){
     initialise(uiname, thingType, label, mouseEvent, x,y);
     
   }
   
   void initialise(String uiname, String thingType, String label, String mouseEvent, int x, int y){
     
     callingUIManager = uiname;
     uiComponentType = thingType;
     uiLabel = label;
     mouseEventType = mouseEvent;
     mousex = x;
     mousey = y;
     
   }
   
   boolean eventIsFromWidget(String lab){
     if( uiLabel.equals( lab )) return true;
     if( menuItem.equals(lab) ) return true;
     return false;
     
   }
   
   void print(int verbosity){
     if(verbosity != 3 && this.mouseEventType.equals("mouseMoved")) return;
     
     
     if(verbosity == 0) return;
     
     if(verbosity >= 1){
       println("UIEventData:" + this.uiComponentType + " " + this.uiLabel);
       
       if( this.uiComponentType.equals("canvas")){
         println("mouse event:" + this.mouseEventType + " at (" + this.mousex +"," + this.mousey + ")");
       }
       
     }
     
     if(verbosity >= 2){
         println("toggleSelectState " + this.toggleSelectState);
         println("radioGroupName " + this.radioGroupName);
         println("sliderValue " + this.sliderValue);
         println("menuItem " + this.menuItem);
         println("keyPress " + keyPress);
         println("textContent " + textContent);
         println("fileDialogPrompt " + this.fileDialogPrompt);
         println("fileSelection " + this.fileSelection);
     }
     
     if(verbosity == 3 ){
         if(this.mouseEventType.equals("mouseMoved")) {
         println("mouseMove at (" + this.mousex +"," + this.mousey + ")");
         }
     }
     
     println(" ");
   }
  
}





//////////////////////////////////////////////////////////////////
// Everything below here is stuff wrapped up by the UImanager class
// so you don't need to to look at it, or use it directly. But you can if you
// want to!
// 





//////////////////////////////////////////////////////////////////
// Base class to all components
class Widget{
  
  // Color for overall application
  color SimpleUIAppBackgroundColor = color(240,240,240);// the light neutralgrey of the overall application surrounds
  
  // Color for UI components
  color SimpleUIBackgroundRectColor = color(230,230,240); // slightly purpley background rect Color for alternative UI's
  color SimpleUIWidgetFillColor = color(200,200,200);// darker grey for butttons
  color SimpleUIWidgetRolloverColor = color(215,215,215);// slightly lighter rollover Color
  color SimpleUITextColor = color(0,0,0);


  // should any widgets need to "talk" to other widgets (RadioButtons, Menus)
  SimpleUI parentManager = null; 
  
  // Because you can have more than one UIManager in a system, 
  // e.g. a seperate one for popups, or tool modes
  String UIManagerName;
  
  // this should be the best way to identify a widget, so make sure
  // that all UILabels are unique
  String UILabel;
  boolean displayLabel  = true;
  
  // type of component e.g. "UIButton", should be absolutely same as class name
  public String UIComponentType = "WidgetBaseClass";
  
  // location and size of widget
  int widgetWidth, widgetHeight;
  int locX, locY;
  public UIRect bounds;
  
  // needed by most, but not all widgets
  boolean rollover = false;
  
  // needed by some widgets but not all
  boolean selected = false;
  
  public Widget(String uiname){
    
    UIManagerName = uiname;
  }
  
  public Widget(String uiname, String uilabel, int x, int y, int w, int h){
    
    UIManagerName = uiname;
    UILabel = uilabel;
    setBounds(x, y, w, h);
  }
  
  // virtual functions
  // 
  public void setBounds(int x, int y, int w, int h){
    locX = x;
    locY = y;
    widgetWidth = w;
    widgetHeight = h;
    bounds = new UIRect(x,y,x+w,y+h);
  }
  
  public boolean isInMe(int x, int y){
    if(   bounds.isPointInside(x,y)) return true;
   return false;
  }
  
  public void setParentManager(SimpleUI manager){
    parentManager = manager;
  }
  
  public void setWidgetDims(int w, int h){
    setBounds(locX,locY,w, h);
  }
  
  
  
  // "virtual" functions here
  //
  public void drawMe(){}
  
  public boolean handleMouseEvent(String mouseEventType, int x, int y){ return false;}
  
  public void doEventAction(String mouseEventType, int x, int y){
    UIEventData uied = new UIEventData(UIManagerName, UIComponentType, UILabel, mouseEventType, x,y);
    handleUIEvent(uied);
  }
  
  
  void handleKeyEvent(char k, int kcode, String keyEventType){}
  
  void setSelected(boolean s){
    selected = s;
  }

}


//////////////////////////////////////////////////////////////////
// Simple Label widget - uneditable text
// It displays label:text, where text is changeable in the widget's lifetime, but label is not

class SimpleLabel extends Widget{
  
  int textPad = 5;
  String text;
  int textSize = 12;
  
  
  public SimpleLabel(String uiname, String uilable, int x, int y,  String txt){
    super(uiname, uilable,x,y,100,30);
    UIComponentType = "SimpleLabel";
    this.text = txt;
    
  }
  
  public void drawMe(){
    pushStyle();
    stroke(100,100,100);
    strokeWeight(1);
    fill(SimpleUIBackgroundRectColor);
    rect(locX, locY, widgetWidth, widgetHeight);
   
    String seperator = ":";
    if(this.text.equals("")) seperator = " ";
    String displayString;
    
    if(displayLabel) { 
      
      displayString = this.UILabel + seperator + this.text;
    
    } else {
      
      displayString = this.text;
    }
    
    
        
    if( displayString.length() < 20) {
      textSize = 9;} 
      else { textSize = 9; }
    fill(SimpleUITextColor);  
    textSize(textSize);
    strokeWeight(1);
    text(displayString, locX+textPad, locY+textPad, widgetWidth, widgetHeight);
    popStyle();
  }
  
  void setText(String txt){
    this.text = txt;
  }
  
  String getText(){
    return this.text;
  }
  
  
}


//////////////////////////////////////////////////////////////////
// Base button class, functions as a simple button, and is the base class for
// toggle and radio buttons
class ButtonBaseClass extends Widget{

  int textPad = 5;
  int textSize = 12;

  PImage icon = null;

  public ButtonBaseClass(String uiname, int x, int y, String uilable){
    super(uiname, uilable,x,y,70,30);

    UIComponentType = "ButtonBaseClass";
  }
  
  void setIcon(PImage iconImg){
    icon = iconImg.copy();
    icon.resize(widgetWidth-2, widgetHeight-2);
  }
  
  
  public void setButtonDims(int w, int h){
    setBounds(locX,locY,w, h);
  }
  
  public boolean handleMouseEvent(String mouseEventType, int x, int y){
    if( isInMe(x,y) /*&& (mouseEventType.equals("mouseMoved") || mouseEventType.equals("mousePressed"))*/){
      rollover = true;
      
    } else { rollover = false;}
    
    if( isInMe(x,y) && mouseEventType.equals("mouseReleased")){
      return true;
    }
    return false;
  }
  
  
  
  public void drawMe(){
    pushStyle();
    stroke(0,0,0);
    strokeWeight(1);
    if(rollover){
      fill(SimpleUIWidgetRolloverColor);}
    else{
      fill(SimpleUIWidgetFillColor);
    }
    
    rect(locX, locY, widgetWidth, widgetHeight);
    fill(SimpleUITextColor);
    if( this.UILabel.length() < 10) {
      textSize = 12;} 
      else { textSize = 9; }
      
    textSize(textSize);
    strokeWeight(1);
    text(this.UILabel, locX+textPad, locY+textPad, widgetWidth, widgetHeight);
    popStyle();
    
    drawIconImage();
  }
  
  void drawIconImage(){
    if(icon == null) return;
    
    pushStyle();
    tint(127, 127, 127, 255);
    if(rollover) tint(200, 200, 200, 255);
    if(rollover && mousePressed) tint(255, 255, 255, 255);
    if(selected) tint(255, 255, 255, 255);
    image(icon, locX+1, locY+1, widgetWidth-2, widgetHeight-2);
    
    popStyle();
  }

}

//////////////////////////////////////////////////////////////////
// ToggleButton

class ToggleButton extends ButtonBaseClass{
  
  
  
  public ToggleButton(String uiname, int x, int y, String labelString){
    super(uiname,x,y,labelString);
    
    UIComponentType = "ToggleButton";
  }
  
  public boolean handleMouseEvent(String mouseEventType, int x, int y){
    if( isInMe(x,y) && (mouseEventType.equals("mouseMoved") || mouseEventType.equals("mousePressed"))){
      rollover = true;
    } else { rollover = false; }
    
    if( isInMe(x,y) && mouseEventType.equals("mouseReleased")){
      return true;
    }
    return false;
  }
  
  public void doEventAction(String mouseEventType, int x, int y){
      swapSelectedState();
      UIEventData uied = new UIEventData(UIManagerName, UIComponentType, UILabel, mouseEventType, x,y);
      uied.toggleSelectState = selected;
      handleUIEvent(uied);
  }
  
  public void swapSelectedState(){
    selected = !selected;
  }
  
  public void drawMe(){
    pushStyle();
    stroke(0,0,0);
    if(rollover){
      fill(SimpleUIWidgetRolloverColor);}
    else{
      fill(SimpleUIWidgetFillColor);   
    }
    
    if(selected){
     strokeWeight(2);
     rect(locX+1, locY+1, widgetWidth-2, widgetHeight-2);
     } else {
     strokeWeight(1);
     rect(locX, locY, widgetWidth, widgetHeight);  
     }
   
      
      
    
    
    stroke(0,0,0);
    strokeWeight(1);
    fill(SimpleUITextColor);
    textSize(textSize);
    strokeWeight(1);
    text(this.UILabel, locX+textPad, locY+textPad, widgetWidth, widgetHeight);
    popStyle();
  }
  
  
  
}

//////////////////////////////////////////////////////////////////
// RadioButton

class RadioButton extends ToggleButton{
  
  
  // these have to be part of the base class as is accessed by manager
  public String radioGroupName = "";
  
  public RadioButton(String uiname,int x, int y, String labelString, String groupName,SimpleUI manager){
    super(uiname,x,y,labelString);
    radioGroupName = groupName;
    UIComponentType = "RadioButton";
    parentManager = manager;
  }
  
  
  public boolean handleMouseEvent(String mouseEventType, int x, int y){
    if( isInMe(x,y) && (mouseEventType.equals("mouseMoved") || mouseEventType.equals("mousePressed"))){
      rollover = true;
    } else { rollover = false; }
    
    if( isInMe(x,y) && mouseEventType.equals("mouseReleased")){
       return true;
    }
    
    return false;
    
  }
  
  
   public void doEventAction(String mouseEventType, int x, int y){ 
      parentManager.setRadioButtonOff(this.radioGroupName);
      selected = true;
      UIEventData uied = new UIEventData(UIManagerName, UIComponentType, UILabel, mouseEventType, x,y);
      uied.toggleSelectState = selected;
      uied.radioGroupName  = this.radioGroupName;
      handleUIEvent(uied);
  }
  
  public void turnOff(String groupName){
    if(groupName.equals(radioGroupName)){
      selected = false;
    }
    
  }
  
}



/////////////////////////////////////////////////////////////////////////////
// menu stuff
//
//

/////////////////////////////////////////////////////////////////////////////
// the menu class
//
class Menu extends Widget{
  
  
  int textPad = 5;
  //String title;
  int textSize = 12;

  int numItems = 0;
  SimpleUI parentManager;
  public boolean visible = false;
  
  
  ArrayList<String> itemList = new ArrayList<String>();
  
  
  
  public Menu(String uiname, String uilabel, int x, int y, String[] menuItems, SimpleUI manager)
    {
    super(uiname,uilabel,x,y,100,20);
    parentManager = manager;
    UIComponentType = "Menu";
    
    for(String s: menuItems){
      itemList.add(s);
      numItems++;
    }
    }
    
  

  public void drawMe(){
    //println("drawing menu " + title);
    drawTitle();
    if( visible ){
     drawItems();
    } 
    
  }
  
  void drawTitle(){
    pushStyle();
    strokeWeight(1);
    stroke(0,0,0);
    if(rollover){
      fill(SimpleUIWidgetRolloverColor);}
    else{
      fill(SimpleUIWidgetFillColor);
    }
     
    rect(locX, locY, widgetWidth,widgetHeight);
    fill(SimpleUITextColor);
    textSize(textSize);
    text(this.UILabel, locX+textPad, locY+3, widgetWidth,widgetHeight);
    popStyle();
  }
  
  
  void drawItems(){
    pushStyle();
    strokeWeight(1);
    if(rollover){
      fill(SimpleUIWidgetRolloverColor);}
    else{
      fill(SimpleUIWidgetFillColor);
    }
    
    
    
    int thisY = locY + widgetHeight;
    rect(locX, thisY, widgetWidth, (widgetHeight*numItems));
    
    if(isInItems(mouseX,mouseY)){
      hiliteItem(mouseY);
    }
    
    fill(SimpleUITextColor);
    
    textSize(textSize);
    
    for(String s : itemList){
      
      if(s.length() > 14)
        {textSize(textSize-1);}
      else {textSize(textSize);}
      
      
      text(s, locX+textPad, thisY, widgetWidth, widgetHeight);
      thisY += widgetHeight;
    }
   popStyle();
  }
  
  
 void hiliteItem(int y){
   pushStyle();
   int topOfItems =this.locY + widgetHeight;
   float distDown = y - topOfItems;
   int itemNum = (int) distDown/widgetHeight;
   fill(230,210,210);
   rect(locX, topOfItems + itemNum*widgetHeight, widgetWidth, widgetHeight);
   popStyle();
 }
  
 public boolean handleMouseEvent(String mouseEventType, int x, int y){
    rollover = false;
    
    //println("here1 " + mouseEventType);
    if(isInMe(x,y)==false) {
      visible = false;
      return false;
    }
    if( isInMe(x,y)){
      rollover = false;
    }
    
    //println("here2 " + mouseEventType);
    if(mouseEventType.equals("mousePressed") && visible == false){
      //println("mouseclick in title of " + title);
      parentManager.setMenusOff();
      visible = true;
      rollover = true;
      return false;
    }
    if(mouseEventType.equals("mousePressed") && isInItems(x,y)){
      parentManager.setMenusOff();
      return true;
    }
    return false;
  }
  
   public void doEventAction(String mouseEventType, int x, int y){ 
      println("menu event ", UIComponentType, UILabel, mouseEventType, x,y);
      String pickedItem = getItem(y);
      
      UIEventData uied = new UIEventData(UIManagerName, UIComponentType, UILabel, mouseEventType, x,y);
      uied.menuItem = pickedItem;
      
      handleUIEvent(uied);
      
      
  }
  
 String getItem(int y){
   int topOfItems =this.locY + widgetHeight;
   float distDown = y - topOfItems;
   int itemNum = (int) distDown/widgetHeight;
   //println("picked item number " + itemNum);
   return itemList.get(itemNum);
 }
  
 boolean isInMe(int x, int y){
   if(isInTitle(x,y)){
     //println("mouse in title of " + title);
     return true;
   }
   if(isInItems(x,y)){
     return true;
   }
   return false;
 }
 
 boolean isInTitle(int x, int y){
   if(x >= this.locX   && x < this.locX+this.widgetWidth &&
      y >= this.locY && y < this.locY+this.widgetHeight) return true;
   return false;
   
 }
 
 
 boolean isInItems(int x, int y){
   if(visible == false) return false;
   if(x >= this.locX   && x < this.locX+this.widgetWidth &&
      y >= this.locY+this.widgetHeight && y < this.locY+(this.widgetHeight*(this.numItems+1))) return true;
      
   
   return false;
 }
  
  
  
  
}// end of menu class

/////////////////////////////////////////////////////////////////////////////
// Slider class stuff

/////////////////////////////////////////////////////////////////////////////
// Slider Class
//
// calls back with value on  both release and drag

class Slider extends Widget{

  boolean showValue = true;
  public float currentValue  = 0.0;
  boolean mouseEntered = false;
  int textPad = 5;
  int textSize = 12;
  boolean rollover = false;
  
  public String HANDLETYPE = "ROUND";
  
  public Slider(String uiname, String label, int x, int y){
    super(uiname,label,x,y,102,30); 
    UIComponentType = "Slider";
  }
  
  void showValue(boolean sv){
    showValue = sv;
  }
  
  public boolean handleMouseEvent(String mouseEventType, int x, int y){
    PVector p = new PVector(x,y);
    
    if( mouseLeave(p) ){
      return false;
      //println("mouse left sider");
    }
    
    if( bounds.isPointInside(p) == false){
      mouseEntered = false;
      return false; }
    
    
    
    if( (mouseEventType.equals("mouseMoved") || mouseEventType.equals("mousePressed"))){
      rollover = true;
    } else { rollover = false; }
    
    
    if(  mouseEventType.equals("mousePressed") /*|| mouseEventType.equals("mouseReleased") || mouseEventType.equals("mouseDragged")*/ ){
      mouseEntered = true;
      return true;
    }
    
    if( mouseEventType.equals("mouseDragged") && mouseEntered) return true;
    
    return false;
    
  }
  
  public void doEventAction(String mouseEventType, int x, int y){ 
      float val = getSliderValueAtMousePos(x);
      //println("slider val",val);
      setSliderValue(val);
      UIEventData uied = new UIEventData(UIManagerName, UIComponentType, UILabel, mouseEventType, x,y);
      uied.sliderValue = val;
      handleUIEvent(uied);
  }
  
  float getSliderValueAtMousePos(int pos){
    float val = map(pos, bounds.left, bounds.right, 0,1);
    return val;
  }
  
  float getSliderValue(){
    return currentValue;
  }
  
  void setSliderValue(float val){
   currentValue =  constrain(val,0,1);
  }
  
  boolean mouseLeave(PVector p){
     // is only true, if the mouse has been in the widget, has been depressed
    if( mouseEntered && bounds.isPointInside(p)== false) {
      mouseEntered = false;
      return true; }
      
    return false;
  }
  
  public void drawMe(){
    pushStyle();
    stroke(0,0,0);
    strokeWeight(1);
    if(rollover){
      fill(SimpleUIWidgetRolloverColor);}
    else{
      fill(SimpleUIWidgetFillColor);
    }
    rect(bounds.left, bounds.top,  bounds.getWidth(), bounds.getHeight());
    fill(SimpleUITextColor);
    textSize(textSize);
    text(this.UILabel, bounds.left+textPad, bounds.top+26);
    int sliderHandleLocX = (int) map(currentValue,0,1,bounds.left, bounds.right);
    sliderHandleLocX = (int)constrain(sliderHandleLocX, bounds.left+10, bounds.right-10 );
    stroke(127);
    float lineHeight = bounds.top+ (bounds.getHeight()/2.0) - 5;
    line(bounds.left+5, lineHeight,  bounds.left+bounds.getWidth()-5, lineHeight);
    stroke(0);
    drawSliderHandle(sliderHandleLocX);
    popStyle();
    
    if(showValue) drawValue();
  }
  
  void drawValue(){
    pushStyle();
    textSize(10);
    fill(255,0,0);
    
    String currentValueString = nf(currentValue,1,4);
    
    text(currentValueString, bounds.right-60, bounds.top + 10);
    popStyle();
  }
  
  void drawSliderHandle(int loc){
    pushStyle();
    stroke(0,0,0);
    fill(255,255,255,100);
    if(HANDLETYPE.equals("ROUND")) {
      //if(this.label =="tone"){
      //  println("drawing slider" + this.label, loc, bounds.top + 10);
      //  
      //}
      
     ellipse(loc, bounds.top + 10, 10,10);
    }
    if(HANDLETYPE.equals("UPARROW")) {
      triangle(loc-4, bounds.top + 15, loc,bounds.top - 2, loc+4, bounds.top + 15);
    }
    if(HANDLETYPE.equals("DOWNARROW")){
      triangle(loc-4, bounds.top + 5, loc,bounds.bottom + 2, loc+4, bounds.top + 5);
    }
    popStyle();
  }
  
}

////////////////////////////////////////////////////////////////////////////////
// self contained simple txt ox input
// simpleUICallback is called after every character insertion/deletion, enabling immediate udate of the system
//
class TextInputBox extends Widget{
  String contents = "";
  int maxNumChars = 14;
  
  boolean rollover;
  
  color textBoxBackground = color(235,235,255);
  
  public TextInputBox(String uiname, String uilabel, int x, int y,  int maxNumChars){
    super(uiname,uilabel,x,y,100,30);
    UIComponentType = "TextInputBox";
    this.maxNumChars = maxNumChars;
    
    rollover = false;
    
  }

  
  public boolean handleMouseEvent(String mouseEventType, int x, int y){
    // can only type into an input box if the mouse is hovering over
    // this way we avoid sending text input to multiple widgets
    PVector mousePos = new PVector (x,y);
    rollover = bounds.isPointInside(mousePos);
   // if(rollover) println("text box rollover", UILabel, " ", rollover);
    return rollover;  
  }
  
  void handleKeyEvent(char k, int kcode, String keyEventType){
    rollover = bounds.isPointInside(mouseX, mouseY);
    if(keyEventType.equals("released")) return;
    if(rollover == false) return;

    UIEventData uied = new UIEventData(UIManagerName, UIComponentType, UILabel, "textInputEvent", 0,0);
    uied.keyPress = k;
   


    
        
    if( isValidCharacter(k) ){
        addCharacter(k);   
    }
    
    if(k == BACKSPACE){
        deleteCharacter();
    }
    
     handleUIEvent(uied);
  }
  
  void addCharacter(char k){
    if( contents.length() < this.maxNumChars){
      contents=contents+k;
      
    }
    
  }
  
  void deleteCharacter(){
    int l = contents.length();
    if(l == 0) return; // string already empty
    if(l == 1) {contents = ""; }// delete the final character
    String cpy  = contents.substring(0, l-1);
    contents = cpy;
    
  }
  
  boolean isValidCharacter(char k){
    if(k == BACKSPACE) return false;
    return true;
    
  }

  String getText(){
    return contents;
  }
  
  void setText(String s){
    contents = s;
  }

  public void drawMe(){
    pushStyle();
      stroke(0,0,0);
      fill(textBoxBackground);
      strokeWeight(1);
      
      if(rollover){stroke(255,0,0);fill(SimpleUIWidgetRolloverColor);}
      

      rect(locX, locY, widgetWidth, widgetHeight);
      stroke(0,0,0);
      fill(SimpleUITextColor);
      
      int textPadX = 5;
      int textPadY = 20;
      fill(SimpleUITextColor);  
      textSize(12);
      strokeWeight(1);
      text(contents, locX + textPadX, locY + textPadY);
      //text(UILabel, locX + textPadX + 50, locY + textPadY);
      
      if(displayLabel) text(UILabel, locX + widgetWidth + textPadX, locY + textPadY);
    popStyle();
  }
}  



/////////////////////////////////////////////////////////////////
// simple rectangle class especially for this UI stuff
//

class UIRect{
  
  float left,top,right,bottom;
  public UIRect(){
    
  }

  public UIRect(PVector upperleft, PVector lowerright){
    setRect(upperleft.x,upperleft.y,lowerright.x,lowerright.y);
  }
  
  public UIRect(float x1, float y1, float x2, float y2){
    setRect(x1,y1,x2,y2);
  }
  
  void setRect(UIRect other){
    setRect(other.left, other.top, other.right, other.bottom);
  }
  
  UIRect copy(){
    return new UIRect(left, top, right, bottom);
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
  
  float getWidth(){
    return (this.right - this.left);
  }
  
  float getHeight(){
    return (this.bottom - this.top);
  }
  
  PVector getTopLeft(){
    return new PVector(left,top);
  }
  
  PVector getBottomRight(){
    return new PVector(right,bottom);
  }
  
  boolean isBetweenInc(float v, float lo, float hi){
  if(v >= lo && v <= hi) return true;
  return false;
 }

}// end UIRect class
