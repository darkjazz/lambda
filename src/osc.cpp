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

void OSCMessenger::sendAlive() {
	
	osc::Message msg;
	
	msg.setAddress("/lambda/world/alive");
	msg.addIntArg( _world->alive() );
	
	msg.setRemoteEndpoint(_remoteHost, _sendToPort);
	_sender.sendMessage(msg);
	
}

void OSCMessenger::sendStates() {
		
	int i;
	
	osc::Message msg;
	msg.setAddress("/lambda/world/states");
	
	for (i = 0; i < _world->getQueryStatesSize(); i++) {
		msg.addFloatArg(_world->getQueryStateAtIndex(i));
	}
		
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
			_world->init(msg.getArgAsInt32(0), msg.getArgAsInt32(1), msg.getArgAsInt32(2), msg.getArgAsInt32(3));
		}
		else if (addr.compare("/lambda/world/interpl") == 0) {
			_world->setInterpolation((Interpolation)msg.getArgAsInt32(0), msg.getArgAsInt32(1));
 		}
		else if (addr.compare("/lambda/world/somvector") == 0) {			
			if (!_world->inputVectorUpdated() && !_world->newBMUFound()) {
				vector<double> inputVector;
				for (i = 0; i < _world->vectorSize(); i++) {
					inputVector.push_back(msg.getArgAsFloat(i));
				}
				_world->setInputVector(inputVector);
			}
 		}
		else if (addr.compare("/lambda/world/rule/init") == 0) {			
			_world->initRule((R)msg.getArgAsInt32(0));
			_world->mapStates();
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
			double* w;
			w = new double[_world->rule()->nSize()];
			for (i = 0; i < _world->rule()->nSize(); i++) {
				w[i] = (double)msg.getArgAsFloat(i);
			}
			_world->rule()->setWeights(w);
			delete [] w;
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
		else if (addr.compare("/lambda/world/query/states") == 0) {
			int* ind;
			ind = new int[msg.getNumArgs()];
			for (i = 0; i < msg.getNumArgs(); i++) {
				ind[i] = msg.getArgAsInt32(i);
			}
			_world->setQueryIndices(ind, msg.getNumArgs());
			delete [] ind;
 		}		
		else if (addr.compare("/lambda/world/query/stop") == 0) {
			_world->stopQuery();
 		}
		else if (addr.compare("/lambda/graphics/rotate") == 0) {
			_ogl->rotateXYZ = Vec3f(
				msg.getArgAsFloat(0),
				msg.getArgAsFloat(1),
				msg.getArgAsFloat(2)
			);
			_ogl->rotateAngle = msg.getArgAsFloat(3);
		}
		else if (addr.compare("/lambda/graphics/view") == 0) {
			_ogl->mEye = Vec3f(
				msg.getArgAsFloat(0),
				msg.getArgAsFloat(1),
				msg.getArgAsFloat(2)
			);
			_ogl->mCenter = Vec3f(
				msg.getArgAsFloat(3),
				msg.getArgAsFloat(4),
				msg.getArgAsFloat(5)
			);
		}
		else if (addr.compare("/lambda/graphics/boidcam") == 0) {
			if (msg.getArgAsInt32(0) == 0)
				_ogl->attachEyeToFirstBoid = false;
			else
				_ogl->attachEyeToFirstBoid = true;
			
			if (msg.getArgAsInt32(1) == 0) 
				_ogl->lookAtCentroid = false;
			else
				_ogl->lookAtCentroid = true;

		}
		else if (addr.compare("/lambda/graphics/background") == 0) {
			_ogl->setBackground(
				msg.getArgAsFloat(0),
				msg.getArgAsFloat(1),
				msg.getArgAsFloat(2)
			);
		}		
		else if (addr.compare("/lambda/graphics/pattern") == 0) {
			_ogl->patternLib[msg.getArgAsInt32(0)].active = (bool)msg.getArgAsInt32(1); 
			_ogl->patternLib[msg.getArgAsInt32(0)].alpha = msg.getArgAsFloat(2); 
			_ogl->patternLib[msg.getArgAsInt32(0)].colormap = msg.getArgAsInt32(3); 
			_ogl->patternLib[msg.getArgAsInt32(0)].alphamap = msg.getArgAsInt32(4);	
			_ogl->patternLib[msg.getArgAsInt32(0)].color.r = msg.getArgAsFloat(5);	
			_ogl->patternLib[msg.getArgAsInt32(0)].color.g = msg.getArgAsFloat(6);	
			_ogl->patternLib[msg.getArgAsInt32(0)].color.b = msg.getArgAsFloat(7);			
		}
		else if (addr.compare("/lambda/boids/init") == 0) {
			if (_boids) {
				delete _boids;
			}
			_boids = new Boids(
			   msg.getArgAsInt32(0),
			   Vec3f(msg.getArgAsFloat(1), msg.getArgAsFloat(2), msg.getArgAsFloat(3)),
			   msg.getArgAsFloat(4),
			   msg.getArgAsFloat(5),
			   msg.getArgAsFloat(6),
			   msg.getArgAsFloat(7),
			   msg.getArgAsFloat(8)
			);
			_ogl->boids = _boids;
		}		
		else if (addr.compare("/lambda/boids/set") == 0) {
			_boids->speed = msg.getArgAsFloat(0);
			_boids->cohesion = msg.getArgAsFloat(1);
			_boids->alignment = msg.getArgAsFloat(2);
			_boids->separation = msg.getArgAsFloat(3);
			_boids->center = msg.getArgAsFloat(4);
		}
		else if (addr.compare("/lambda/boids/kill") == 0) {
			delete _boids;
			_boids = NULL;
			_ogl->boids = NULL;
		}
		else if (addr.compare("/lambda/quit") == 0) {
			_receivedQuit = true;
 		}
	}
}