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

void setup()
{
  Serial.begin(57600);
  
  
  // add the commands to the command table. These functions must
  // already exist in the sketch. See the functions below. 
  // The functions need to have the format:
  //
  // void func_name(int arg_cnt, char **args)
  //
  // arg_cnt is the number of arguments typed into the command line
  // args is a list of argument strings that were typed into the command line
  cmdSerial.Add("hello", hello);
}

void loop()
{
  cmdSerial.Poll();
}

// Print "hello world" when called from the command line.
// Usage: At the command line, type:
// hello
//
// That's it. 
void hello(int arg_cnt, char **args)
{
  Serial.println("Hello world.");
}
