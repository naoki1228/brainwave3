class Question{
 
  Question(PImage pic1,PImage pic2,PImage pic3){
    imgA = pic1;
    imgB = pic2;
    imgC = pic3; 
  PImage imgA, imgB, imgC;
  float transparencyAtoB;
  float transparencyBtoC;
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
  boolean isAlphawaveFirstLevel;
  boolean isAlphawaveSecondLevel;
  int currentTime;
  int fadeCompletedTime;
  int timeCounter;
  int limitTime;
  int RectSize;
  int CorrectAnswer;
  int choose_answer;
  float easing;
  float alphawave;
  float AlphawaveFirstLevel;
  float AlphawaveSecondLevel;
  float TransparencyError;
  String Alternative_1;
  String Alternative_2;
  String Alternative_3;
  String Alternative_4;
  
    isFadeAtoB = false;
    isFadeBtoC = false;
    transparencyAtoB = 0;
    transparencyBtoC = 0;
    targetTransparency = 255;
    isFadeCompletedAtoB = false;
    isFadeCompletedBtoC = false;
    isCompletedAnswer = false;
    isInAlternative_1 = false;
    isInAlternative_2 = false;
    isInAlternative_3 = false;
    isInAlternative_4 = false;
    isAlphawaveFirstLevel = false;
    isAlphawaveSecondLevel = false;
    easing = 0.005;
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
}