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
boolean isEvent = false;
int currentTime;
int fadeCompletedTime;
float easing;
import ddf.minim.*;
Minim minim;
AudioPlayer player;

// ren_variables
float transparencyAtoB;
float transparencyBtoC;
boolean isCompletedAnswer;
boolean isInAlternative_1;
boolean isInAlternative_2;
boolean isInAlternative_3;
boolean isInAlternative_4;
boolean isAlphawaveFirstLevel;
boolean isAlphawaveSecondLevel;
int timeCounter;
int limitTime;
int RectSize;
int CorrectAnswer;
int choose_answer;
float alphawave;
float AlphawaveFirstLevel;
float AlphawaveSecondLevel;
float TransparencyError;
String Alternative_1;
String Alternative_2;
String Alternative_3;
String Alternative_4;


// setup
void setup() {
  size(640, 480);
  textFont(createFont("MS PMincho", 20)); //String[] fontList = PFont.list(); println(fontList);
  scenario = loadStrings("scenario.txt");

  // setup_fade
  minim = new Minim(this);
  player = minim.loadFile("healing.mp3");
  player.play();
  isFadeAtoB = false;
  isFadeBtoC = false;
  transparency = 0;
  targetTransparency = 255;
  isFadeCompletedAtoB = false;
  isFadeCompletedBtoC = false;
  ischeckerAtoB = false;
  ischeckerBtoC = false;
  easing = 0.005;
  
  //setup_ren
  transparencyAtoB = 0;
  transparencyBtoC = 0;
  isCompletedAnswer = false;
  isInAlternative_1 = false;
  isInAlternative_2 = false;
  isInAlternative_3 = false;
  isInAlternative_4 = false;
  isAlphawaveFirstLevel = false;
  isAlphawaveSecondLevel = false;
  alphawave = 0;
  AlphawaveFirstLevel = 0.2;         // α波の基準値
  AlphawaveSecondLevel = 0.3;
  TransparencyError = 4.0;           //  transparencyの値の許容誤差
  timeCounter = 0;
  limitTime = 60;                    //  制限時間
  RectSize = 40;
  Alternative_1 = "おとめ座";
  Alternative_2 = "さそり座";
  Alternative_3 = "おうし座";
  Alternative_4 = "やぎ座";
  CorrectAnswer = 4;                  //正解の選択肢番号
  choose_answer = 0; 
}

void settings() {
  imgA = loadImage("washi1.jpg");
  size(imgA.width, imgA.height+80);   //RectSizeを変更したらここも変える
}

// 毎フレームの進行と描画
void draw(){
  
   // α波の感知
 
  if(limitTime >45){
    alphawave = 0.25;
  }
  else if(limitTime > 40){
    alphawave = 0.35;
  }
  else if(limitTime > 30){
    alphawave = 0.15;
  }
  else if(limitTime > 20){
    alphawave = 0.35;
  }
  else if(limitTime > 9){
    alphawave = 0.25;
  }
  else{
    alphawave = 0.15;
  }

  //if(bgAlpha<255) bgAlpha += 20;
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
  
  if(isEvent){
      // 3枚の画像の推移(A>B>C)
  
  background(255);
    if(isAlphawaveFirstLevel){
      if(!isFadeCompletedAtoB){
      isFadeAtoB = true;
      }
      if(targetTransparency - transparencyAtoB <= TransparencyError) {
        currentTime = millis();
          if(!isFadeCompletedAtoB){
            isFadeCompletedAtoB = true;
          }
          else{
            if(isAlphawaveSecondLevel){
              if(!isFadeCompletedBtoC){
                isFadeAtoB = false;
                isFadeBtoC = true;
              }
              if(targetTransparency - transparencyBtoC <= TransparencyError){
                if(!isFadeCompletedBtoC){
                  isFadeCompletedBtoC = true;             
                } 
              }
            }
            else{
              if(isFadeCompletedBtoC){
                isFadeCompletedBtoC = !isFadeCompletedBtoC;
                isFadeBtoC = true;
              }
            }
          }
      }
    }
    else{
      if(isFadeCompletedBtoC){
        isFadeCompletedBtoC = false;
        isFadeBtoC = true;
      }
      if(transparencyBtoC <= TransparencyError){
        isFadeBtoC = false;
        if(isFadeCompletedAtoB){
          isFadeCompletedAtoB = !isFadeCompletedAtoB;
          isFadeAtoB = true;
        }
      }  
    }
  

  if(isFadeAtoB) {
    noTint();
    image(imgA, 0, 0);
    tint(255, transparencyAtoB);
    image(imgB, 0, 0);
  }   
  
  if(isFadeBtoC) {
    noTint();
    image(imgB, 0, 0);
    tint(255, transparencyBtoC);
    image(imgC, 0, 0);
  } 
  
  System.out.print(transparencyAtoB);
  System.out.print(isFadeAtoB);
  System.out.print(isFadeBtoC);
  System.out.print(isFadeCompletedAtoB);
  System.out.print(isFadeCompletedBtoC);
  System.out.println(transparencyBtoC);
  
  
  // α波の強さが基準に達しているかの判定
  
  if(alphawave >= AlphawaveFirstLevel){
    isAlphawaveFirstLevel = true;
  }
  else{
    isAlphawaveFirstLevel = false;
  }
  if(alphawave >= AlphawaveSecondLevel){
    isAlphawaveSecondLevel = true;
  }
  else{
    isAlphawaveSecondLevel = false;
  }
  
  
  // α波の強さの評価
   
  
  if(transparencyAtoB >= 0-TransparencyError && transparencyAtoB <= targetTransparency+TransparencyError){
    if(transparencyBtoC >= 0-TransparencyError && transparencyBtoC <= targetTransparency+TransparencyError){
      if(isAlphawaveFirstLevel){
        if(isAlphawaveSecondLevel){
          if(isFadeBtoC){
            if(transparencyBtoC<200){
              transparencyBtoC += (targetTransparency - transparencyBtoC) * easing;
            }
            else{
              if(transparencyBtoC + 100*easing <= targetTransparency+TransparencyError/2){
                transparencyBtoC += 100*easing;
              }
            }
          }
          if(isFadeAtoB){
            if(transparencyAtoB<200){
              transparencyAtoB += (targetTransparency - transparencyAtoB) * easing;
            }
            else{
              if(transparencyAtoB + 100*easing <= targetTransparency+TransparencyError/2){
                transparencyAtoB += 100*easing;
              }
            }
          }
        }
        else{
          if(isFadeAtoB){
            if(transparencyAtoB<200){
              transparencyAtoB += (targetTransparency - transparencyAtoB) * easing;
            }
            else{
              if(transparencyAtoB + 100*easing <= targetTransparency+TransparencyError/2){
                transparencyAtoB += 100*easing;
              }  
            }
          }
          if(isFadeBtoC){
            if(transparencyBtoC>50){
              transparencyBtoC -= transparencyBtoC * easing;
            }
            else{
              if(transparencyBtoC - 100*easing >= TransparencyError/2){
              transparencyBtoC -= 100*easing;
              System.out.println("JJJJ");
              }
            }
          }
        }
      }
      else{
        if(isFadeAtoB){
          if(transparencyAtoB>50){
            transparencyAtoB -= transparencyAtoB * easing;
          }
          else{
            if(transparencyAtoB - 100*easing >= TransparencyError/2){
              transparencyAtoB -= 100*easing;
            }
          }
        }
        if(isFadeBtoC){
          if(transparencyBtoC>50){
              transparencyBtoC -= transparencyBtoC * easing;
          }
          else{
            if(transparencyBtoC - 100*easing >= TransparencyError/2){
              transparencyBtoC -= 100*easing;
            }
          }
        }
      }
    }
  }
  
  
  // 制限時間
 
  timeCounter += 1;
  
  if(timeCounter%60==0){
    limitTime -= 1;
  }
  
  if(!isCompletedAnswer){
    fill(255,0,0);     //#030303  
    textSize(50);
    text(nf(limitTime, 2), 100, 50);    
  }
  
  if(limitTime < 0){
    fill(255,0,0);
    text("不正解",100,100);
    isCompletedAnswer = true;
  }
    
  //選択ボックスの設定
  
  if(mouseX > 0 && mouseX < imgA.width*0.5 && mouseY > imgA.height && mouseY < imgA.height+RectSize){
    isInAlternative_1 = true;
  }
  else{
    isInAlternative_1 = false;
  }
  if(mouseX > imgA.width*0.5 && mouseX < imgA.width && mouseY > imgA.height && mouseY < imgA.height+RectSize){
    isInAlternative_2 = true;
  }
  else{
    isInAlternative_2 = false;
  }
  if(mouseX > 0 && mouseX < imgA.width*0.5 && mouseY > imgA.height+RectSize && mouseY < imgA.height+2*RectSize){
    isInAlternative_3 = true;
  }
  else{
    isInAlternative_3 = false;
  }
  if(mouseX > imgA.width*0.5 && mouseX < imgA.width && mouseY > imgA.height+RectSize && mouseY < imgA.height+2*RectSize){
    isInAlternative_4 = true;
  }
  else{
    isInAlternative_4 = false;
  }
    
   

    
    
    
    
  // 選択ボックスの表示
      
  stroke(0);
  fill(255);
  rect(0,imgA.height,imgA.width/2.0,RectSize);
  rect(imgA.width/2.0,imgA.height,imgA.width/2.0,RectSize);
  rect(0,imgA.height+RectSize,imgA.width/2.0,RectSize);
  rect(imgA.width/2.0,imgA.height+RectSize,imgA.width/2.0,RectSize);
  
  // 日本語フォントを選択し指定する呪文
  
  PFont font = createFont("MS Gothic",25,true);
  textFont(font);
  
  // 選択肢の表示
  
  textAlign(CENTER);
  fill(0);
  
  if(isInAlternative_1){
    textSize(30);
  }
  else{
    textSize(25);
  }
  text(Alternative_1,imgA.width*0.25,imgA.height+RectSize*0.75);
  
  if(isInAlternative_2){
    textSize(30);
  }
  else{
    textSize(25);
  }
  text(Alternative_2,imgA.width*0.75,imgA.height+RectSize*0.75);
  
  if(isInAlternative_3){
    textSize(30);
  }
  else{
    textSize(25);
  }
  text(Alternative_3,imgA.width*0.25,imgA.height+RectSize*1.75);
  
  if(isInAlternative_4){
    textSize(30);
  }
  else{
    textSize(25);
  }
  text(Alternative_4,imgA.width*0.75,imgA.height+RectSize*1.75);
  
  
  
  
  
  // 解答の正誤判定
  
  if(choose_answer != 0){
    if(choose_answer == CorrectAnswer){
      fill(255,0,0);
      textSize(30);
      text("正解",100,100);
    }
    else{
      fill(255,0,0);
      textSize(30);
      text("不正解",100,100);
    }
  }
}
}

  //解答の選択
  
void mouseClicked(){
  
  if(!isCompletedAnswer){
    if(isInAlternative_1){
      choose_answer = 1;
      isCompletedAnswer = true;
    }
    if(isInAlternative_2){
      choose_answer = 2;
      isCompletedAnswer = true;
    }
    if(isInAlternative_3){
      choose_answer = 3;
      isCompletedAnswer = true;
    }
    if(isInAlternative_4){
      choose_answer = 4;
      isCompletedAnswer = true;
    }
  }
}


boolean doCommand(String commandStr) {
  if(commandStr.length()<=0) {
    return true; // 空行のときだけtrueを返す
  } else if(commandStr.charAt(0)=='>') {
    String[] args = splitTokens(commandStr);
    if(args.length>0) {
      if(">event".equals(args[0])) {
        if(args.length>1) {
          isEvent = true;
          bgAlpha = 0;
          println(isEvent); // for debug
          //bg = loadImage(args[1]);
          imgA = loadImage(args[1]);
          imgB = loadImage(args[2]);
          imgC = loadImage(args[3]);
          if (imgA.width != width || imgA.height != height) {
            imgA.resize(width, height);
          }
          if (imgB.width != width || imgB.height != height) {
            imgB.resize(width, height);
          }
          if (imgC.width != width || imgC.height != height) {
            imgC.resize(width, height);
          }
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
          println("loading image!");
          if (bg.width != width || bg.height != height) {
            bg.resize(width, height);
          }
         } else bg = null;
        }
    }
  } else {
    if(message.length()>0) message += "\n";
    message += commandStr;
  }
  return false;
}