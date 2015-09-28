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

#include "osc.h"

#define SCREENX		1440
#define SCREENY		900

class LambdaApp : public AppBasic {
public:
	void prepareSettings(Settings*);	
	void setup();
	void resize();
	void update();
	void draw();
	void shutdown();
    void keyDown( KeyEvent event );

	OSCMessenger *oscMessenger; 
	World *world; 
	GraphicsRenderer *ogl; 
	Rule *rule;
	Boids *boids;
	
private:
	int _winSizeX, _winSizeY;
	int _frameRate, _inport, _outport, _windowMode;
	string _remoteHost;
		
};

void LambdaApp::prepareSettings(Settings *settings) {
	
	vector<string> args;
	int i;
	string myarg;
	
	_winSizeX = 1024;
	_winSizeY = 768;
	_frameRate = 32;
	_remoteHost	= "127.0.0.1";
	_inport = 7000;
	_outport = 57120;
	_windowMode = 0;
	
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
		else if (args[i].compare("-wmode") == 0) {
			_windowMode = atoi(args[i+1].c_str());
		}
	}
	
	settings->setWindowSize( _winSizeX, _winSizeY );

	if (_windowMode == 0)
		settings->setWindowPos( 0, SCREENY - _winSizeY );
	else 
		settings->setWindowPos( SCREENX, SCREENY - _winSizeY);

	settings->setBorderless( true );
	settings->setFrameRate( _frameRate );
		
	oscMessenger = new OSCMessenger(_remoteHost, _outport, _inport);

}

void LambdaApp::resize() {
	ogl->reshape();
}

void LambdaApp::setup()
{
	boids = NULL;
	world = new World();
	ogl = new GraphicsRenderer(world);
	oscMessenger->setOgl(ogl);
	oscMessenger->setWorld(world);
	
	ogl->setupOgl();
	
}

void LambdaApp::update()
{
	Vec3f mean;
	
	if (oscMessenger->quit()) { quit(); }
	
	ogl->update();
	
	oscMessenger->collectMessages();
	
}

void LambdaApp::draw()
{
		
	ogl->startDraw();
		
	if (world->initialized()) {
		
		int x, y, z;
		
		world->prepareNext();
		
		for (x = 0; x < world->sizeX(); x++) {
			for (y = 0; y < world->sizeY(); y++) {
				for (z = 0; z < world->sizeZ(); z++) {
					
					if (world->ruleInitialized)
						world->next(x, y, z);
					if (world->somActivated)
						world->nextSOM(x, y, z);

					ogl->drawFragment(&world->cells[x][y][z]);
				}
			}
		}

		world->finalizeNext();
		
		if (world->bQueryStates()) {
			oscMessenger->sendStates();
		}	
		
	}
	
	boids = oscMessenger->boids();
	
	if (boids) {
//		if (world->somActivated)
//			boids->setCenter(world->bmuVec3f(boids->dimensions()));
		boids->update();
		ogl->drawBoids();
	}
		
	ogl->endDraw();

}

void LambdaApp::keyDown( KeyEvent event )
{
    if( event.getChar() == 'f' || event.getChar() == 'F' ){
        setFullScreen( ! isFullScreen() );
    }
}


void LambdaApp::shutdown() {
	delete ogl;
	delete world;
	delete oscMessenger;
}


CINDER_APP_BASIC( LambdaApp, RendererGl )