// AdventureGame Sample / Written by n_ryota

// adventure_initial_variables
PImage bg, chara;       
int bgAlpha = 0;        
int charaAlpha = 0;
String[] scenario;
int scenarioCur = 0;
String message = "";
int messageCur = 0;
boolean prevMousePressed = false;

// fade_variables
PImage imgA, imgB, imgC;
float transparency;
float targetTransparency;
boolean isFadeAtoB;
boolean isFadeBtoC;
boolean  isFadeCompletedAtoB;
boolean  isFadeCompletedBtoC;
boolean ischeckerAtoB;
boolean ischeckerBtoC;
int currentTime;
int fadeCompletedTime;
float easing;
import ddf.minim.*;
Minim minim;
AudioPlayer player;

// setup
void setup() {
  size(640, 480);
  textFont(createFont("MS PMincho", 20)); //String[] fontList = PFont.list(); println(fontList);
  scenario = loadStrings("scenario.txt");
  
  // setup_fade
  minim = new Minim(this);
  player = minim.loadFile("healing.mp3");
  player.play();
  isFadeAtoB = true;
  isFadeBtoC = false;
  transparency = 0;
  targetTransparency = 255;
  isFadeCompletedAtoB = false;
  isFadeCompletedBtoC = false;
  ischeckerAtoB = false;
  ischeckerBtoC = false;
  easing = 0.002;
}

// 毎フレームの進行と描画
void draw() {

  if(bgAlpha<255) bgAlpha += 20;
  if(bg!=null) {
    tint(255, bgAlpha);
    image(bg, 0, 0);
  } else background(0, bgAlpha);
  

  if(chara!=null) {
    if(charaAlpha<255) charaAlpha += 20;
    tint(255, charaAlpha);
    image(chara, 0, 0);
  }
  
  int boardH = 80;
  int boardY = height-boardH;
  noStroke();
  fill(0, 0, 0, 200);
  rect(0, boardY, width, boardH);
  
  if(message.length()>0) {
    fill(255);
    textAlign(LEFT);
    text(message.substring(0, messageCur), 20, boardY+15, width-80, 20*2+20);
    if(messageCur<message.length()) messageCur++;
    else {

      fill(255, sin(radians(millis()/2)) * 255);
      ellipse(width-30, height-30, 20, 20);
      if(mousePressed && !prevMousePressed) {
        message = ""; messageCur = 0;
      }
    }
  }

 if(messageCur<=0) {
    // 空行に出くわすまで連続してシナリオコマンドを処理
    for(;;) {
      if(scenarioCur>=scenario.length) {
        exit(); break; // 終了
      }
      println(nf(scenarioCur, 4) + ": " + scenario[scenarioCur]); // for debug
      if(doCommand(scenario[scenarioCur++])) {
        println("----"); // for debug
        break;
      }
    }
  }
  prevMousePressed = mousePressed;
}


boolean doCommand(String commandStr) {
  if(commandStr.length()<=0) {
    return true; // 空行のときだけtrueを返す
  } else if(commandStr.charAt(0)=='>') {
    String[] args = splitTokens(commandStr);
    if(args.length>0) {
      if(">event".equals(args[0])) {
        imgA = loadImage("washi1.jpg");
        imgB = loadImage("washi2.jpg");
        imgC = loadImage("washi3.jpg");
        bg = imgA;
        if (bg.width != width || bg.height != height) bg.resize(width, height);
        if(targetTransparency - transparency <= 1.0) {
          currentTime = millis();
          if(isFadeAtoB){
            if(!isFadeCompletedAtoB){
              isFadeCompletedAtoB = true;
              fadeCompletedTime = currentTime;
            }
            else if(isFadeCompletedAtoB) {
              if(currentTime - fadeCompletedTime >= 0) {
                transparency = 0;
                isFadeAtoB = !isFadeAtoB;
                isFadeBtoC = !isFadeBtoC;
              }
            }
          }
          else{
            if(!isFadeCompletedBtoC){
              isFadeCompletedBtoC = true;
              fadeCompletedTime = currentTime;
            }
            else if(isFadeCompletedBtoC) {
              if(currentTime - fadeCompletedTime >= 0) {
                transparency = 0;
                isFadeBtoC = !isFadeBtoC;
              }
            }
          }
          
      
        }
      
        if(isFadeAtoB) {
          noTint();
          image(imgA, 0, 0);
          tint(255, transparency);
          image(imgB, 0, 0);
        } 
        /*
        else {
          noTint();
          image(imgB, 0, 0);
          tint(255, transparency);
          image(imgA, 0, 0);
        }*/
        
        
        if(isFadeBtoC) {
          noTint();
          image(imgB, 0, 0);
          tint(255, transparency);
          image(imgC, 0, 0);
        } else {
          /*noTint();
          image(imgC, 0, 0);
          tint(255, transparency);
          image(imgB, 0, 0);
          */
        }
        
        if(transparency<200){
          transparency += (targetTransparency - transparency) * easing;
        }
        else{
          transparency += 500*easing;
        }
      }  
      if(">image".equals(args[0])) {
        charaAlpha = 0;
        if(args.length>1) chara = loadImage(args[1]);
        else chara = null;
      } else if(">bg".equals(args[0])) {
        if(args.length>1) {
          bgAlpha = 0;
          bg = loadImage(args[1]);
          if (bg.width != width || bg.height != height) bg.resize(width, height);
        } else bg = null;
      }
    }
  } else {
    if(message.length()>0) message += "\n";
    message += commandStr;
  }
  return false;
}