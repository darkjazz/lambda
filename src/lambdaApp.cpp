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
#include "bit.h"

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
    BitalinoCtr *bitalino;
	
private:
	int _winSizeX, _winSizeY;
	int _frameRate, _inport, _outport, _windowMode;
	string _remoteHost;
    string _bitMacAddress;
    int _bitFrameRate;
		
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
    _bitMacAddress = "/dev/tty.bitalino-DevB";
    _bitFrameRate = 100;
	
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
    //bitalino = new BitalinoCtr(_bitMacAddress, _bitFrameRate);
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
/*
        if (bitalino->activated) {
            std::stringstream fmt;
            fmt << "Mean: " << bitalino->mean;
            ogl->codePanel.putLine(0, fmt.str());
            fmt << "Variance: " << bitalino->variance;
            ogl->codePanel.putLine(1, fmt.str());
            fmt << "Std dev: " << bitalino->stdDev;
            ogl->codePanel.putLine(2, fmt.str());
            ogl->codePanel.show = true;
//            world->rule()->setAdd(bitalino->mapValues());
        }
*/
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
    if( event.getChar() == 'f' || event.getChar() == 'F' ) {
        setFullScreen( ! isFullScreen() );
        if (isFullScreen()) { hideCursor(); }
        else { showCursor(); }
    }
/*
    if( event.getChar() == 'b' || event.getChar() == 'B' ) {
        bitalino->activated = !bitalino->activated;
        if (bitalino->activated) {
            bitalino->connect();
            bitalino->start();
        }
        else {
            bitalino->stop();
        }
    }
*/
}


void LambdaApp::shutdown() {
	delete ogl;
	delete world;
	delete oscMessenger;
    //delete bitalino;
}


CINDER_APP_BASIC( LambdaApp, RendererGl )