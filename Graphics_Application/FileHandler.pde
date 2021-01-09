import javax.swing.JFileChooser;
import java.io.File;  
import java.io.FileWriter;

PImage loadedImage;
PImage outputImage;

public void openFile(){
    JFileChooser fileChooser = new JFileChooser();
    int result = fileChooser.showOpenDialog(null);
    if (result == JFileChooser.APPROVE_OPTION) {
      File selectedFile = fileChooser.getSelectedFile();
      String Path = selectedFile.getPath();
      Path = Path.replaceAll("\\\\", "/");;
      loadedImage = loadImage(Path);
      outputImage = loadedImage.copy();
    }   
}


public void closeFile(){
  
  JFileChooser fileChooser = new JFileChooser();
  fileChooser.setDialogTitle("Specify a file to save");   
   
  int userSelection = fileChooser.showSaveDialog(null);
   
  if (userSelection == JFileChooser.APPROVE_OPTION) {
    outputImage.save(fileChooser.getSelectedFile() + ".png");
  }
}
