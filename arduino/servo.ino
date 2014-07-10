#include <Servo.h>
Servo Pan, Tilt; // Define our Servo
int tv = 50, pv = 0;

void setup()
{
   Pan.attach(10);
   Pan.write(pv);
   Tilt.attach(11);
   Tilt.write(tv);
   
   Serial.begin(9600);
   Serial.println("Ready");

}

void loop()
{
  if (Serial.available()) {
    char c = Serial.read();
    
    switch (c) {
    case 'w':
      tv += 5;
      Serial.println("up");
      break;
    case 's':
      tv -= 5;
      Serial.println("down");
      break;
    case 'a':
      pv += 5;
      Serial.println("left");
      break;
    case 'd':
      pv -= 5;
      Serial.println("right");
      break;
    case ' ':
      tv = 50;
      pv = 0;
      Serial.println("cleard");
      break;
    default:
      break;
    }
    
    Tilt.write(tv);
    Pan.write(pv);
  }
  delay(20);
}
