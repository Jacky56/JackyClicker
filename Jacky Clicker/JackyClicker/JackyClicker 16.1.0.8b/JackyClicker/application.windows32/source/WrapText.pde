//Wrap text
//note:
//this doesnt return how many times it had wrapped
//best used in textAlign(TOP,TOP);

//gets wrapped version
String wrapText(String text,float textSize,float contentWidth) {
  String textConstructor = "";
  String[] word = text.split("\\s+");
  String tempText = "";
  textSize(textSize);
  
  for(int n = 0;n < word.length;n++) {
    if(textWidth(tempText+word[n]) > contentWidth) {
      textConstructor += "\n";
      tempText = "";
    }
    tempText += word[n] + " ";
    textConstructor += word[n] + " ";
  }
  
  return textConstructor;
}

//gets the number of wrap// \n in the text
int wrapNumber(String text,float textSize,float contentWidth) {
  int line = 1;
  String[] word = text.split("\\s+");
  String tempText = "";
  textSize(textSize);
 
  for(int n = 0;n < word.length;n++) {
    if(textWidth(tempText+word[n]) > contentWidth) {
      tempText = "";
      line++;
    }
    tempText += word[n] + " ";
  }
  
  return line;
}