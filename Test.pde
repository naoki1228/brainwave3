PImage imgA, imgB, imgC;
float transparency;
float targetTransparency;
boolean isFadeAtoB;
boolean isFadeBtoC;
boolean  isFadeCompletedAtoB;
boolean  isFadeCompletedBtoC;
boolean isCompletedAnswer;
boolean isInAlternative_1;
boolean isInAlternative_2;
boolean isInAlternative_3;
boolean isInAlternative_4;
int currentTime;
int fadeCompletedTime;
int timeCounter;
int limitTime;
int RectSize;
int CorrectAnswer;
int choose_answer;
float easing;
String Alternative_1;
String Alternative_2;
String Alternative_3;
String Alternative_4;



void setup() {
  isFadeAtoB = true;
  isFadeBtoC = false;
  transparency = 0;
  targetTransparency = 255;
  isFadeCompletedAtoB = false;
  isFadeCompletedBtoC = false;
  isCompletedAnswer = false;
  isInAlternative_1 = false;
  isInAlternative_2 = false;
  isInAlternative_3 = false;
  isInAlternative_4 = false;
  easing = 0.005;
  timeCounter = 0;
  limitTime = 20;
  RectSize = 40;
  Alternative_1 = "おとめ座";
  Alternative_2 = "さそり座";
  Alternative_3 = "おうし座";
  Alternative_4 = "やぎ座";
  CorrectAnswer = 4;                  //正解の選択肢番号
  choose_answer = 0;
  
}

void settings() {
  imgA = loadImage("base.jpg");
  imgB = loadImage("sheep1.jpg");
  imgC = loadImage("sheep2.jpg");
  size(imgA.width, imgA.height+80);   //RectSizeを変更したらここも変える
}

void draw() {
  


  
  
  
  // 3枚の画像の推移
  
  background(255);
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
          isFadeBtoC = false;
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
  
  if(isFadeBtoC) {
    noTint();
    image(imgB, 0, 0);
    tint(255, transparency);
    image(imgC, 0, 0);
  } 
  
  if(isFadeCompletedAtoB && isFadeCompletedBtoC){
    image(imgC,0,0);
  }
  
  if(transparency<200){
    transparency += (targetTransparency - transparency) * easing;
  }
  else{
    transparency += 100*easing;
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
   