import javax.swing.JFileChooser;
import java.io.File;  
import java.io.FileWriter;

PImage loadedImage;
PImage outputImage;

public void openFile(){
    JFileChooser fileChooser = new JFileChooser();
    fileChooser.setDialogTitle("Open an image file"); 
    
    int result = fileChooser.showOpenDialog(null);
    
    if (result == JFileChooser.APPROVE_OPTION) {
      File selectedFile = fileChooser.getSelectedFile();
      String Path = selectedFile.getPath();
      
      // Swap the \ for / so that processing knows where to look
      Path = Path.replaceAll("\\\\", "/");;
      loadedImage = loadImage(Path);
      outputImage = loadedImage.copy();
    }   
}


public void closeFile(){
  
  JFileChooser fileChooser = new JFileChooser();
  fileChooser.setDialogTitle("Save an image file");   
   
  int userSelection = fileChooser.showSaveDialog(null);
  
  if (userSelection == JFileChooser.APPROVE_OPTION) {
    // Simplify the process by saving all files as a .png to avoid the need to convert a PImage to a BufferImage
    outputImage.save(fileChooser.getSelectedFile() + ".png");
  }
}
