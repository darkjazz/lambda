/*
 *  osc.cpp
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

#include "osc.h"

void OSCMessenger::sendMessage(int alive) {
	osc::Message msg;
	
	msg.setAddress("/lambda/world/alive");
	msg.addIntArg(alive);
	
	msg.setRemoteEndpoint(_remoteHost, _sendToPort);
	_sender.sendMessage(msg);
}

void OSCMessenger::collectMessages() {
	string addr; int i;
	while (_listener.hasWaitingMessages()) {
		osc::Message msg;
		_listener.getNextMessage(&msg);
		addr = msg.getAddress();
		
		if (addr.compare("/lambda/world/init") == 0) {
			_world->init(msg.getArgAsInt32(0), msg.getArgAsInt32(1), msg.getArgAsInt32(2));
		}
		else if (addr.compare("/lambda/world/rule/init") == 0) {
			_world->initRule((R)msg.getArgAsInt32(0));
 		}
		else if (addr.compare("/lambda/world/rule/births") == 0) {
			int *b;
			b = new int[msg.getNumArgs()];
			for (i = 0; i < msg.getNumArgs(); i++) {
				b[i] = msg.getArgAsInt32(i);
			}
			_world->rule()->setBirths(b);
			delete [] b;
		}
		else if (addr.compare("/lambda/world/rule/survivals") == 0) {
			int *s;
			s = new int[msg.getNumArgs()];
			for (i = 0; i < msg.getNumArgs(); i++) {
				s[i] = msg.getArgAsInt32(i);
			}
			_world->rule()->setSurvivals(s);
			delete [] s;
		}
		else if (addr.compare("/lambda/world/rule/states") == 0) {
			_world->rule()->setStates(msg.getArgAsInt32(0));
		}
		else if (addr.compare("/lambda/world/rule/add") == 0) {
			_world->rule()->setAdd((double)msg.getArgAsFloat(0));
		}
		else if (addr.compare("/lambda/world/rule/weights") == 0) {
			vector<double> v; 
			int size;
			if (_world->sizeZ() > 1) 
				size = 26;
			else
				size = 8;
			for (i = 0; i < size; i++) {
				v.push_back((double)msg.getArgAsFloat(i));
			}
			_world->rule()->setWeights(v);
		}
		else if (addr.compare("/lambda/world/reset/rand") == 0) {
			bool include;
			if (msg.getArgAsInt32(7) == 1) 
			{	include = true; }
			else
			{	include = false; }
			
			_world->initRandInArea(
								   msg.getArgAsInt32(0), 
								   msg.getArgAsInt32(1), 
								   msg.getArgAsInt32(2), 
								   msg.getArgAsInt32(3), 
								   msg.getArgAsInt32(4), 
								   msg.getArgAsInt32(5), 
								   _world->rule()->numStates() - 1,
								   msg.getArgAsFloat(6), 
								   include
								   );
		}
		else if (addr.compare("/lambda/world/reset/wirecube") == 0) {
			_world->initWireCube(
								 msg.getArgAsInt32(0), 
								 msg.getArgAsInt32(1), 
								 msg.getArgAsInt32(2), 
								 msg.getArgAsInt32(3), 
								 msg.getArgAsInt32(4), 
								 msg.getArgAsInt32(5) 
								 );
		}		
		else if (addr.compare("/lambda/quit") == 0) {
			_receivedQuit = true;
 		}
	}
}