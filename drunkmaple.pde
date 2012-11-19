#include <LiquidCrystal.h>
//#include "libmaple.h"
#define DRINKING 250
#define DRUNK 300

LiquidCrystal lcd(8, 9, 4, 5, 6, 7);

void setup()
{
  lcd.begin(16, 2);
  lcd.clear();
  lcd.print("Initialising...");
  SerialUSB.println("hello");
}

void loop()
{
  uint16 valMax = 0, temp;
  unsigned long past = millis(), now = 0;
  temp = analogRead(17); //Read Gas value from analog 0
  lcd.clear();
  if(temp > valMax) 
  {
      valMax = temp;
      past = millis();
  }
  now = millis();
  if(temp < valMax && now - past > 3000)
  {
     if(valMax > DRINKING) 
       {
          lcd.setCursor(6, 1);
          lcd.print("Drinking");
       }
       if(valMax > DRUNK)
       {
          lcd.setCursor(7, 1);
          lcd.print("DRUNK!"); 
       }
  }
  SerialUSB.println(valMax, DEC);//Print the value to serial port
   lcd.setCursor(6, 0);
  lcd.print(valMax);
  
  delay(100);
}
