/*
 *  ogl.cpp
 *  lambda
 *
 *  Created by alo on 01/01/2012.
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

#include "cinder/app/AppBasic.h"
#include "cinder/gl/gl.h"

#include "osc.h"

using namespace ci;
using namespace ci::app;
using namespace std;

class LambdaApp : public AppBasic {
public:
	void prepareSettings( Settings *settings );	
	void setup();
	void update();
	void draw();
	void clear();

	OSCMessenger *oscMessenger; 
	World *world; 
	GraphicsRenderer *ogl; 
	
private:
	int _winSizeX, _winSizeY;
	int _frameRate, _inport, _outport;
	string _remoteHost;
	
};

void LambdaApp::prepareSettings(Settings *settings) {
	
	vector<string> args;
	int i;
	string myarg;
	
	_winSizeX = 800;
	_winSizeY = 600;
	_frameRate = 60;
	_remoteHost	= "127.0.0.1";
	_inport = 7000;
	_outport = 57120;
	
	args = getArgs();
	
	for (i = 1; i < args.size(); i+=2) {
		if (args[i].compare("-screenx") == 0) {
			_winSizeX = atoi(args[i+1].c_str());
		}
		else if (args[i].compare("-screeny") == 0) {
			_winSizeY = atoi(args[i+1].c_str());		
		}
		else if (args[i].compare("-fps") == 0) {
			_frameRate = atoi(args[i+1].c_str());		
		}
		else if (args[i].compare("-remote") == 0) {
			_remoteHost = args[i+1];		
		}
		else if (args[i].compare("-inport") == 0) {
			_inport = atoi(args[i+1].c_str());		
		}
		else if (args[i].compare("-outport") == 0) {
			_outport = atoi(args[i+1].c_str());		
		}
	}	
	
	settings->setWindowSize( _winSizeX, _winSizeY );
	settings->setFrameRate( _frameRate );
	
	oscMessenger = new OSCMessenger(_remoteHost, _outport, _inport);

}

void LambdaApp::setup()
{
	ogl = new GraphicsRenderer(_winSizeX, _winSizeY);
	world = new World();
	oscMessenger->setOgl(ogl);
	oscMessenger->setWorld(world);
	gl::enableDepthRead();
	gl::enableDepthWrite();		
	gl::enableAlphaBlending();
}

void LambdaApp::update()
{
	if (oscMessenger->quit()) { quit(); }
	
	oscMessenger->sendMessage(world->alive());
	oscMessenger->collectMessages();
	
}

void LambdaApp::draw()
{
	// clear out the window with black
	gl::clear( Color( 0, 0, 0 ) ); 
}

void LambdaApp::clear() {
	delete ogl;
	delete world;
	delete oscMessenger;
}


CINDER_APP_BASIC( LambdaApp, RendererGl )