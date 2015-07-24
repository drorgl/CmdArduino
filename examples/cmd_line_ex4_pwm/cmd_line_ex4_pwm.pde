/*****************************************************
This is the demo sketch for the command line interface
by FreakLabs. It's a simple command line interface
where you can define your own commands and pass arguments
to them. 
*****************************************************/
#include <Cmd.h>

const char Banner[] = "*************** CMD *******************";
const char Prompt[] = "CMD >> ";
const char BadCommand[] = "CMD: Command not recognized.";

Cmd cmdSerial(&Serial, 50,false, (char*)&Banner, (char*)&Prompt, (char*)&BadCommand);



int pwm_pin = 10;

void setup()
{
  // set the led pin as an output. its part of the demo.
  pinMode(pwm_pin, OUTPUT); 
  
  Serial.begin(57600);
  
  // add the commands to the command table. These functions must
  // already exist in the sketch. See the functions below. 
  // The functions need to have the format:
  //
  // void func_name(int arg_cnt, char **args)
  //
  // arg_cnt is the number of arguments typed into the command line
  // args is a list of argument strings that were typed into the command line
  cmdSerial.Add("pwm", led_pwm);
}

void loop()
{
  cmdSerial.Poll();
}

// This is another example to demonstrate how command line arguments can
// be used when calling your sketch function from the command line. 
//
// This function sets the brightness of an LED on pin 10 via PWM from the 
// command line. If no args are present,then the LED will be turned off.
// 
// Usage: At the command line, to set the brightness, type: 
// pwm 100
//
// This will set the LED brightness to a level of 100 (on a range of 0-255) 
//
// Usage: At the command line, to turn off the LED, type:
// pwm
//
// This will turn off the LED.
// 
// Similar to ex3, when you use numeric arguments, you'll need to convert them
// into integers
void led_pwm(int arg_cnt, char **args)
{
  int pwm_val;
  
  if (arg_cnt > 1)
  {
    // if args are present, then use the first arg as the brightness level
	String str = args[1];
    pwm_val = str.toInt();
    analogWrite(pwm_pin, pwm_val);
  }
  else
  {
    // if no args, turn off the LED
    analogWrite(pwm_pin, 0);
  }
}
