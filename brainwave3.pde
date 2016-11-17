import oscP5.*;
final int PORT = 5000;
OscP5 oscP5 = new OscP5(this, PORT);

final int N_CHANNELS = 4;
final int BUFFER_SIZE = 10;
// final int BUFFER_SIZE = 220;
float[][] buffer = new float[N_CHANNELS][BUFFER_SIZE];
int pointer = 0;

// adventure_initial_variables
PImage bg, chara,pic_q1_1,pic_q1_2,pic_q1_3,pic_q2_1,pic_q2_2,pic_q2_3,pic_q3_1,pic_q3_2,pic_q3_3,pic_q4_1,pic_q4_2,pic_q4_3,pic_q5_1,pic_q5_2,pic_q5_3;
int bgAlpha = 0;
int charaAlpha = 0;
String[] scenario;
int scenarioCur = 0;
String message = "";
int messageCur = 0;
boolean prevMousePressed = false;

// fade_variables
PImage imgA, imgB, imgC,nightimg, skyimg, parkimg,bg_alternative,ryusei;
float transparency;
float targetTransparency;
boolean isFadeAtoB;
boolean isFadeBtoC;
boolean  isFadeCompletedAtoB;
boolean  isFadeCompletedBtoC;
boolean ischeckerAtoB;
boolean ischeckerBtoC;
boolean isEvent = false;
boolean isNextEvent = false;
boolean isMuse;
boolean isRyusei = false;
boolean isStartEvent = false;
boolean isFinal = false;
boolean isMusic = false;
int currentTime;
int fadeCompletedTime;
float easing;
float gain;
import ddf.minim.*;
Minim minim;
AudioPlayer music1;
AudioPlayer music2;
AudioPlayer music3;
boolean isPark = false;
boolean isSky = false;
int Correct = 0;

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
boolean isCorrect;
int timeCounter;
int limitTime;
int RectSize;
int CorrectAnswer;
int CorrectAnswer_q1;
int CorrectAnswer_q2;
int CorrectAnswer_q3;
int CorrectAnswer_q4;
int CorrectAnswer_q5;
int choose_answer;
int questionNum;
float alphawave;
float AlphawaveFirstLevel;
float AlphawaveSecondLevel;
float TransparencyError;
String Alternative_1;
String Alternative_2;
String Alternative_3;
String Alternative_4;
String Alternative_q1_1;
String Alternative_q1_2;
String Alternative_q1_3;
String Alternative_q1_4;
String Alternative_q2_1;
String Alternative_q2_2;
String Alternative_q2_3;
String Alternative_q2_4;
String Alternative_q3_1;
String Alternative_q3_2;
String Alternative_q3_3;
String Alternative_q3_4;
String Alternative_q4_1;
String Alternative_q4_2;
String Alternative_q4_3;
String Alternative_q4_4;
String Alternative_q5_1;
String Alternative_q5_2;
String Alternative_q5_3;
String Alternative_q5_4;
int sky;

//流星 
float x  ,vx;
PImage offscr;

int bgtransparency;
boolean bgisFadeAtoB;
boolean bgisFadeCompleted;

int bbgtransparency;
boolean bbgisFadeAtoB;
boolean bbgisFadeCompleted;


// setup
void setup() {
  
  bgtransparency = 0;
  bgisFadeAtoB = true;
  bgisFadeCompleted = false;
  
  bbgtransparency = 0;
  bbgisFadeAtoB = true;
  bbgisFadeCompleted = false;
        
  
  size(457, 387);
  textFont(createFont("MS PMincho", 20)); //String[] fontList = PFont.list(); println(fontList);
  scenario = loadStrings("scenario.txt");

  // setup_fade
  minim = new Minim(this);
  music1 = minim.loadFile("healing1.mp3");
  music2 = minim.loadFile("healing2.mp3");
  music3 = minim.loadFile("healing3.mp3");
  isFadeAtoB = true;
  isFadeBtoC = false;
  transparency = 0;
  targetTransparency = 255;
  isFadeCompletedAtoB = false;
  isFadeCompletedBtoC = false;
  ischeckerAtoB = false;
  ischeckerBtoC = false;
  easing = 0.005;
  gain = 6;

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
  isMuse = false;                    //Museがあれば脳波を取る、なければ時間で動く仮のα波の値
  AlphawaveFirstLevel = 0.15;         // α波の基準値
  AlphawaveSecondLevel = 0.25;
  TransparencyError = 4.0;           //  transparencyの値の許容誤差
  timeCounter = 0;
  limitTime = 60;                    //  制限時間
  RectSize = 40;
  choose_answer = 0;
  questionNum = 1;
  
  //Question1
  
  pic_q1_1 =loadImage("washi1.jpg");
  pic_q1_2 =loadImage("washi2.jpg");
  pic_q1_3 =loadImage("washi3.jpg");
  Alternative_q1_1 = "おとめ座";
  Alternative_q1_2 = "さそり座";
  Alternative_q1_3 = "ふたご座";
  Alternative_q1_4 = "わし座";
  CorrectAnswer_q1 = 4;
  
  //Question2
  
  pic_q2_1 =loadImage("koto1.jpg");
  pic_q2_2 =loadImage("koto2.jpg");
  pic_q2_3 =loadImage("koto3.jpg");
  Alternative_q2_1 = "へび座";
  Alternative_q2_2 = "こと座";
  Alternative_q2_3 = "かに座";
  Alternative_q2_4 = "うお座";
  CorrectAnswer_q2 = 2;
  
  //Question3
  
  pic_q3_1 =loadImage("hakucho1.jpg");
  pic_q3_2 =loadImage("hakucho2.jpg");
  pic_q3_3 =loadImage("hakucho3.jpg");
  Alternative_q3_1 = "はくちょう座";
  Alternative_q3_2 = "てんびん座";
  Alternative_q3_3 = "おおいぬ座";
  Alternative_q3_4 = "おひつじ座";
  CorrectAnswer_q3 = 1;
  
  //Question4
  
  pic_q4_1 =loadImage("ooguma1.jpg");
  pic_q4_2 =loadImage("ooguma2.jpg");
  pic_q4_3 =loadImage("ooguma3.jpg");
  Alternative_q4_1 = "アンドロメダ座";
  Alternative_q4_2 = "カシオペア座";
  Alternative_q4_3 = "オリオン座";
  Alternative_q4_4 = "おおぐま座";
  CorrectAnswer_q4 = 4;
  
  //Question5
  
  pic_q5_1 =loadImage("ushikai1.jpg");
  pic_q5_2 =loadImage("ushikai2.jpg");
  pic_q5_3 =loadImage("ushikai3.jpg");
  Alternative_q5_1 = "きょしちょう座";
  Alternative_q5_2 = "とびうお座";
  Alternative_q5_3 = "うしかい座";
  Alternative_q5_4 = "ろくぶんぎ座";
  CorrectAnswer_q5 = 3;
  
  //背景画像
  skyimg = loadImage("sky.jpg");
  parkimg = loadImage("park1.jpg");
  nightimg = loadImage("nightwalk.jpg");
  sky = 0;
  
  //選択肢背景
  
  bg_alternative = loadImage("hosizora.jpg");
  
  //流星画面
  
  ryusei = loadImage("hosizora.jpg");
  x = 100;
  vx = 10;
  
}


// 毎フレームの進行と描画
void draw(){
  
  background(0);
  
  image(nightimg, 0, 0 ,457, 387);
 
 /*
  // background stary sky 
  if(sky == 0){
  image(nightimg, 0, 0);
 }else{
  image(parkimg, 0, 0);
  }
  */
  
  if(isPark){
    //image(parkimg, 0, 0 ,457, 387);
   park();
}
  if(isSky){
    //image(skyimg, 0, 0 ,457, 387);
   sky();  
}
  
  if(isStartEvent){
    music1.close();
    music2.play();
  }
  else{
    music1.play();
  }
  if(isFinal){
    gain = gain - 0.15;
    music2.setGain(gain);
  }
  if(isMusic){
    music2.close();
    music3.play();
  }
  
 
   
  if(isEvent == false){

    if(isSky == false){
    if(chara!=null) {
      if(charaAlpha<255) charaAlpha += 20;
      tint(255, charaAlpha);
      image(chara, width - chara.width - 40, height - chara.height - 80);
    }
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
  if(isEvent){
    changepictures();
  }
  if(isNextEvent){
  //  nextevent();
  }
  if(isRyusei){
    ryusei();
  }
}

  //解答の選択

void mouseClicked(){
  if(isEvent){
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
  if(isNextEvent){
    //scenarioCur++;
    isNextEvent = false;
  }
  
  
}


boolean doCommand(String commandStr) {
  if(commandStr.length()<=0) {
    return true; // 空行のときだけtrueを返す
  } else if(commandStr.charAt(0)=='>') {
    String[] args = splitTokens(commandStr);
    if(args.length>0) {
      if(">nextevent".equals(args[0])) {
        isNextEvent =true;
      }
      if(">ryusei".equals(args[0])){
        isRyusei = true;
      }
      if(">final".equals(args[0])){
        isFinal = true;
      }
      if(">music".equals(args[0])){
        isMusic = true;
      }
      
      //画像推移
       if(">park".equals(args[0])) { 
          isPark = true;
        }
        if(">sky".equals(args[0])) { 
          isSky = true;
        }
      if(">event".equals(args[0])) {
      //  if(args.length>1) {
          isEvent = true;
          isStartEvent =true;
          bgAlpha = 0;
          println(isEvent);
      
          
          System.out.println("questionNum = " + questionNum);
          
          if(questionNum == 1){
            Question question1 = new Question(pic_q1_1,pic_q1_2,pic_q1_3,Alternative_q1_1,Alternative_q1_2,Alternative_q1_3,Alternative_q1_4,CorrectAnswer_q1);
            questionNum = 2;
          }
          else if(questionNum == 2){
            Question question2 = new Question(pic_q2_1,pic_q2_2,pic_q2_3,Alternative_q2_1,Alternative_q2_2,Alternative_q2_3,Alternative_q2_4,CorrectAnswer_q2);
            questionNum = 3;
          }
          else if(questionNum == 3){
            Question question3 = new Question(pic_q3_1,pic_q3_2,pic_q3_3,Alternative_q3_1,Alternative_q3_2,Alternative_q3_3,Alternative_q3_4,CorrectAnswer_q3);
            questionNum = 4;
          }
          else if(questionNum == 4){
            Question question4 = new Question(pic_q4_1,pic_q4_2,pic_q4_3,Alternative_q4_1,Alternative_q4_2,Alternative_q4_3,Alternative_q4_4,CorrectAnswer_q4);
            questionNum = 5;
          }
          else{
            Question question5 = new Question(pic_q5_1,pic_q5_2,pic_q5_3,Alternative_q5_1,Alternative_q5_2,Alternative_q5_3,Alternative_q5_4,CorrectAnswer_q5);
            questionNum = 6;
          }
          
              
          //bg = loadImage(args[1]);
          //imgA = loadImage(args[1]);
          //imgB = loadImage(args[2]);
          //imgC = loadImage(args[3]);
          //if (imgA.width != width || imgA.height != height) {
          //  imgA.resize(width, height);
          //}
          //if (imgB.width != width || imgB.height != height) {
          //  imgB.resize(width, height);
          //}
          //if (imgC.width != width || imgC.height != height) {
          //  imgC.resize(width, height);
          //}
        // }
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

void oscEvent(OscMessage msg){
  float data;
  if(msg.checkAddrPattern("/muse/elements/alpha_relative")){
    for(int ch = 0; ch < N_CHANNELS; ch++){
      data = msg.get(ch).floatValue();
      buffer[ch][pointer] = data;
    }
    pointer = (pointer + 1) % BUFFER_SIZE;
  }
}

void changepictures(){
  
  
    // α波の感知
  if(isMuse){  
    float sum = 0;
    for(int ch = 0; ch < N_CHANNELS; ch++){
      sum = sum + buffer[ch][pointer];
    }
    alphawave = sum / 4;
  }
  else{
    if(limitTime >45){
      alphawave = 0.25;
    }
    else if(limitTime > 40){
      alphawave = 0.45;
    }
    else if(limitTime > 30){
      alphawave = 0.15;
    }
    else if(limitTime > 20){
      alphawave = 0.45;
    }
    else if(limitTime > 9){
      alphawave = 0.25;
    }
    else{
      alphawave = 0.15;
    }
  }
    
    
   // alphawave = buffer[0][pointer];
    
   //System.out.println(alphawave);

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
    fill(200);     //#030303
    textSize(50);
    text(nf(limitTime, 2), 100, 50);
  }

  if(limitTime < 0){
    fill(200);
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
 // fill(255);
  tint(200);
  image(bg_alternative, 0, imgA.height);
  /*rect(0,imgA.height,imgA.width/2.0,RectSize);
  rect(imgA.width/2.0,imgA.height,imgA.width/2.0,RectSize);
  rect(0,imgA.height+RectSize,imgA.width/2.0,RectSize);
  rect(imgA.width/2.0,imgA.height+RectSize,imgA.width/2.0,RectSize);
*/

  // 日本語フォントを選択し指定する呪文

  //PFont font = createFont("MS Gothic",25,true);
  //textFont(font);

  // 選択肢の表示

  textAlign(CENTER);
  fill(200);

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
      fill(200);
      textSize(30);
      text("正解",100,100);
      isCorrect = true;
      isCompletedAnswer = true;
    }
    else{
      fill(200);
      textSize(30);
      text("不正解",100,100);
      isCorrect = false;
      isCompletedAnswer = true;
    }
  }
  
  // scenario choice
  
   if(isCompletedAnswer && mousePressed){
      scenarioCur = 1;
      choose_answer = 0;
      limitTime = 60;
      transparencyAtoB = 0;
      transparencyBtoC = 0;
      isFadeAtoB = true;
      isFadeBtoC = false;
      isFadeCompletedAtoB = false;
      isFadeCompletedBtoC = false;
      isCompletedAnswer = false;
      if(isCorrect == true){
        Correct++;
      }
    if(questionNum <= 6){ 
      if(isCorrect){
        if(questionNum == 2){
          isEvent = false;
          size(457, 387);
          textFont(createFont("MS PMincho", 20));
          sky++;
          scenario = loadStrings("scenario_win_1.txt");
         }
         if(questionNum == 3){
          isEvent = false;
          size(457, 387);
          textFont(createFont("MS PMincho", 20));
          sky++;
          scenario = loadStrings("scenario_win_2.txt");
         }
         if(questionNum == 4){
          isEvent = false;
          size(457, 387);
          textFont(createFont("MS PMincho", 20));
          sky++;
          scenario = loadStrings("scenario_win_3.txt");
         }
         if(questionNum == 5){
          isEvent = false;
          size(457, 387);
          textFont(createFont("MS PMincho", 20));
          sky++;
          scenario = loadStrings("scenario_win_4.txt");
        }
         if(questionNum == 6){
          isEvent = false;
          size(457, 387);
          textFont(createFont("MS PMincho", 20));
          sky++;
          if(Correct<4){
            scenario = loadStrings("scenario_win_5_bad.txt");
          } else{
            scenario = loadStrings("scenario_win_5_happy.txt");
          }
        }
      }
      
      else{
        if(questionNum == 2){
       isEvent = false;
       size(457, 387);
        textFont(createFont("MS PMincho", 20));
        sky++;
       scenario = loadStrings("scenario_lose_1.txt");
      }
      if(questionNum == 3){
       isEvent = false;
       size(457, 387);
        textFont(createFont("MS PMincho", 20));
        sky++;
       scenario = loadStrings("scenario_lose_2.txt");
      }if(questionNum == 4){
       isEvent = false;
       size(457, 387);
        textFont(createFont("MS PMincho", 20));
        sky++;
       scenario = loadStrings("scenario_lose_3.txt");
      }if(questionNum == 5){
       isEvent = false;
       size(457, 387);
        textFont(createFont("MS PMincho", 20));
        sky++;
       scenario = loadStrings("scenario_lose_4.txt");
      }if(questionNum == 6){
       isEvent = false;
       size(457, 387);
        textFont(createFont("MS PMincho", 20));
        sky++;
        if(Correct<4){
         scenario = loadStrings("scenario_lose_5_bad.txt");
        } else{
          scenario = loadStrings("scenario_lose_5_happy.txt");
        }
      }
      }
      
    }
    //else{
    //  isEvent = false;
    //  textFont(createFont("MS PMincho", 20));
    //  if(Correct < 4){
    //  scenario = loadStrings("scenario_last_lose.txt");
    //  }
    //  else{
    //  scenario = loadStrings("scenario_last_win.txt");
    //  }
    //}
    
  }

}

/*void nextevent(){
  fill(255,0,0);
  stroke(10);
  line(0,pic_q1_1.height,pic_q1_1.width,pic_q1_1.height);
  textAlign(CENTER);
  textSize(40);
  //text("↑画面上部をクリックしてください",pic_q1_1.width*0.5,pic_q1_1.height+RectSize);
  println(mouseX);
  println(mouseY);
  println(isNextEvent);
    if(mouseX > 0 && mouseX < pic_q1_1.width && mouseY > 0 && mouseY < pic_q1_1.height){
      mouseClicked();
    }
    println(isNextEvent);
}
*/

void ryusei(){
  tint(255);
  image(ryusei,0,0);
  
  //offscr = createImage(width, height, RGB);

  x += vx;
 // if (x < 50 || x > width - 50) { vx = -vx; }

  loadPixels();
  //offscr.pixels = pixels;
  //offscr.updatePixels();

  noStroke();
  fill(255,255,0);
  rotate(-PI/12);
  ellipse(400-x, 150, 100, 1);
  rotate(PI/12);

  tint(255, 240);
  //image(offscr, -3, -3, width + 6, height + 6);

}

void park(){
  background(255);
  if(255 - bgtransparency <= 1.0) {
    currentTime = millis();
    if(bgisFadeCompleted) {     
        bgtransparency = 0;
        bgisFadeAtoB = false;
        bgisFadeCompleted = false;
      
    } else {
      bgisFadeCompleted = true;
    }
    
  }

  if(bgisFadeAtoB) {
    noTint();
    image(nightimg, 0, 0);
    tint(255, bgtransparency);
    image(parkimg, 0, 0);
  }
  else{
  image(parkimg, 0, 0);
  }

  bgtransparency += (255 - bgtransparency) * 0.05;
}

void sky(){
  background(255);
  if(255 - bbgtransparency <= 1.0) {
    currentTime = millis();
    if(bbgisFadeCompleted) {     
        bbgtransparency = 0;
        bbgisFadeAtoB = false;
        bbgisFadeCompleted = false;
      
    } else {
      bbgisFadeCompleted = true;
    }
    
  }

  if(bbgisFadeAtoB) {
    noTint();
    image(parkimg, 0, 0);
    tint(255, bbgtransparency);
    image(skyimg, 0, 0);
  }
  else{
     tint(255, 0);
    image(parkimg, 0, 0);
  image(skyimg, 0, 0);
  }

  bbgtransparency += (255 - bbgtransparency) * 0.1;
}