import javax.swing.JFileChooser;
import java.io.File;  

PImage loadedImage;

public void openFile(){
    JFileChooser fileChooser = new JFileChooser();
    int result = fileChooser.showOpenDialog(null);
    if (result == JFileChooser.APPROVE_OPTION) {
      File selectedFile = fileChooser.getSelectedFile();
      String Path = selectedFile.getPath();
      Path = Path.replaceAll("\\\\", "/");;
      loadedImage = loadImage(Path);
    }   
}
