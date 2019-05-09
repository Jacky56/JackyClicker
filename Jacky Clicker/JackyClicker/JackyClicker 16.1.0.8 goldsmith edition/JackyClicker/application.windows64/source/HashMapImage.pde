//the hashmap
HashMap<String, PImage> LoadAllImage = new HashMap<String,PImage>();
ArrayList<File> ListImages;

//used to find all the files with .png in the data path and point it to memory
void GetPath(String GetPath, ArrayList<File> GetFile) {
  File PathDir = new File(GetPath);
  File[]ListFiles = PathDir.listFiles();
  for(File file : ListFiles) {

    if(file.isFile()) {
      //GetFile.add(file);
      if(file.getName().matches(".*.png.*")) {

        LoadAllImage.put(file.getName(),loadImage(file.getPath()));
      }
    } else if(file.isDirectory()) {
      GetPath(file.getPath(), GetFile);
    }
  }
}