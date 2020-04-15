#include <DueTimer.h>

/*ARDUINO SKETCH TO TRIGGER SOUND STIMULUS EVOKED ESCAPES
Arduino due is used to trigger the camera which has to be in "external trigger" mode
i.e. each frame is triggered separately by a 3.3V TTL pulse. Only the capture of a frame is 
triggered, the exposure is set in the camera software

A sine wave stimulus is send to the digital to analog converter after a given delay from the
start of the trail. Delay, duration and frequency are defined by the user.

The sine output is supposed to be used as an input to MAX9744 amplifier
the volume of the amplifier is controlled by the arduino and can be set in the sketch*/

#include <DueTimer.h>
#include <Wire.h>

//PARAMETERS TO SET UP THE STIMULATION

/*Time of a single trial in milliseconds
must be bigger than stimDelay + stimDuration*/
//#define trialTime 1100

/*Frequency at which the data is acquired in samples/second (should not be set to more 
than 10 kHz without further testing)*/
#define sampleFreq 2000

/*Frame rate at which the camera takes pictures in frames/second.
Has to be smaller or equal to maximum frame rate for the given camera setting
otherwise frames get chopped of*/
#define frameRate1 100
#define frameRate2 650
/*Define different periode duration in milisenconds*/
#define Period1_Duration 0
#define Period2_Duration 1000
#define Period3_Duration 0



//
/*Delay from the beginning of the trial in milliseconds at which the stimulus is supposed to happen*/
#define stimDelay 200

/*stimulus duration in miliseconds*/
#define stimDuration 5 //10

/*stimulus Frequnecy in Hz*/
#define stimFreq 500

/*stimulus amplitude for amplifier
must be a value between 0 and 63*/
#define vol 45

/*other definitions*/
#define Pi 3.14159265359
#define MAX9744_I2CADDR 0x4B

int ledPin = 13;
int triggerOutPin = 53;
int strobeInPin = 41;
int buttonPin = 30;
int buttonLedPin = 3;
int mutePin = 40;

int pulse = 0;
int k = 0;

const int trialTime = Period1_Duration+Period2_Duration+Period3_Duration;

const int samplePeriod1 = int(sampleFreq / frameRate1);
const int samplePeriod2 = int(sampleFreq / frameRate2);
const int samplePeriod3 = int(sampleFreq / frameRate1);
 
const int nSamples = trialTime * sampleFreq / 1000;
const int stimSamples = stimDuration * sampleFreq / 1000;
const int bufferSize = 100;

//define the buffer for the three variables to send over usb
volatile int timing[bufferSize];
volatile int sigRead[bufferSize];
volatile boolean strobeRead[bufferSize];

//define the array of the output signal
volatile int analogOut[stimSamples];
float wave;
volatile unsigned int i = 0;

void setup() {
  
  //setup pins
  pinMode(ledPin, OUTPUT);
  pinMode(buttonLedPin, OUTPUT);
  pinMode(triggerOutPin, OUTPUT);
  digitalWrite(triggerOutPin, LOW);
  pinMode(strobeInPin, INPUT);
  pinMode(buttonPin,INPUT_PULLUP);
  //digitalWrite(mutePin,LOW);
  
  //setup Timer
  Timer0.attachInterrupt(daq);
  Timer0.setFrequency(sampleFreq);
//  

//Serial.begin(250000);
//while(!Serial);
  
  //generate sound wave
  for(k = 0; k<stimSamples; k++){
    wave = 1000 + sin((2*Pi / sampleFreq)*k*stimFreq)*1000;  //int values to pass to the DAC are between 0 and 1000
    analogOut[k] = int(wave);
  }
  analogWriteResolution(12);
  
  //start communication with Amp and set volume
  Wire.begin();
  Wire.beginTransmission(MAX9744_I2CADDR);
  Wire.write(vol);
  Wire.endTransmission();
}


void daq(){
  if(i<nSamples){
    
    //trigger the camera for Period1_Duration
    if(((i % samplePeriod1) == 0) && (i< (Period1_Duration* sampleFreq / 1000 ))){
     digitalWrite(triggerOutPin,HIGH);
    }
    else{
     digitalWrite(triggerOutPin,LOW);
     } 

    //trigger the camera for Period2_Duration
    if(((i % samplePeriod2)== 0) && ((i>= (Period1_Duration* sampleFreq / 1000)) && (i<= ((Period1_Duration+Period2_Duration)* sampleFreq / 1000))) ){
     digitalWrite(triggerOutPin,HIGH);
    }
    else{
     digitalWrite(triggerOutPin,LOW);
     }

    
    //output the sound at the stimulus position
    if((i <(Period1_Duration+stimDelay )* sampleFreq / 1000) || (i >= ((Period1_Duration+stimDelay +stimDuration)* sampleFreq / 1000))){
      analogWrite(DAC0,0);
      //digitalWrite(mutePin,LOW);
    }
    else{
      //digitalWrite(mutePin,HIGH);
      analogWrite(DAC1,analogOut[(i-(Period1_Duration+stimDelay*sampleFreq/1000))]);
    }


      //trigger the camera for Period3_Duration
    if(((i % samplePeriod3)== 0) && ((i> (Period1_Duration+Period2_Duration)* sampleFreq / 1000) || (i<= ((Period1_Duration+Period2_Duration+Period3_Duration)* sampleFreq / 1000))) ){
     digitalWrite(triggerOutPin,HIGH);
    }
    else{
     digitalWrite(triggerOutPin,LOW);
     }
    i = i + 1;


    
    
    /* CURRENTLY UNUSED*/
    //purge the buffer when it's full
//    if((i % bufferSize) == (bufferSize - 1)){
//     SerialUSB.write((const uint8_t*)(&timing),sizeof(timing));
//     SerialUSB.write((const uint8_t*)(&sigRead),sizeof(sigRead));
//     SerialUSB.write((const uint8_t*)(&strobeRead),sizeof(strobeRead));
//    }
  }

}
  
void loop() {
  while(digitalRead(buttonPin) == HIGH){
////pulse button LED while waiting for buton press
//    analogWrite(buttonLedPin,(int(sin(pulse*2*Pi/2000))*125+125));
//
//    pulse = pulse + 1;
//    delay(1);
  Wire.begin();
  Wire.beginTransmission(MAX9744_I2CADDR);
  Wire.write(0);
  Wire.endTransmission();
//digitalWrite(mutePin,LOW);
digitalWrite( buttonLedPin, HIGH);
delay(1);
    }
      Wire.begin();
  Wire.beginTransmission(MAX9744_I2CADDR);
  Wire.write(vol);
  Wire.endTransmission();
pulse=0;


  digitalWrite(ledPin,LOW);  //set the switch the LEDs on
  digitalWrite(buttonLedPin,LOW);
  //digitalWrite(triggerOutPin, HIGH);
    Timer0.start();             //start timer for the acquisition
  while(i < nSamples){
    // do nothing while trial is running
  }
    Timer0.stop();             //stop acquisition
  //digitalWrite(triggerOutPin, LOW);
  digitalWrite(ledPin,LOW);      //switch the LEDs of 
  digitalWrite(buttonLedPin,LOW);
  Wire.begin();
  Wire.beginTransmission(MAX9744_I2CADDR);
  Wire.write(0);
  Wire.endTransmission();
  

  i = 0;                      //reset counter
}
