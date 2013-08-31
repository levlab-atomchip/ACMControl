#include <avr/pgmspace.h>

const int bitPin = 8;
const int clockPin = 12;
const int inputPin = 2;

const int ledPin = 13;
const int dot = 50;
const int dash = dot*3;

const int m = &&M&&;
const int n = &&N&&;
PROGMEM const int array[m][n] = &&ARRAY&&;

int w = 0;
int b = 0;
int arrayval;

volatile int flag = 0;

void writeDDS()
{
  flag = 1;
}

void morse()
{
  digitalWrite(ledPin,HIGH);
  delay(dash);
  digitalWrite(ledPin,LOW);
  delay(dot);
  digitalWrite(ledPin,HIGH);
  delay(dot);
  digitalWrite(ledPin,LOW);
  delay(dot);
  digitalWrite(ledPin,HIGH);
  delay(dot);
  digitalWrite(ledPin,LOW);
  delay(dash);
  digitalWrite(ledPin,HIGH);
  delay(dash);
  digitalWrite(ledPin,LOW);
  delay(dot);
  digitalWrite(ledPin,HIGH);
  delay(dot);
  digitalWrite(ledPin,LOW);
  delay(dot);
  digitalWrite(ledPin,HIGH);
  delay(dash);
  digitalWrite(ledPin,LOW);
  delay(dot);
  digitalWrite(ledPin,HIGH);
  delay(dash);
  digitalWrite(ledPin,LOW);
}

void setup()
{
  pinMode(ledPin,OUTPUT);
  pinMode(clockPin,OUTPUT);
  pinMode(bitPin,OUTPUT);
  
  attachInterrupt(0, writeDDS, FALLING);
//  morse();
  
  PORTB &= B00000;
}

void loop()
{
  while(flag)
  {
    for(b=0;b<n;b++)
    {
      arrayval = pgm_read_word(&array[w][b]);
      if (arrayval == 0)
      {
        PORTB |= B10000;
        PORTB &= B00000;
      }
      else if (arrayval == 1)
      {
        PORTB |= B00001;
        PORTB |= B10001;
        PORTB &= B00000;
      }
      else
      {
        w = w + 1;
        if(w==m)
        {
          w = 0;
        }
        flag = 0;
        break;
      }
    }
  }
}

