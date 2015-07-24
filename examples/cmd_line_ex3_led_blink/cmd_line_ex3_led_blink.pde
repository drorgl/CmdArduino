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



int led_pin = 13;
bool led_blink_enb = false;
int led_blink_delay_time = 1000;

void setup()
{
  // set the led pin as an output. its part of the demo.
  pinMode(led_pin, OUTPUT); 
  
  Serial.begin(57600);
  
  // add the commands to the command table. These functions must
  // already exist in the sketch. See the functions below. 
  // The functions need to have the format:
  //
  // void func_name(int arg_cnt, char **args)
  //
  // arg_cnt is the number of arguments typed into the command line
  // args is a list of argument strings that were typed into the command line
  cmdSerial.Add("blink", led_blink);
}

void loop()
{
  cmdSerial.Poll();
  
  // This is where the blinking happens. The led_blink function
  // only controls the delay time and whether to enable the blinking
  // action or not. 
  // One thing to be careful of is having delays in the loop() function.
  // This will slow down the response time of the command line since
  // the loop() function needs to get past the delays before it can
  // check for any commands at the command line. 
  if (led_blink_enb)
  {
    digitalWrite(led_pin, HIGH);    // set the LED on
    delay(led_blink_delay_time);    // wait for a second
    digitalWrite(led_pin, LOW);     // set the LED off
    delay(led_blink_delay_time);     
  }
}

// Blink the LED. This is an example of using command line arguments
// to call a function in a sketch.
// If a numeric arg is specified, then use that to set the 
// delay time. If called with no arguments, then turn the LED off.
//
// Usage: At the command line, to blink the LED, type:
// blink 100
// 
// This blinks the LED with a 100 msec on/off time. 
//
// Usage: At the command line, to turn off the LED, type:
// blink
//
// Calling the function with no arguments will turn off the LED
//
// Since the numeric arg is stored as an ASCII string, it needs to be 
// converted to an integer. 
void led_blink(int arg_cnt, char **args)
{
  if (arg_cnt > 1)
  {
	String str(args[1]);
    led_blink_delay_time = str.toInt();
    led_blink_enb = true;
  }
  else
  {
    led_blink_enb = false;
  } 
}


