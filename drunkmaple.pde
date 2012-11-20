#include <LiquidCrystal.h>
//#include "libmaple.h"
#define DRINKING 40
#define DRUNK 100

LiquidCrystal lcd(8, 9, 4, 5, 6, 7);

void setup()
{
  lcd.begin(16, 2);
  lcd.clear();
  lcd.print("Initialising...");
  delay(3000);
  SerialUSB.println("hello");
}

void loop()
{
  uint16 valMax = 0, temp;
  unsigned long past, now = 0;
  while(1){
    temp = analogRead(17); //Read Gas value from analog 0
    lcd.clear();
    if(temp > valMax) 
    {
        valMax = temp;
        past = millis();
    }
  
    SerialUSB.println(valMax, DEC);//Print the value to serial port
     lcd.setCursor(6, 0);
    lcd.print(valMax);
//       lcd.setCursor(6, 1);
//    lcd.print(temp);
    delay(100);
 
  now = millis();
  
  if(temp < valMax && now - past > 3000)
  {
     
       if(valMax > DRUNK)
       {
          lcd.setCursor(5, 1);
          lcd.print("DRUNK!"); 
          while(1);
       }
       else if(valMax > DRINKING) 
       {
          lcd.setCursor(4, 1);
          lcd.print("Drinking");
          while(1);
       }
       else while(1);
  }
  
  } 
  delay(100);
}
