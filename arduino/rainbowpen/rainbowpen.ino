#include <RFduinoBLE.h>

// Pin configuration
#define RED 6
#define GREEN 5
#define BLUE 3
#define POTENTIOMETER 2

#define delayTime 200

int previousColor = 0;

void setup() {
  
  //BLE initialization
  RFduinoBLE.advertisementData = "color";
  RFduinoBLE.begin();
  
  pinMode(POTENTIOMETER, INPUT);
  
  // LED setup
  pinMode(GREEN, OUTPUT);
  pinMode(BLUE, OUTPUT);
  pinMode(RED, OUTPUT);
  
  digitalWrite(GREEN, LOW);
  digitalWrite(BLUE, LOW);
  digitalWrite(RED, LOW);
  
  Serial.begin(9600);
}

void loop() {
  
  RFduino_ULPDelay( 500 );
 
  double potval = analogRead(POTENTIOMETER);
  int color;
 
  if (potval < 128) {
    pink();
    color = 1;
  } else if (potval < 256) {
    purple();
    color = 2;
  } else if (potval < 384) {
    blue();
    color = 3;
  } else if (potval < 512) {
    cyan();
    color = 4;
  } else if (potval < 640) {
    green();
    color = 5;
  } else if (potval < 768) {
    yellow();
    color = 6;
  } else if (potval < 896) {
    orange();
    color = 7; 
  } else {
    red();
    color = 8;
  }

  Serial.println(potval);
  Serial.println("\n---------------");
  
  if (color != previousColor) {
    RFduinoBLE.sendInt(color);
    previousColor = color;
    Serial.println(color);
  }
  Serial.println("\n---------------");
  
  delay(delayTime);
}

void red() {
  digitalWrite(RED, HIGH);
  digitalWrite(GREEN, LOW);
  digitalWrite(BLUE, LOW);
}

void orange() {
  digitalWrite(RED, HIGH);
  analogWrite(GREEN, 32);
  digitalWrite(BLUE, LOW);
}

void yellow() {
  digitalWrite(RED, HIGH);
  analogWrite(GREEN, 128);
  digitalWrite(BLUE, LOW);
}

void green() {
  digitalWrite(RED, LOW);
  digitalWrite(GREEN, HIGH);
  digitalWrite(BLUE, LOW);
}

void cyan() {
  digitalWrite(RED, LOW);
  digitalWrite(GREEN, HIGH);
  digitalWrite(BLUE, HIGH);
}

void blue() {
  digitalWrite(RED, LOW);
  digitalWrite(GREEN, LOW);
  digitalWrite(BLUE, HIGH);
}

void purple() {
  analogWrite(RED, 128);
  digitalWrite(GREEN, LOW);
  digitalWrite(BLUE, HIGH);
}

void pink() {
  digitalWrite(RED, HIGH);
  digitalWrite(GREEN, LOW);
  digitalWrite(BLUE, HIGH);
}

