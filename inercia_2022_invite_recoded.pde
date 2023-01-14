import processing.sound.*;

SoundFile soundfile;

int[] id = {
 0,11,2,8,8,8,0,0,
11,11,2,8,8,8,8,0,
11,11,0,0,2,8,8,8,
11,10,0,0,0,0,8,8,
10, 3,0,0,0,0,8,8,
 3, 3,0,0,2,8,8,8,
 3, 3,2,8,8,8,8,0,
 0, 3,2,8,8,8,0,0 };

color[] Pico8 = {
  #000000,#1D2B53,#7E2553,#008751,#AB5236,#5F574F,#C2C3C7,#FFF1E8,
  #FF004D,#FFA300,#FFEC27,#00E436,#29ADFF,#83769C,#FF77A8,#FFCCAA };

String[] ts= {"Greetings participants of\n Processing Community Day 2023!",
              "This effect was originally coded\n for the pico-8 1kb jam 2022",
              "Inviting developers to participate\n in a creative coding event",
              "called Inercia Demoparty!\n a demoscene event hosted in Portugal",
              "demoscene is a computer culture born in the 80s\n with digital artists of all fields",
              "demosceners create realtime audiovisual\n productions that demonstrate what the computer can do",
              "it has been recognized by unesco as\n intangible cultural heritage in finland, poland and germany",
              "it is also active in portugal through\n Associacao Inercia ( https://inercia.pt )",
              "processing is tagged as a development tool\n in over 90 demoscene productions so far",
              "interested in increasing that number?\n add Inercia Demoparty 2023 to your calendar and participate!",
              "Inercia Demoparty 2023 (14th edition)\n 1-3 December 2023",
              "credits for this production\n code & text by ps - music by mrsbeanbag"
            };
            
float xRatio, yRatio;
  
void setup() {
  fullScreen();
  background(#000000);
  noCursor();
  PFont mono;
  mono = createFont("PICO-8 mono.ttf", 128);
  textFont(mono);
  soundfile = new SoundFile(this, "lisbon_nights.mp3");
  soundfile.loop();
  xRatio = displayWidth/128;
  yRatio = displayHeight/128;
}

void floatText(String text, float posX, float posY, float startTime, color baseColor, float groundSize) {
  String[] list = split(text, '\n');
  for (var l=0;l<list.length; l++) {
    for (var i=0;i<list[l].length();i++) {
      float dt = millis() - startTime;
      fill(baseColor, constrain((dt+1)/8-i*20-l*36+sin(dt/200-i*20-l*16)*2,0,255));
      textSize(groundSize + 255 - constrain((dt/3-i*40-l*12)/2+cos(dt/300-i*20-l*12)*20,0,255));
      text(list[l].charAt(i), posX + groundSize*i, posY + groundSize*1.7*l + 255 - constrain(dt/5-i*20-l*36+sin(dt/200-i*20-l*16)*12,0,255) );
    }
  }
}

int prev = 0;
float prevStartTime = 0.0;

void draw() {
  
  float d=millis()/100.0;
  background(Pico8[millis()/1000%6]);
  float m=d*.001;

  fill(#80000000);
  for (int x=0; x<=17; x+=1) {
    //poke(12869,d&8+x*p)
    //sfx(1)
    for (int y=0; y<=19; y+=1) {
      int col=int(abs(cos((x-8)*(y-8)*d*.01)*14));
      color tc = color(Pico8[col], 100);
      strokeWeight(yRatio*(16-col)*.125);
      stroke(tc);
      circle(x*8*xRatio,(y*8*xRatio+xRatio*2+d*10)%(displayHeight+xRatio*4)-xRatio*2,col*yRatio);
    }
  }
  
  noStroke();
  for (int x=1; x<128; x+=4) {
    for (int y=1; y<128; y+=4) {
      color tc = color( Pico8[constrain(int(sin((x^y)*.01*2*d)*8+6-sin(d)*.01*3%3),0,15)], 255);
      //set(x,y+(x^y)%9);
      fill(tc);
      rect(x*xRatio,y*xRatio,yRatio*4,yRatio*4);
    }
  }

  noStroke();
  float v=sin(m*100)*6+10;
  fill(Pico8[0]);
  rect(0,(v+82)*yRatio,displayWidth,84*yRatio*.25);

  for (int x=0; x<8; x+=1) {
    for (int y=0; y<8; y+=1) {
       //set(5+x,int(88+y+v), Pico8[id[x+y*8]] );
       fill(Pico8[id[x+y*8]]);
       rect((5+x)*yRatio, floor((88+y+v)*yRatio), yRatio, yRatio);
    }
  }

  int p = constrain(int(d/120%12),0,11);
  
  if (p != prev) {
    prevStartTime = millis();
    prev = p;
  }
  floatText(ts[p].toUpperCase(), 10*xRatio, (91+v)*yRatio, prevStartTime, Pico8[7], xRatio*1.5 );
  
}
