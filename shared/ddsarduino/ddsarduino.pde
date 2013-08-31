#include <avr/pgmspace.h>
#include <SPI.h>

const int CS = 10;
const int MOSI = 11;
const int MISO = 12;
const int SCK = 13;
const int writePin = 2;

int lb = 0; //load bit
int elb; //end load bit

int wb = 0; //write bit
int ewb = 0; //end write bit

byte buffer[800];

volatile int flag1 = 0;
volatile int flag2 = 0;

void setup()
{
  pinMode(CS,OUTPUT);
  pinMode(MOSI,OUTPUT);
  pinMode(SCK,OUTPUT);
  
  pinMode(MISO,INPUT);  
  pinMode(writePin,INPUT);
  
  attachInterrupt(0, flagthrow, FALLING);
  
  Serial.begin(9600);
  
  SPI.begin();
  SPI.setBitOrder(MSBFIRST);
  SPI.setClockDivider(SPI_CLOCK_DIV2);
  SPI.setDataMode(SPI_MODE0);
}

void flagthrow()
{
  flag1 = 1;
  flag2 = 1;
}

void loadcomment()
{
  buffer[lb] = Serial.read();
  
  if(buffer[lb]==255)
  {
    lb=0;
    buffer[lb] = 0;
    return;
  }
  
  elb = lb + buffer[lb];
  
  while(Serial.available()<buffer[lb]){}
  
  for(lb=lb+1;lb<(elb+1);lb++)
  {
    buffer[lb] = Serial.read();
  }
}


void writedds()
{
  
  while(flag1)
  {
    while(flag2)
    {
      ewb = wb+buffer[wb];
      digitalWrite(CS,LOW);
      for(wb=wb+1;wb<(ewb+1);wb++)
      {
        SPI.transfer(buffer[wb]);
//        Serial.write(buffer[wb]);
      }
      digitalWrite(CS,HIGH);
      flag2=0;
    }
    
    if(wb==lb)
    {
      wb = 0;
      flag1 = 0;
    }
  }
}

void loop()
{
  if(Serial.available()>0)
  {
    loadcomment();
    Serial.write(255);
  }
  
  if(flag1)
  {
    writedds();
  }
}

