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

#include <OpenGL/OpenGL.h>
#include <GLUT/GLUT.h>
#include "world.h"

const int numPatterns = 16;

struct pattern {

	bool active; 
	double alpha;
	
	pattern(): active(false), alpha(0) {};
	~pattern() {};
};


class GraphicsRenderer {

public:
	GraphicsRenderer(int winWidth, int winHeight) {
		patternLib = new pattern[numPatterns];
		fragSizeX = (double)(winWidth / world->sizeX()) * 0.1;
		fragSizeY = (double)(winHeight / world->sizeY()) * 0.1;
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
	
	void reshape(double, double);
	
	void prepareFrame();

	// *** draw cells *** //

	void drawFragment(Cell*, Cell*, int, int);
	
	void drawRow();
	
	void drawWorld();
		
private:
	
	double fragSizeX, fragSizeY, state;
	float xL, yB, zF, xW, yH, zD, red, green, blue, alpha;
	int currentIndex, vectorSize;
	Cell* currentCell;
	Cell* ptrBMU;
	World* world;
	
	GLfloat *rowVertices, *worldVertices, *rowNormals, *worldNormals, *rowColors, *worldColors;
	
	bool _drawRow, _drawWorld;

	void pattern00(int, int);

	void pattern01(int, int);
	
	void pattern02(int, int);
	
	void pattern03(int, int);

	void pattern04(int, int);
	
	void pattern05(int, int);
	
	void pattern06(int, int);
	
	void pattern07(int, int);
	
	void pattern08(int, int);
	
	void pattern09(int, int);

	void pattern10(int, int);
	
	void pattern11(int, int);
	
	void pattern12(int, int);
	
	void pattern13(int, int);
	
	void pattern14(int, int);

	void pattern15(int, int);

	// *** basic drawing functions *** //
	
	void fillRect (int);
	
	void strokeRect (int, float);
	
	void drawPoint (float, float, float, float);
	
	void drawLine (float, float, float, float, float, float, float);
	
	void drawCircle (int, float, int, bool);
	
	void strokeRectArray();
	
};

#endif