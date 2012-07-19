/*
 *  ogl.h
 *  lambda
 *
 *  Created by alo on 22/04/2011.
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
#ifndef OGL_H
#define OGL_H

#include "cinder/app/AppBasic.h"
#include "cinder/gl/gl.h"
#include "cinder/Camera.h"
#include "cinder/Surface.h"
#include "cinder/gl/Texture.h"
#include "cinder/ImageIo.h"
#include "cinder/gl/GlslProg.h"
#include "cinder/gl/DisplayList.h"


#include "world.h"
#include "boids.h"

using namespace ci;
using namespace ci::app;

//const double pi = 3.1415926535;

const int numPatterns = 16;

struct pattern {

	bool active; 
	double alpha;
	int colormap;
	int alphamap;
	Color color;
	
	pattern(): active(false), alpha(0), colormap(0), alphamap(0) { color = Color(0.0, 0.0, 0.0); };
	~pattern() {};
};


class GraphicsRenderer {

public:
	GraphicsRenderer(World* world) {
		patternLib = new pattern[numPatterns];
		rotateXYZ = Vec3f( 1.0f, 0.0f, 0.0f);
		rotateAngle = 0.0f;
		ptrWorld = world;
	};
	
	~GraphicsRenderer() {
		delete [] patternLib;
		delete [] rowColors;
		delete [] rowNormals;
		delete [] rowVertices;		
	};
	
	pattern* patternLib;	
	
	// *** OpenGL global setup  *** //

	void setupOgl();
	
	void reshape();
	
	// *** draw cells *** //
	
	void startDraw();
	
	void endDraw();
	
	void drawFragment(Cell*);
		
	void update();
	
	void setBackground(float r, float g, float b) {
		_bgr = r; _bgg = g; _bgb = b;
	};
	
	void drawBoids(Boids*);
	void drawBoidWorldBorders(Boids*);
	
	Vec3f rotateXYZ;
	
	float rotateAngle;
	
	CameraPersp mCam;	
	Matrix44f mRotation;
	
	Vec3f mEye, mCenter, mUp;
	
	float mDirectional;
	Vec2f mMousePos;	
		
private:
	
	double fragSizeX, fragSizeY, fragSizeZ, state;
	float xL, yB, zF, xW, yH, zD, red, green, blue, alpha;
	int currentIndex, vectorSize;
	Cell* currentCell;
	Cell* ptrBMU;
	World* ptrWorld;
	float _bgr, _bgg, _bgb;
	
	GLfloat *rowVertices, *worldVertices, *rowNormals, *worldNormals, *rowColors, *worldColors;
	
//	Surface8u _img;
//	gl::GlslProg _wallShader;
//	gl::DisplayList _walls;
//	unsigned int _textObj;
	
	void pattern00(int, int, int);

	void pattern01(int, int, int);
	
	void pattern02(int, int, int);
	
	void pattern03(int, int, int);

	void pattern04(int, int, int);
	
	void pattern05(int, int, int);
	
	void pattern06(int, int, int);
	
	void pattern07(int, int, int);
	
	void pattern08(int, int, int);
	
	void pattern09(int, int, int);

	void pattern10(int, int, int);
	
	void pattern11(int, int, int);
	
	void pattern12(int, int, int);
	
	void pattern13(int, int, int);
	
	void pattern14(int, int, int);

	void pattern15(int, int, int);
	
	// *** basic drawing functions *** //
	
	void fillRect (int);
	
	void strokeRect (int, float);
	
	void drawPoint (float, float, float, float);
	
	void drawLine (float, float, float, float, float, float, float);
	
	void drawCircle (int, float, int, bool);
	
	void strokeRectArray();
	
};

#endif