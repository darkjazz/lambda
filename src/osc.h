/*
 *  osc.h
 *  lambda
 *
 *  Created by alo on 07/11/2011.
 *  
 *	This file is part of lambda.
 *
 *	lambda is free software: you can redistribute it and/or modify
 *	it under the terms of the GNU General Public License as published by
 *	the Free Software Foundation, either version 3 of the License, or
 *	(at your option) any later version.
 
 *	lambda is distributed in the hope that it will be useful,
 *	but WITHOUT ANY WARRANTY; without even the implied warranty of
 *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *	GNU General Public License for more details.
 
 *	You should have received a copy of the GNU General Public License
 *	along with lambda.  If not, see <http://www.gnu.org/licenses/>. 
 *
 */
#ifndef OSC_H
#define OSC_H

#include "OscSender.h"
#include "OscListener.h"

#include "world.h"
#include "ogl.h"

using namespace ci;
using namespace ci::app;
using namespace std;

class OSCMessenger {

public:
	OSCMessenger(std::string remoteHost, int sendToPort, int receivePort) {
		_remoteHost = remoteHost;
		_sendToPort = sendToPort;
		_receivePort = receivePort;
		_sender.setup(remoteHost, sendToPort);
		_listener.setup(receivePort);
		_receivedQuit = false;
	};
	
	~OSCMessenger() {};
	
	void sendAlive();
	
	void sendStates();
	
	void collectMessages();
	
	void setOgl(GraphicsRenderer *ogl) { _ogl = ogl; };
	
	void setWorld(World *world) { _world = world; };
	
	bool quit() { return _receivedQuit; };
			
private:	
	osc::Sender _sender;
	osc::Listener _listener;
	string _remoteHost;
	int _receivePort, _sendToPort;
	bool _receivedQuit;
	GraphicsRenderer *_ogl;
	World *_world;
	
	Rule* selectRule(R);
};


#endif