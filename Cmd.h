/*******************************************************************
    Copyright (C) 2009 FreakLabs
    All rights reserved.

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions
    are met:

    1. Redistributions of source code must retain the above copyright
       notice, this list of conditions and the following disclaimer.
    2. Redistributions in binary form must reproduce the above copyright
       notice, this list of conditions and the following disclaimer in the
       documentation and/or other materials provided with the distribution.
    3. Neither the name of the the copyright holder nor the names of its contributors
       may be used to endorse or promote products derived from this software
       without specific prior written permission.

    THIS SOFTWARE IS PROVIDED BY THE THE COPYRIGHT HOLDERS AND CONTRIBUTORS ``AS IS'' AND
    ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
    IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
    ARE DISCLAIMED.  IN NO EVENT SHALL THE INSTITUTE OR CONTRIBUTORS BE LIABLE
    FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
    DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
    OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
    HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
    LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
    OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
    SUCH DAMAGE.

    Originally written by Christopher Wang aka Akiba.
    Please post support questions to the FreakLabs forum.

*******************************************************************/
/*!
    \file 
    \ingroup


*/
/**************************************************************************/
#ifndef CMD_H
#define CMD_H

#define MAX_MSG_SIZE    80
#include <stdint.h>
#include <Stream.h>

// command line structure
typedef struct _cmd_t
{
	char *cmd;
	void(*func)(int argc, char **argv);
	struct _cmd_t *next;
} cmd_t;

class Cmd{
private:
	Stream *_stream;
	uint8_t _maxMessageSize;
	char * _msg;
	char *_msg_ptr;

	cmd_t *cmd_tbl_list, *cmd_tbl;

	const char * _banner;
	const char * _prompt;
	const char * _unrecognized;

	bool _echo;

	void parse(char *cmd);
	void handler();

	bool(*_catchall)(char * line);
public:
	Cmd(Stream *stream, int maxMessageSize, bool echo,const  char * banner,const char * prompt,const char* unrecognize);

	//displays the prompt
	void display();

	//should be called every loop cycle
	void Poll();

	//add a new command handler
	void Add(const char *name, void(*func)(int argc, char **argv));

	void SetCatchAll(bool(*func)(char * line));
};

#endif //CMD_H
