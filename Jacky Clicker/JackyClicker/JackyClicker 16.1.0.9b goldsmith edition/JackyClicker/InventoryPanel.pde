//Inventory panel that shows the inventory of the player object
protected class InventoryPanel extends GeneralPanel {
  
  private ScrollBar ButtonBody;
  
  Button ClearItem;
  Button UpgradeItem;

  
  
  private Player pl;
  
  
  private float SlotOrder;
  //...
  protected InventoryPanel(float x,float y,float sizeX,float sizeY,color background,float padding, float curve,color lineColor,float lineSize,Player pl) {
    super( x, y, sizeX, sizeY, background, padding, curve, lineColor, lineSize);
    
    this.pl = pl;
    
    //SleepButton = new Button("Refresh","stall time at the Inn, removing all recruits and meals from the Inn.",x+ padding, y + sizeY - padding - 60,sizeX-padding*2,35,3,color(150),color(255),15,color(100),3);
    
    
    SlotOrder = (sizeX - padding*2)/3;
    ButtonBody = new ScrollBar(SlotOrder*ceil(pl.Inventory.length/3.), SlotOrder*4,x+sizeX,15,8,sizeY,color(0,150),0,color(255),1);
    
    
    SlotOrder = (sizeX - padding*2)/3;
    
    ClearItem = new Button("Clear","Destroys all Items that are not equipped.",x+ padding,y+ padding + SlotOrder*4,SlotOrder*1.4,SlotOrder*2/3,3,color(150,0,0),color(255),15,color(100,0,0),3);
    UpgradeItem = new Button("Upgrade","Upgrade Your Item's stats. (Currently just for show)",x + sizeX - padding - SlotOrder*1.5,y+ padding + SlotOrder*4,SlotOrder*1.4,SlotOrder*2/3,3,color(150),color(255),15,color(100),3);
    
    
    
    //***enable this if you want to test the item mechanic of the game***
    
    //for(int n = 0; n < pl.Inventory.length; n++) {
    //String type = "";
    //switch(round(random(6))) {
    //  case 0:
    //  type = "head";
    //  break;
    //  case 1:
    //  type = "body";
    //  break;
    //  case 2:
    //  type = "boot";
    //  break;
    //  case 3:
    //  type = "weapon";
    //  break;
    //  case 4:
    //  type = "glove";
    //  break;
    //  case 5:
    //  type = "neck";
    //  break;
    //  case 6:
    //  type = "ring";
    //  break;
        
    //}

    //if(random(100) > 0) {
    //  if(pl.Inventory[n] == null) {
    //    pl.Inventory[n] = new Equipment("Head of Grand Master","Some Description "+type+n,type+".png",color(150,25,150),type,56,500,1.05,x + padding + SlotOrder*(n%3),y + sizeY - 20 - (SlotOrder * 4) - padding + SlotOrder*floor(n/3),SlotOrder-4,SlotOrder-4);
    //  }
    //} else {
    // // eq[n] = new Equipment(EqNull);
    //}
    //}
    
    
  }
  
    //...
  private void drawHead() {
    if(pl.HeadSlot != null) {
      pl.HeadSlot.draw();
    } else {
      stroke(255);
      fill(0,150);
      strokeWeight(1);
      rect(x + padding + SlotOrder,y + padding + 30,SlotOrder-4,SlotOrder-4,2);      
    }
  }
  //...  
  private void drawBody() {
    if(pl.BodySlot != null) {
      pl.BodySlot.draw();
    } else {
      stroke(255);
      fill(0,150);
      strokeWeight(1);
      rect(x + padding + SlotOrder,y + padding + 30 + SlotOrder,SlotOrder-4,SlotOrder-4,2);      
    }
  }  
  //...  
  private void drawBoot() {
    if(pl.BootSlot != null) {
      pl.BootSlot.draw();
    } else {
      stroke(255);
      fill(0,150);
      strokeWeight(1);
      rect(x + padding + SlotOrder,y +  padding + 30 + SlotOrder*2,SlotOrder-4,SlotOrder-4,2);      
    }
  }
  //...  
  private void drawWeapon() {
    if(pl.WeaponSlot != null) {
      pl.WeaponSlot.draw();
    } else {
      stroke(255);
      fill(0,150);
      strokeWeight(1);
      rect(x + padding,y  + padding + 30 + SlotOrder,SlotOrder-4,SlotOrder-4,2);      
    }
  }
  //...  
  private void drawGlove() {
    if(pl.GloveSlot != null) {
      pl.GloveSlot.draw();
    } else {
      stroke(255);
      fill(0,150);
      strokeWeight(1);
      rect(x + padding,y + padding + 30 + SlotOrder*2,SlotOrder-4,SlotOrder-4,2);      
    }
  }
  //...  
  private void drawNeck() {
    if(pl.NeckSlot != null) {
      pl.NeckSlot.draw();
    } else {
      stroke(255);
      fill(0,150);
      strokeWeight(1);
      rect(x + padding + SlotOrder*2,y + padding + 30,SlotOrder-4,SlotOrder-4,2);      
    }
  }
  //...  
  private void drawRing() {
    if(pl.RingSlot != null) {
      pl.RingSlot.draw();
    } else {
      stroke(255);
      fill(0,150);
      strokeWeight(1);
      rect(x + padding + SlotOrder*2,y + padding + 30 + SlotOrder,SlotOrder-4,SlotOrder-4,2);      
    }
  }    
  //...  
  protected void draw(Player pl) {
    if(show) {
      super.draw();
      fill(255);
      textSize(16);
      textAlign(TOP,TOP);
      text("Inventory",x+padding,y+padding);     
      stroke(120);
      strokeWeight(2);
      fill(180);
      rect(x+sizeX -padding -13,y+sizeY-padding -15,13,13,0,20,0,20);
      fill(200);
      textSize(13);
      textAlign(TOP,BOTTOM);
      text("Zeny",x+padding,y+sizeY-padding);
      text(pl.Zeny+"",x+sizeX - padding - textWidth(pl.Zeny+"") - 15,y+sizeY - padding);
      
      ButtonBody.draw();
      ClearItem.draw();
      UpgradeItem.draw();
      drawHead();
      drawBody();
      drawBoot();
      drawGlove();
      drawWeapon();
      drawNeck();
      drawRing();
      
      
      
      clip(x,y + sizeY - 20 - (SlotOrder * 4) - padding, sizeX,SlotOrder*4);
      for(int n = 0; n < pl.Inventory.length; n++) {
        
        if(pl.Inventory[n] != null) {
          pl.Inventory[n].ItemAsButton.UpdatePosition(pl.Inventory[n].x,pl.Inventory[n].y +ButtonBody.contentMove());
          pl.Inventory[n].draw();
          
        } else { 
          stroke(255);
          fill(0,150);
          strokeWeight(1);
          rect(x + padding + SlotOrder*(n%3),y + sizeY - 20 - (SlotOrder * 4) - padding + SlotOrder*floor(n/3) +ButtonBody.contentMove(),SlotOrder-4,SlotOrder-4,2);
        }
      }
      noClip();
      
    }
  }
  
  //...  
  protected void ActionEvent() {
    if(show) {
      for(int n = 0; n < pl.Inventory.length; n++) {
        if(pl.Inventory[n] != null) {
          if(pl.Inventory[n].ItemAsButton.wasClicked) {
            pl.Inventory[n].ItemAsButton.wasClicked = false;
            CheckItemType(n);
          }
        }
      }
      
      if(ClearItem.wasClicked) {
        ClearItem.wasClicked = false;
        for(int n = 0; n < pl.Inventory.length; n++) {
          if(pl.Inventory[n] != null) {
            pl.Inventory[n] = null;
          }
        }
      }
      
      
      Unequip(pl.HeadSlot);
      Unequip(pl.BodySlot);
      Unequip(pl.BootSlot);
      Unequip(pl.WeaponSlot);
      Unequip(pl.GloveSlot);
      Unequip(pl.RingSlot);
      Unequip(pl.NeckSlot);
    }
  }
  
  //...  
  private void CheckItemType(int n) {
    
    if(pl.Inventory[n].SlotType.equalsIgnoreCase("head")) {
      Equipment StoreEquipped = null;
      
      if(pl.HeadSlot != null) {
        StoreEquipped = new Equipment(pl.HeadSlot);
      }

      pl.HeadSlot = new Equipment(pl.Inventory[n]);
      pl.HeadSlot.UpdatePosition(x + padding + SlotOrder,y +  padding + 30 );
      pl.HeadSlot.Equipped = true;
      
      if(StoreEquipped != null) {
        pl.Inventory[n] = new Equipment(StoreEquipped);
        pl.Inventory[n].x = x + padding + SlotOrder*(n%3);
        pl.Inventory[n].y = y + sizeY - 20 - (SlotOrder * 4) - padding + SlotOrder*floor(n/3);
        pl.Inventory[n].Equipped = false;
      } else {
        pl.Inventory[n] = null;
      }
    } else if(pl.Inventory[n].SlotType.equalsIgnoreCase("body")) {
      Equipment StoreEquipped = null;
      
      if(pl.BodySlot != null) {
        StoreEquipped = new Equipment(pl.BodySlot);
      }
      
      pl.BodySlot = new Equipment(pl.Inventory[n]);      
      pl.BodySlot.UpdatePosition(x + padding + SlotOrder,y +  padding + 30 + SlotOrder);
      pl.BodySlot.Equipped = true;
      
      
      if(StoreEquipped != null) {
        pl.Inventory[n] = new Equipment(StoreEquipped);
        pl.Inventory[n].x = x + padding + SlotOrder*(n%3);
        pl.Inventory[n].y = y + sizeY - 20 - (SlotOrder * 4) - padding + SlotOrder*floor(n/3);
        pl.Inventory[n].Equipped = false;
      } else {
        pl.Inventory[n] = null;
      }
    } else if(pl.Inventory[n].SlotType.equalsIgnoreCase("boot")) {
      Equipment StoreEquipped = null;
      
      if(pl.BootSlot != null) {
        StoreEquipped = new Equipment(pl.BootSlot);
      }
      
      pl.BootSlot = new Equipment(pl.Inventory[n]);      
      pl.BootSlot.UpdatePosition(x + padding + SlotOrder,y +  padding + 30 + SlotOrder*2);
      pl.BootSlot.Equipped = true;
      
      
      if(StoreEquipped != null) {
        pl.Inventory[n] = new Equipment(StoreEquipped);
        pl.Inventory[n].x = x + padding + SlotOrder*(n%3);
        pl.Inventory[n].y = y + sizeY - 20 - (SlotOrder * 4) - padding + SlotOrder*floor(n/3);
        pl.Inventory[n].Equipped = false;
      } else {
        pl.Inventory[n] = null;
      }
    } else if(pl.Inventory[n].SlotType.equalsIgnoreCase("weapon")) {
      Equipment StoreEquipped = null;
      
      if(pl.WeaponSlot != null) {
        StoreEquipped = new Equipment(pl.WeaponSlot);
      }
      
      pl.WeaponSlot = new Equipment(pl.Inventory[n]);      
      pl.WeaponSlot.UpdatePosition(x + padding,y +  padding + 30 + SlotOrder);
      pl.WeaponSlot.Equipped = true;
      
      
      if(StoreEquipped != null) {
        pl.Inventory[n] = new Equipment(StoreEquipped);
        pl.Inventory[n].x = x + padding + SlotOrder*(n%3);
        pl.Inventory[n].y = y + sizeY - 20 - (SlotOrder * 4) - padding + SlotOrder*floor(n/3);
        pl.Inventory[n].Equipped = false;
      } else {
        pl.Inventory[n] = null;
      }
    } else if(pl.Inventory[n].SlotType.equalsIgnoreCase("glove")) {
      Equipment StoreEquipped = null;
      
      if(pl.GloveSlot != null) {
        StoreEquipped = new Equipment(pl.GloveSlot);
      }
      
      pl.GloveSlot = new Equipment(pl.Inventory[n]);      
      pl.GloveSlot.UpdatePosition(x + padding,y +  padding + 30 + SlotOrder*2);
      pl.GloveSlot.Equipped = true;
      
      
      if(StoreEquipped != null) {
        pl.Inventory[n] = new Equipment(StoreEquipped);
        pl.Inventory[n].x = x + padding + SlotOrder*(n%3);
        pl.Inventory[n].y = y + sizeY - 20 - (SlotOrder * 4) - padding + SlotOrder*floor(n/3);
        pl.Inventory[n].Equipped = false;
      } else {
        pl.Inventory[n] = null;
      }
    } else if(pl.Inventory[n].SlotType.equalsIgnoreCase("neck")) {
      Equipment StoreEquipped = null;
      
      if(pl.NeckSlot != null) {
        StoreEquipped = new Equipment(pl.NeckSlot);
      }
      
      pl.NeckSlot = new Equipment(pl.Inventory[n]);      
      pl.NeckSlot.UpdatePosition(x + padding + SlotOrder*2,y +  padding + 30);
      pl.NeckSlot.Equipped = true;
      
      
      if(StoreEquipped != null) {
        pl.Inventory[n] = new Equipment(StoreEquipped);
        pl.Inventory[n].x = x + padding + SlotOrder*(n%3);
        pl.Inventory[n].y = y + sizeY - 20 - (SlotOrder * 4) - padding + SlotOrder*floor(n/3);
        pl.Inventory[n].Equipped = false;
      } else {
        pl.Inventory[n] = null;
      }
    } else if(pl.Inventory[n].SlotType.equalsIgnoreCase("ring")) {
      Equipment StoreEquipped = null;
      
      if(pl.RingSlot != null) {
        StoreEquipped = new Equipment(pl.RingSlot);
      }
      
      pl.RingSlot = new Equipment(pl.Inventory[n]);      
      pl.RingSlot.UpdatePosition(x + padding + SlotOrder*2,y +  padding + 30 + SlotOrder);
      pl.RingSlot.Equipped = true;
      
      
      if(StoreEquipped != null) {
        pl.Inventory[n] = new Equipment(StoreEquipped);
        pl.Inventory[n].x = x + padding + SlotOrder*(n%3);
        pl.Inventory[n].y = y + sizeY - 20 - (SlotOrder * 4) - padding + SlotOrder*floor(n/3);
        pl.Inventory[n].Equipped = false;
      } else {
        pl.Inventory[n] = null;
      }
    }     
    pl.getItemStats();
  }
  
  
  
  
  //...  
  private void Unequip(Equipment Slot) {
    if(Slot != null) {
      if(Slot.ItemAsButton.wasClicked) {
        Slot.ItemAsButton.wasClicked = false;
        for(int n = 0; n < pl.Inventory.length; n++) {
          if(pl.Inventory[n] == null) {
            pl.Inventory[n] = new Equipment(Slot);
            pl.Inventory[n].x = x + padding + SlotOrder*(n%3);
            pl.Inventory[n].y = y + sizeY - 20 - (SlotOrder * 4) - padding + SlotOrder*floor(n/3);
            pl.Inventory[n].Equipped = false;
            
            
            if(Slot == pl.HeadSlot) {
              pl.HeadSlot = null;
            }            
            if(Slot == pl.BodySlot) {
              pl.BodySlot = null;
            }
            if(Slot == pl.GloveSlot) {
              pl.GloveSlot = null;
            }
            if(Slot == pl.BootSlot) {
              pl.BootSlot = null;
            }
            if(Slot == pl.WeaponSlot) {
              pl.WeaponSlot = null;
            }
            if(Slot == pl.NeckSlot) {
              pl.NeckSlot = null;
            }
            if(Slot == pl.RingSlot) {
              pl.RingSlot = null;
            }
      
            break;
          }
        }
      }
      pl.getItemStats();
    }
  }
  
  
  
  //...  
  protected void HoverEvent() {
    if(show) {
      ClearItem.hoverInfo.draw();
      UpgradeItem.hoverInfo.draw();
      if(pl.HeadSlot != null) {
        pl.HeadSlot.HoverEvent();
      }
      if(pl.BodySlot != null) {
        pl.BodySlot.HoverEvent();
      }      
      if(pl.BootSlot != null) {
        pl.BootSlot.HoverEvent();
      }
      if(pl.WeaponSlot != null) {
        pl.WeaponSlot.HoverEvent();
      }
      if(pl.GloveSlot != null) {
        pl.GloveSlot.HoverEvent();
      }      
      if(pl.RingSlot != null) {
        pl.RingSlot.HoverEvent();
      }
      if(pl.NeckSlot != null) {
        pl.NeckSlot.HoverEvent();
      }
      
      if(mouseX > x && mouseX < x+sizeX &&
      mouseY > y + sizeY - 20 - (SlotOrder * 4) - padding 
      && mouseY < y + sizeY - 20 - padding) {
        for(int n = 0; n < pl.Inventory.length; n++) {
          if(pl.Inventory[n] != null) {
            pl.Inventory[n].HoverEvent();
            
          }
        }
      }
    }
  }
  //...  
  public void mousePressed() {
    if(show) {
      ButtonBody.mousePressed();
      ClearItem.mousePressed();
      UpgradeItem.mousePressed();
      
      if(pl.HeadSlot != null) {
        pl.HeadSlot.ItemAsButton.mousePressed();
      }
      if(pl.BodySlot != null) {
        pl.BodySlot.ItemAsButton.mousePressed();
      }      
      if(pl.GloveSlot != null) {
        pl.GloveSlot.ItemAsButton.mousePressed();
      }      
      if(pl.BootSlot != null) {
        pl.BootSlot.ItemAsButton.mousePressed();
      }      
      if(pl.WeaponSlot != null) {
        pl.WeaponSlot.ItemAsButton.mousePressed();
      }      
      if(pl.NeckSlot != null) {
        pl.NeckSlot.ItemAsButton.mousePressed();
      }      
      if(pl.RingSlot != null) {
        pl.RingSlot.ItemAsButton.mousePressed();
      }          
      
      if(mouseX > x && mouseX < x+sizeX &&
      mouseY > y + sizeY - 20 - (SlotOrder * 4) - padding 
      && mouseY < y + sizeY - 20 - padding) {
        for(int n = 0; n < pl.Inventory.length; n++) {
          if(pl.Inventory[n] != null) {
            pl.Inventory[n].ItemAsButton.mousePressed();
          }
        }
      }         

    }
  }
  //...  
  public void mouseReleased() {
    if(show) {
      ButtonBody.mouseReleased();
      ClearItem.mouseReleased();
      UpgradeItem.mouseReleased();
      
      if(pl.HeadSlot != null) {
        pl.HeadSlot.ItemAsButton.mouseReleased();
      }
      if(pl.BodySlot != null) {
        pl.BodySlot.ItemAsButton.mouseReleased();
      }      
      if(pl.GloveSlot != null) {
        pl.GloveSlot.ItemAsButton.mouseReleased();
      }      
      if(pl.BootSlot != null) {
        pl.BootSlot.ItemAsButton.mouseReleased();
      }      
      if(pl.WeaponSlot != null) {
        pl.WeaponSlot.ItemAsButton.mouseReleased();
      }
      if(pl.NeckSlot != null) {
        pl.NeckSlot.ItemAsButton.mouseReleased();
      }      
      if(pl.RingSlot != null) {
        pl.RingSlot.ItemAsButton.mouseReleased();
      }   
      
      if(mouseX > x && mouseX < x+sizeX &&
      mouseY > y + sizeY - 20 - (SlotOrder * 4) - padding 
      && mouseY < y + sizeY - 20 - padding) {
        for(int n = 0; n < pl.Inventory.length; n++) {
          if(pl.Inventory[n] != null) {
            pl.Inventory[n].ItemAsButton.mouseReleased();
          }
        }
      }      
      
    }
  }
  //...  
  public void mouseWheel(MouseEvent event) {
    if(show) {
      ButtonBody.mouseWheel(event,x,y,sizeX+padding,sizeY);
    }
  }
  
  
}