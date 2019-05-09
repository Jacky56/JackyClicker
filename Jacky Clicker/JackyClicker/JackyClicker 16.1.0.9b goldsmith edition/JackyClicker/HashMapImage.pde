//this function uses recursion
//puts all .png files into memory

//your hashmaps cos i cant remember the index array
HashMap<String, PImage> LoadAllImage = new HashMap<String,PImage>();
ArrayList<File> ListImages;

//the function which loads png files
void GetPath(String GetPath, ArrayList<File> GetFile) {
  //find the folder
  File PathDir = new File(GetPath);
  //list the content as static array in the folder 
  File[]ListFiles = PathDir.listFiles();
  //checks each file/folder
  for(File file : ListFiles) {
    //check if that object is a file
    if(file.isFile()) {
      //check if its a .png
      if(file.getName().matches(".*.png.*")) {
        //puts that .png file into hashmap
        LoadAllImage.put(file.getName(),loadImage(file.getPath()));
      }
      //if the object is a folder, it will go into that folder for checking
    } else if(file.isDirectory()) {
      GetPath(file.getPath(), GetFile);
    }
  }
}