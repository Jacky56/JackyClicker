//Wrap text
//note:
//this doesnt return how many times it had wrapped
//best used in textAlign(TOP,TOP);

//gets wrapped version
String wrapText(String text,float textSize,float contentWidth) {
  if( text != null) {
    String textConstructor = "";
    String[] word = text.split("\\s+");
    String tempText = "";
    textSize(textSize);
    if(word.length > 1) {
    
    for(int n = 0;n < word.length;n++) {
      if(textWidth(tempText+word[n]) > contentWidth || word[n].equals("|")) {
        if(n != 0) {
          textConstructor += "\n";
        }
        
        tempText = "";
      }
      if(word[n].equals("|") == false) {
        tempText += word[n] + " ";
        textConstructor += word[n] + " ";
      }
    }
    
      return textConstructor;
    } else {
      return text;
    }
  } else {
    return text;
  }
}

//gets the number of wrap// \n in the text
int wrapNumber(String text,float textSize,float contentWidth) {
  if(text != null) {
    int line = 1;
    String[] word = text.split("\\s+");
    String tempText = "";
    textSize(textSize);
    
    for(int n = 0;n < word.length;n++) {
      if(textWidth(tempText+word[n]) > contentWidth || word[n].equals("|")) {
        tempText = "";
        line++;
      }
      if(word[n].equals("|") == false) {
        tempText += word[n] + " ";
      }
    }
    
    return line;
  } else {
    return 0;
  }
}