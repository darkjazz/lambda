/*
 *  ogl.cpp
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

#include "ogl.h"

void GraphicsRenderer::setupOgl () {
	
	mEye = Vec3f(0.0f, 0.0f, -30.0f);
	mCenter = Vec3f::zero();
	mUp = Vec3f::yAxis();
	
	mCam.lookAt(mEye, mCenter, mUp);
	mRotation.setToIdentity();	
	
	gl::enableDepthRead();
	gl::enableDepthWrite();		
	gl::enableAlphaBlending();	
	
	_bgr = _bgg = _bgb = 0.0;
	
	gl::clear( Color( _bgr, _bgg, _bgb ) );	
	
//	_wallShader = gl::GlslProg(loadResource("wall_vert.glsl"), loadResource("wall_frag.glsl"));
//	_img = Surface8u( loadImage(loadResource("fx_parallels.jpg")) );
//	
//	glGenTextures(1, &_textObj);
//	glBindTexture(GL_TEXTURE_CUBE_MAP, _textObj);
//	glTexImage2D(GL_TEXTURE_CUBE_MAP, 0, GL_RGBA, GLsizei(512), GLsizei(512), 0, GL_RGB, GL_UNSIGNED_BYTE, _img.getData());
//	
//	_walls = gl::DisplayList( GL_COMPILE );
//	_walls.newList();	
//	gl::drawCube( Vec3f(200.0, 200.0, 200.0), Vec3f(400.0, 400.0, 400.0) );
//	_walls.endList();
	
}

void GraphicsRenderer::reshape() {

	mCam.setPerspective(45.0, getWindowAspectRatio(), 0.1f, 1000.0f);
	gl::setMatrices( mCam );	

}

void GraphicsRenderer::update() {
	
	if (ptrWorld->initialized()) {
	
		fragSizeX = (double)(getWindowWidth() / ptrWorld->sizeX()) * 0.1;
		fragSizeY = (double)(getWindowHeight() / ptrWorld->sizeY()) * 0.1;
		fragSizeZ = (double)(getWindowWidth() / ptrWorld->sizeZ()) * 0.1;	
			
	}
	
	mRotation.rotate( rotateXYZ, rotateAngle );
	
	mCam.lookAt( mEye, mCenter, mUp );
	gl::setMatrices( mCam );
	
	gl::clear( Color( _bgr, _bgg, _bgb ) );

}

void GraphicsRenderer::startDraw() {
	
//	glEnable(GL_TEXTURE_2D);
	
	gl::pushMatrices();
	gl::multModelView( mRotation );
}

void GraphicsRenderer::endDraw() {
	gl::popMatrices();
}

void GraphicsRenderer::drawFragment(Cell* cell) {
	
	int x, y, z;
	currentCell = cell;
	x = currentCell->x;
	y = currentCell->y;
	z = currentCell->z;
	
	state = currentCell->phase;

	if (patternLib[0].active) {
		pattern00(x, y, z);
	}
	if (patternLib[1].active) {
		pattern01(x, y, z);	
	}
	if (patternLib[2].active) {
		pattern02(x, y, z);	
	}
	if (patternLib[3].active) {
		pattern03(x, y, z);	
	}
	if (patternLib[4].active) {
		pattern04(x, y, z);	
	}
	if (patternLib[5].active) {
		pattern05(x, y, z);	
	}
	if (patternLib[6].active) {
		pattern06(x, y, z);	
	}
	if (patternLib[7].active) {
		pattern07(x, y, z);	
	}
	if (patternLib[8].active) {
		pattern08(x, y, z);	
	}
	if (patternLib[9].active) {
		pattern09(x, y, z);	
	}
	if (patternLib[10].active) {
		pattern10(x, y, z);	
	}
	if (patternLib[11].active) {
		pattern11(x, y, z);	
	}
	if (patternLib[12].active) {
		pattern12(x, y, z);	
	}
	if (patternLib[13].active) {
		pattern13(x, y, z);	
	}
	if (patternLib[14].active) {
		pattern14(x, y, z);	
	}
	if (patternLib[15].active) {
		pattern15(x, y, z);	
	}
	
}

void GraphicsRenderer::pattern00(int x, int y, int z) {
	
	float hx, hy;
		
	hx = fragSizeX * ptrWorld->sizeX() * 0.5;
	hy = fragSizeX * ptrWorld->sizeY() * 0.5;
	
	xL = (float)x * fragSizeX + (fragSizeX * 0.5) - (fragSizeX * 2.0 * state);
	yB = (float)y * fragSizeX + (fragSizeY * 0.5) - (fragSizeY * 2.0 * state);
	zF = (float)z * fragSizeZ + (fragSizeZ * 0.5) - (fragSizeZ * 2.0 * state);
	
	xW = fragSizeX * state * 4.0;
	yH = fragSizeX * state * 4.0;
	zD = fragSizeZ * state * 4.0;
	
	xL -= hx;
	yB -= hy;
	zF -= hx;
	
	red = patternLib[0].color.r * abs(patternLib[0].colormap - state);
	green = patternLib[0].color.g * abs(patternLib[0].colormap - state);
	blue = patternLib[0].color.b * abs(patternLib[0].colormap - state);
	alpha = patternLib[0].alpha * abs(patternLib[0].alphamap - state);
	
	if (x == 0) { 
		strokeRect(1, 1.0);
	}
	
	if (y == 0) {
		strokeRect(2, 1.0);
	}
	
	if (z == 0) {
		strokeRect(0, 1.0);
	}
			
	if (x == ptrWorld->sizeX()-1 && y < ptrWorld->sizeY()-1 && z < ptrWorld->sizeZ()-1) {
		xL += (xW * state);
		strokeRect(1, 1.0);
	}
	if (y == ptrWorld->sizeY()-1 && z < ptrWorld->sizeZ()-1 && x < ptrWorld->sizeX()-1) {
		yB += (yH * state);
		strokeRect(2, 1.0);
	}	
	if (z == ptrWorld->sizeZ()-1 && x < ptrWorld->sizeX()-1 && y < ptrWorld->sizeY()-1) {
		zF += (zD * state);
		strokeRect(0, 1.0);	
	}
	
	
}

void GraphicsRenderer::pattern01(int x, int y, int z) {
	float hx, hy;
	
	hx = fragSizeX * ptrWorld->sizeX() * 0.5;
	hy = fragSizeX * ptrWorld->sizeY() * 0.5;
	
	xL = (float)x * fragSizeX + (fragSizeX * 0.5) - (fragSizeX * 2.0 * state);
	yB = (float)y * fragSizeX + (fragSizeY * 0.5) - (fragSizeY * 2.0 * state);
	zF = (float)z * fragSizeZ + (fragSizeZ * 0.5) - (fragSizeZ * 2.0 * state);
	
	xW = mapf(fragSizeX * state, 0.5, 2.0);
	yH = mapf(fragSizeX * state, 0.5, 2.0);
	zD = mapf(fragSizeX * state, 0.5, 2.0);
	
	xL -= hx;
	yB -= hy;
	zF -= hx;
	
	red = patternLib[1].color.r * abs(patternLib[1].colormap - state);
	green = patternLib[1].color.g * abs(patternLib[1].colormap - state);
	blue = patternLib[1].color.b * abs(patternLib[1].colormap - state);
	alpha = patternLib[1].alpha * abs(patternLib[1].alphamap - state);
	
	if (x == 0) { 
		fillRect(1);
	}
	
	if (y == 0) {
		fillRect(2);
	}
	
	if (z == 0) {
		fillRect(0);
	}
	
	if (x == ptrWorld->sizeX()-1 && y < ptrWorld->sizeY()-1 && z < ptrWorld->sizeZ()-1) {
		xL += (xW * state);
		fillRect(1);
	}
	if (y == ptrWorld->sizeY()-1 && z < ptrWorld->sizeZ()-1 && x < ptrWorld->sizeX()-1) {
		yB += (yH * state);
		fillRect(2);
	}	
	if (z == ptrWorld->sizeZ()-1 && x < ptrWorld->sizeX()-1 && y < ptrWorld->sizeY()-1) {
		zF += (zD * state);
		fillRect(0);	
	}
	
}

void GraphicsRenderer::pattern02(int x, int y, int z) {
	float hx, hy;

	bool draw;
	
	draw = false;
			
	if (
		((x < ptrWorld->sizeX()*0.5 && y < ptrWorld->sizeY()*0.5) || (x >= ptrWorld->sizeX()*0.5 && y >= ptrWorld->sizeY()*0.5)) && 
		((!isEven(x) || isEven(y)) && (isEven(x) || !isEven(y))) &&
		isEven(z)
		)
	{
		draw = true;
	}
	
	if (
		((x >= ptrWorld->sizeX()*0.5 && y < ptrWorld->sizeY()*0.5) || (x < ptrWorld->sizeX()*0.5 && y >= ptrWorld->sizeY()*0.5)) && 
		((isEven(x) || isEven(y)) && (!isEven(x) || !isEven(y))) &&
		isEven(z)
		)
	{
		draw = true;
	}
	if (y > 5 && y < 10 && x > 5 && x < 10) { draw = false; }
	if (draw)
	{
		
		hx = fragSizeX * ptrWorld->sizeX() * 0.5;
		hy = fragSizeX * ptrWorld->sizeY() * 0.5;
		
		xL = (float)x * fragSizeX + (fragSizeX * 0.5); //- (fragSizeX * 10.0 * state);
		yB = (float)y * fragSizeX + (fragSizeY * 0.5); //- (fragSizeY * 2.0 * state);
		zF = (float)z * fragSizeX + (fragSizeZ * 0.5); //- (fragSizeZ * 2.0 * state);
		
		xL -= hx;
		yB -= hx;
		zF -= hx;		
		
		xW = mapf(fragSizeX * state, 0.5, 10.0);
		yH = mapf(fragSizeX * state, 0.5, 2.0);
		zD = mapf(fragSizeX * state, 0.5, 2.0);
		
		red = patternLib[2].color.r * abs(patternLib[2].colormap - state);
		green = patternLib[2].color.g * abs(patternLib[2].colormap - state);
		blue = patternLib[2].color.b * abs(patternLib[2].colormap - state);
		alpha = patternLib[2].alpha * abs(patternLib[2].alphamap - state);
		
		gl::color(red, green, blue, alpha);
		
		if (state > 0.33f) gl::drawStrokedCube( Vec3f(xL, yB, zF), Vec3f(xW, yH, zD) );
		else gl::drawCube( Vec3f(xL, yB, zF), Vec3f( xW, yH, zD) );
		
	}
	
}

void GraphicsRenderer::pattern03(int x, int y, int z) {
	
	if ( x%5==0 && y%5==0 && z%7==0 ) {
	
		float hx, ex, ey, ez, lineWidth, scale;
		
		lineWidth = mapf(state, 1.0, 4.0);
		
		scale = 2.0;
		
		hx = fragSizeX * ptrWorld->sizeX() * 0.5;
			
		xL = (float)x * fragSizeX + (fragSizeX * 0.5); 
		yB = (float)y * fragSizeX + (fragSizeX * 0.5); 
		zF = (float)z * fragSizeX + (fragSizeX * 0.5);
		
		xL -= hx;
		yB -= hx;
		zF -= hx;		
				
		xW = fragSizeX * state * 2.0;
		yH = fragSizeX * state;
		zD = fragSizeX * state;
		
		ex = fragSizeX * 4.0 * sinf( (state * 2.0 * PI) );
		ey = fragSizeX * 2.0 * cosf( (state * 2.0 * PI) );
		ez = fragSizeX * 2.0 * sinf( (state * 2.0 * PI) );
				
		red = patternLib[3].color.r * abs(patternLib[3].colormap - state);
		green = patternLib[3].color.g * abs(patternLib[3].colormap - state);
		blue = patternLib[3].color.b * abs(patternLib[3].colormap - state);
		alpha = patternLib[3].alpha * abs(patternLib[3].alphamap - state);
				
		gl::color(red, green, blue, alpha);	
					
		gl::drawCube( Vec3f(xL, yB, zF), Vec3f( ex, ey, ez ) );
		
	}
	
	if ( (z-2)%7==0 && (x-2)%5==0 && (y-2)%5==0 ) {
		
		float hx, ex, ey, ez, lineWidth, scale;
		
		lineWidth = mapf(state, 1.0, 4.0);
		
		scale = 2.0;
		
		hx = fragSizeX * ptrWorld->sizeX() * 0.5;
		
		xL = (float)x * fragSizeX + (fragSizeX * 0.5); 
		yB = (float)y * fragSizeX + (fragSizeX * 0.5); 
		zF = (float)z * fragSizeX + (fragSizeX * 0.5);
		
		xL -= hx;
		yB -= hx;
		zF -= hx;		
		
		xW = fragSizeX * state;
		yH = fragSizeX * state * 2.0;
		zD = fragSizeX * state;
		
		ex = fragSizeX * 2.0 * sinf( (state * 2.0 * PI) );
		ey = fragSizeX * 4.0 * sinf( (state * 2.0 * PI) );
		ez = fragSizeX * 2.0 * cosf( (state * 2.0 * PI) );
		
		red = patternLib[3].color.r * abs(patternLib[3].colormap - state);
		green = patternLib[3].color.g * abs(patternLib[3].colormap - state);
		blue = patternLib[3].color.b * abs(patternLib[3].colormap - state);
		alpha = patternLib[3].alpha * abs(patternLib[3].alphamap - state);
		
		gl::color(red, green, blue, alpha);	
		
		gl::drawCube( Vec3f(xL, yB, zF), Vec3f( ex, ey, ez ) );
		
	}

	if ( y%4==0 && z%4==0 && z%4==0 ) {
		
		float hx, ex, ey, ez, lineWidth, scale;
		
		lineWidth = mapf(state, 1.0, 4.0);
		
		scale = 2.0;
		
		hx = fragSizeX * ptrWorld->sizeX() * 0.5;
		
		xL = (float)x * fragSizeX + (fragSizeX * 0.5); 
		yB = (float)y * fragSizeX + (fragSizeX * 0.5); 
		zF = (float)z * fragSizeX + (fragSizeX * 0.5);
		
		xL -= hx;
		yB -= hx;
		zF -= hx;		
		
		xW = fragSizeX * state;
		yH = fragSizeX * state;
		zD = fragSizeX * state * 2.0;
		
		ex = fragSizeX * 2.0 * cosf( (state * 2.0 * PI) );
		ey = fragSizeX * 2.0 * sinf( (state * 2.0 * PI) );
		ez = fragSizeX * 4.0 * sinf( (state * 2.0 * PI) );
		
		red = patternLib[3].color.r * abs(patternLib[3].colormap - state);
		green = patternLib[3].color.g * abs(patternLib[3].colormap - state);
		blue = patternLib[3].color.b * abs(patternLib[3].colormap - state);
		alpha = patternLib[3].alpha * abs(patternLib[3].alphamap - state);
		
		gl::color(red, green, blue, alpha);	
		
		gl::drawCube( Vec3f(xL, yB, zF), Vec3f( ex, ey, ez ) );
		
	}	
	
}

void GraphicsRenderer::pattern04(int x, int y, int z) {
	
	if (x%7==0 && y%5==0 && z%7==0) {
		
		float hx;
				
		hx = fragSizeX * ptrWorld->sizeX() * 0.5;
		
		xL = (float)x * fragSizeX + (fragSizeX * 2.0 * sinf(state * 4.0 * PI)); 
		yB = (float)y * fragSizeX + (fragSizeX * 2.0 * cosf(state * 4.0 * PI)); 
		zF = (float)z * fragSizeX + (fragSizeX * 0.5);
		
		xL -= hx;
		yB -= hx;
		zF -= hx;
				
		red = patternLib[4].color.r * abs(patternLib[4].colormap - state);
		green = patternLib[4].color.g * abs(patternLib[4].colormap - state);
		blue = patternLib[4].color.b * abs(patternLib[4].colormap - state);
		alpha = patternLib[4].alpha * abs(patternLib[4].alphamap - state);
					
		drawPoint(xL, yB, zF, 5.0);
		
		for (int i=0; i < currentCell->history.size(); i++) {
			double oldState;
			oldState = currentCell->history[i];
			red *= 0.8;
			green *= 0.9;
			blue *= 0.9;
			alpha *= 0.95;
			
			xL = (float)x * fragSizeX + (fragSizeX * 2.0 * sinf(oldState * 4.0 * PI)); 
			yB = (float)y * fragSizeX + (fragSizeX * 2.0 * cosf(oldState * 4.0 * PI)); 
			zF = (float)z * fragSizeX + (fragSizeX * 0.5);
			
			xL -= hx;
			yB -= hx;
			zF -= hx;
			
			drawPoint(xL, yB, zF, 2.0);
			
		}
	}
	
	if (x%5==0 && y%7==0 && z%7==0) {
		
		float hx;
		
		hx = fragSizeX * ptrWorld->sizeX() * 0.5;
		
		xL = (float)x * fragSizeX + (fragSizeX * 0.5); 
		yB = (float)y * fragSizeX + (fragSizeX * 2.0 * sinf(state * 4.0 * PI));
		zF = (float)z * fragSizeX + (fragSizeX * 2.0 * cosf(state * 4.0 * PI));
		
		xL -= hx;
		yB -= hx;
		zF -= hx;
		
		red = patternLib[4].color.r * abs(patternLib[4].colormap - state);
		green = patternLib[4].color.g * abs(patternLib[4].colormap - state);
		blue = patternLib[4].color.b * abs(patternLib[4].colormap - state);
		alpha = patternLib[4].alpha * abs(patternLib[4].alphamap - state);
		
		drawPoint(xL, yB, zF, 5.0);
		
		for (int i=0; i < currentCell->history.size(); i++) {
			double oldState;
			oldState = currentCell->history[i];
			red *= 0.8;
			green *= 0.9;
			blue *= 0.9;
			alpha *= 0.95;
			
			xL = (float)x * fragSizeX + (fragSizeX * 0.5); 
			yB = (float)y * fragSizeX + (fragSizeX * 2.0 * sinf(oldState * 4.0 * PI));
			zF = (float)z * fragSizeX + (fragSizeX * 2.0 * cosf(oldState * 4.0 * PI));
			
			xL -= hx;
			yB -= hx;
			zF -= hx;
			
			drawPoint(xL, yB, zF, 2.0);
			
		}
	}
	
	if (x%7==0 && y%7==0 && z%5==0) {
		
		float hx;
		
		hx = fragSizeX * ptrWorld->sizeX() * 0.5;
		
		xL = (float)x * fragSizeX + (fragSizeX * 2.0 * cosf(state * 4.0 * PI)); 
		yB = (float)y * fragSizeX + (fragSizeX * 0.5);
		zF = (float)z * fragSizeX + (fragSizeX * 2.0 * sinf(state * 4.0 * PI));
		
		xL -= hx;
		yB -= hx;
		zF -= hx;
		
		red = patternLib[4].color.r * abs(patternLib[4].colormap - state);
		green = patternLib[4].color.g * abs(patternLib[4].colormap - state);
		blue = patternLib[4].color.b * abs(patternLib[4].colormap - state);
		alpha = patternLib[4].alpha * abs(patternLib[4].alphamap - state);
		
		drawPoint(xL, yB, zF, 5.0);
		
		for (int i=0; i < currentCell->history.size(); i++) {
			double oldState;
			oldState = currentCell->history[i];
			red *= 0.8;
			green *= 0.9;
			blue *= 0.9;
			alpha *= 0.95;
			
			xL = (float)x * fragSizeX + (fragSizeX * 2.0 * cosf(oldState * 4.0 * PI)); 
			yB = (float)y * fragSizeX + (fragSizeX * 0.5);
			zF = (float)z * fragSizeX + (fragSizeX * 2.0 * sinf(oldState * 4.0 * PI));
			
			xL -= hx;
			yB -= hx;
			zF -= hx;
			
			drawPoint(xL, yB, zF, 2.0);
			
		}
	}
	
	
}

void GraphicsRenderer::pattern05(int x, int y, int z) {
	int i;
	float ex, ey, ez;
	float hx, hy;
	
	if (
		(	x != 0 && y != 0 && z != 0 && 
		 x != ptrWorld->sizeX()-1 && y != ptrWorld->sizeY()-1 && z != ptrWorld->sizeZ()-1
		 ) && 
		(
		 x == (int)(ptrWorld->sizeX() / 3.0) || x == (int)(ptrWorld->sizeX() * 2.0 / 3.0) ||
		 z == (int)(ptrWorld->sizeZ() / 3.0) || z == (int)(ptrWorld->sizeZ() * 2.0 / 3.0)	
		 )
		)
	{
		if (currentCell->states[ptrWorld->index()] > 0) {
			
			hx = fragSizeX * ptrWorld->sizeX() * 0.5;
			hy = fragSizeY * ptrWorld->sizeY() * 0.5;			
			
			xL = x * fragSizeX + (fragSizeX * 0.5);
			yB = y * fragSizeY + (fragSizeY * 0.5);
			zF = z * fragSizeZ + (fragSizeZ * 0.5);
			
			xL -= hx;
			yB -= hy;
			
			state = unmapf(state, 1, 10);
			
			for (i = 0; i < ptrWorld->rule()->nSize(); i++) {
				Cell* n;
				n = ptrWorld->rule()->getNeighbor(currentCell, i);
				if (n->states[ptrWorld->index()] > 0 && n->states[ptrWorld->index()] < 10)
				{
					ex = n->x * fragSizeX + (fragSizeX * 0.5);
					ey = n->y * fragSizeY + (fragSizeY * 0.5);
					ez = n->z * fragSizeZ + (fragSizeZ * 0.5);
					
					ex -= hx;
					ey -= hy;	
					
					red = patternLib[14].color.r;
					green = patternLib[14].color.g;
					blue = patternLib[14].color.b * abs(patternLib[14].colormap - state);
					alpha = patternLib[14].alpha * abs(patternLib[14].alphamap - state);
					
					gl::color(red, green, blue, alpha);				
					gl::drawLine( Vec3f(xL, yB, zF), Vec3f(ex, ey, ez) );
				}
			}
		}
	}
	
}

void GraphicsRenderer::pattern06(int x, int y, int z) {
	if (ptrWorld->currentBMU()) {
		Cell* bmu;
		double radius, dist, hx;
		bmu = ptrWorld->currentBMU();
		radius = ((double)ptrWorld->sizeX() / 3.0);		
		dist = pow(bmu->x - x, 2.0) + pow(bmu->y - y, 2.0) + pow(bmu->z - z, 2.0);

		hx = fragSizeX * ptrWorld->sizeX() * 0.5;

		if (dist < radius) {			
			
			xL = (float)x * fragSizeX + (fragSizeX * 0.5);
			yB = (float)y * fragSizeX + (fragSizeY * 0.5);
			zF = (float)z * fragSizeX + (fragSizeZ * 0.5);
			
			xL -= hx;
			yB -= hx;
			zF -= hx;
			
			if (dist == 0.0) {
				xW = fragSizeX * mapf(state, 1.0, 2.0);
				yH = fragSizeX * mapf(state, 1.0, 2.0);
				zD = fragSizeX * mapf(state, 1.0, 2.0);								
			}
			else {
				xW = fragSizeX * state * mapf(dist/radius, 1.0, 2.0);
				yH = fragSizeX * state * mapf(dist/radius, 1.0, 2.0);
				zD = fragSizeX * state * mapf(dist/radius, 1.0, 2.0);			
			}
			
			red = patternLib[6].color.r * abs(patternLib[6].colormap - state) * currentCell->weights[0];
			green = patternLib[6].color.g * abs(patternLib[6].colormap - state) * currentCell->weights[1];
			blue = patternLib[6].color.b * abs(patternLib[6].colormap - state) * currentCell->weights[2];
			alpha = patternLib[6].alpha * abs(patternLib[6].alphamap - state);	
//			alpha *= ((2.0/dist) * currentCell->weights[3]);


			if (x == bmu->x && y == bmu->y && z == bmu->z) {
				gl::color(red, green, blue, alpha);
				gl::drawSphere( Vec3f(xL, yB, zF), xW, 24 );
				
				gl::color(red*0.8, green*0.8, blue*0.8, alpha*0.8);
				
				gl::drawCube( Vec3f(xL, yB, zF), Vec3f(fragSizeX * 200.0, fragSizeX * 0.5, fragSizeX * 0.5) );
				gl::drawCube( Vec3f(xL, yB, zF), Vec3f(fragSizeX * 0.5, fragSizeX * 200.0, fragSizeX * 0.5) );
				gl::drawCube( Vec3f(xL, yB, zF), Vec3f(fragSizeX * 0.5, fragSizeX * 0.5, fragSizeX * 200.0) );
				
			}
			else {
				gl::color(red, green, blue, alpha*0.5);
				gl::drawSphere( Vec3f(xL, yB, zF), xW, 16 );				
			}

			
			
		}
		
		for (int i = 0; i < ptrWorld->bestMatchHistorySize(); i++) {
			
			Index3D* coords;
			coords = ptrWorld->bestMatchHistoryAt(i);
			
			if (coords->x == x && coords->y == y && coords->z == z) {
			
				xL = (float)x * fragSizeX + (fragSizeX * 0.5);
				yB = (float)y * fragSizeX + (fragSizeY * 0.5);
				zF = (float)z * fragSizeX + (fragSizeZ * 0.5);
				
				xL -= hx;
				yB -= hx;
				zF -= hx;
				
				xW = fragSizeX;
								
				alpha = (10.0 - (i + 1) / 10.0);
				
				gl::color(0.7, 0.7, 0.7, alpha);
				gl::drawSphere( Vec3f(xL, yB, zF), xW, 24 );

				gl::drawCube( Vec3f(xL, yB, zF), Vec3f(fragSizeX * (10.0 - (i + 1) / 10.0), fragSizeX * 0.25, fragSizeX * 0.25) );
				gl::drawCube( Vec3f(xL, yB, zF), Vec3f(fragSizeX * 0.25, fragSizeX * (10.0 - (i + 1) / 10.0), fragSizeX * 0.25) );
				gl::drawCube( Vec3f(xL, yB, zF), Vec3f(fragSizeX * 0.25, fragSizeX * 0.25, fragSizeX * (10.0 - (i + 1) / 10.0)) );				
				
			}		
		}	
	}

}

void GraphicsRenderer::pattern07(int x, int y, int z) {


	if (ptrWorld->currentBMU()) {
		Cell* bmu = ptrWorld->currentBMU();
		if (bmu->x == x && bmu->y == y && bmu->z == z) {
			
			double hx, ex, ey, ez;
			Index3D *prevCoords, *currCoords;
			hx = fragSizeX * ptrWorld->sizeX() * 0.5;

			xL = (float)x * fragSizeX + (fragSizeX * 0.5);
			yB = (float)y * fragSizeX + (fragSizeY * 0.5);
			zF = (float)z * fragSizeX + (fragSizeZ * 0.5);
			
			xL -= hx;
			yB -= hx;
			zF -= hx;
			
			xW = fragSizeX;
			
			red = patternLib[7].color.r * abs(patternLib[7].colormap - currentCell->weights[0]);
			green = patternLib[7].color.g * abs(patternLib[7].colormap - currentCell->weights[1]);
			blue = patternLib[7].color.b * abs(patternLib[7].colormap - currentCell->weights[2]);
//			alpha = patternLib[7].alpha * abs(patternLib[7].alphamap - 1.0);	
			
			alpha = 1.0;
			
			gl::color(red, green, blue, alpha);
			gl::drawSphere( Vec3f(xL, yB, zF), xW, 24 );
			
			if (ptrWorld->bestMatchHistorySize() > 0) {
			
				currCoords = ptrWorld->bestMatchHistoryAt(0);
				
				ex = (float)currCoords->x * fragSizeX + (fragSizeX * 0.5);
				ey = (float)currCoords->y * fragSizeX + (fragSizeY * 0.5);
				ez = (float)currCoords->z * fragSizeX + (fragSizeZ * 0.5);
				
				ex -= hx;
				ey -= hx;
				ez -= hx;			
				
				gl::drawLine( Vec3f(xL, yB, zF), Vec3f(ex, ey, ez));
				gl::drawSphere( Vec3f(ex, ey, ez ), fragSizeX * 0.9, 20 );
				
				for (int i = 1; i < ptrWorld->bestMatchHistorySize(); i++) {
					
					prevCoords = currCoords;
					currCoords = ptrWorld->bestMatchHistoryAt(i);
					
					xL = (float)prevCoords->x * fragSizeX + (fragSizeX * 0.5);
					yB = (float)prevCoords->y * fragSizeX + (fragSizeY * 0.5);
					zF = (float)prevCoords->z * fragSizeX + (fragSizeZ * 0.5);
					
					xL -= hx;
					yB -= hx;
					zF -= hx;
					
					ex = (float)currCoords->x * fragSizeX + (fragSizeX * 0.5);
					ey = (float)currCoords->y * fragSizeX + (fragSizeY * 0.5);
					ez = (float)currCoords->z * fragSizeX + (fragSizeZ * 0.5);
					
					ex -= hx;
					ey -= hx;
					ez -= hx;
					
					red *= 0.96;
					green *= 0.9605;
					blue *= 0.961;
					alpha *= 0.98;
					
					gl::color(red, green, blue, alpha);				
					
					gl::drawLine( Vec3f(xL, yB, zF), Vec3f(ex, ey, ez));
					gl::drawSphere( Vec3f(ex, ey, ez ), fragSizeX * (1.0-(i*0.02)), 16 );
					
				}
			}			
		}
	}
}

void GraphicsRenderer::pattern08(int x, int y, int z) {
	
}

void GraphicsRenderer::pattern09(int x, int y, int z) {

}

void GraphicsRenderer::pattern10(int x, int y, int z) {

}

void GraphicsRenderer::pattern11(int x, int y, int z) {

}

void GraphicsRenderer::pattern12(int x, int y, int z) {

}

void GraphicsRenderer::pattern13(int x, int y, int z) {

}

void GraphicsRenderer::pattern14(int x, int y, int z) {

}

void GraphicsRenderer::pattern15(int x, int y, int z) {

}

void GraphicsRenderer::drawBoids(Boids* boids) {
		
	drawBoidWorldBorders(boids);
	
	mEye = boids->getBoidAtIndex(0)->pos;

	mCenter = boids->centroid();

	red = 0.1;
	green = 0.8;
	blue = 1.0;
	alpha = 0.7;
	
	gl::color(red, green, blue, alpha);
	
	for (int i = 0; i < boids->numBoids(); i++) {
		gl::drawSphere( boids->getBoidAtIndex(i)->pos, 2.0, 16 );	
		if (i > 0) {
			gl::drawLine( boids->getBoidAtIndex(i)->pos, boids->getBoidAtIndex(i-1)->pos );
		}
	}
	
}

void GraphicsRenderer::drawBoidWorldBorders(Boids* boids) {
	
	red = 0.6;
	green = 0.7;
	blue = 0.8;
	alpha = 1.0;	
	
	gl::color(red, green, blue, alpha);
	gl::drawStrokedCube( boids->dimensions() * 0.5, boids->dimensions() );

//	glBindTexture(GL_TEXTURE_CUBE_MAP, _textObj);
//	
//	_wallShader.bind();
//	_wallShader.uniform( "LightPos", Vec3f( getWindowWidth()/2 + 350.0f, getWindowHeight()/2 - 150.0f, 150.0f ));
//	_wallShader.uniform( "MixRatio", 0.5f );
//	_wallShader.uniform( "EnvMap", 4 );
//	_wallShader.uniform( "BaseColor", Vec3f(0.2, 0.95, 0.8) );
//	glPushMatrix();
//	glTranslated(0.0f, 0.0f, 0.0f);
//	_walls.draw();
//	glPopMatrix();
//	
//	glBindTexture(GL_TEXTURE_CUBE_MAP, 0);
	
}

void GraphicsRenderer::strokeRectArray() {
	
	GLfloat vertices[] = {
		xL, yB, zF,				xL + xW, yB, zF,
		xL + xW, yB, zF,		xL + xW, yB + yH, zF,
		xL + xW, yB + yH, zF,	xL, yB + yH, zF,
		xL, yB + yH, zF,		xL, yB, zF
	};
	
	GLfloat normals[] = {
		0, 0, 1,				0, 0, 1,
		0, 0, 1,				0, 0, 1,
		0, 0, 1,				0, 0, 1,
		0, 0, 1,				0, 0, 1
	};
	
	GLfloat colors[] = {
		red, green, blue, alpha,	red, green, blue, alpha,
		red, green, blue, alpha,	red, green, blue, alpha,
		red, green, blue, alpha,	red, green, blue, alpha,
		red, green, blue, alpha,	red, green, blue, alpha
	};
	
	glEnableClientState(GL_NORMAL_ARRAY);
	glEnableClientState(GL_COLOR_ARRAY);
	glEnableClientState(GL_VERTEX_ARRAY);
	
	glNormalPointer(GL_FLOAT, 0, normals);
	glColorPointer(4, GL_FLOAT, 0, colors);
	glVertexPointer(3, GL_FLOAT, 0, vertices);
	
	glEnable(GL_LINE_SMOOTH);
	
	glDrawArrays(GL_LINES, 0, 8);
	
	glDisable(GL_LINE_SMOOTH);
		
	glDisableClientState(GL_VERTEX_ARRAY);
	glDisableClientState(GL_COLOR_ARRAY);
	glDisableClientState(GL_NORMAL_ARRAY);
	
}

void GraphicsRenderer::fillRect (int plane) {
	glColor4f(red, green, blue, alpha);
	glEnable(GL_POLYGON_SMOOTH);
	glBegin(GL_POLYGON);
	
	switch (plane)
	{
		case 0:
			glVertex3f (xL, yB, zF);
			glVertex3f (xL + xW, yB, zF);
			
			glVertex3f (xL + xW, yB, zF);
			glVertex3f (xL + xW, yB + yH, zF);
			
			glVertex3f (xL + xW, yB + yH, zF);
			glVertex3f (xL, yB + yH, zF);
			
			glVertex3f (xL, yB + yH, zF);
			glVertex3f (xL, yB, zF);
			
			break;
			
		case 1:
			glVertex3f (xL, yB, zF);
			glVertex3f (xL, yB, zF + zD);
			
			glVertex3f (xL, yB, zF + zD);
			glVertex3f (xL, yB + yH, zF + zD);
			
			glVertex3f (xL, yB + yH, zF + zD);
			glVertex3f (xL, yB + yH, zF);
			
			glVertex3f (xL, yB + yH, zF);
			glVertex3f (xL, yB, zF);
			
			break;
			
		case 2:
			glVertex3f (xL, yB, zF);
			glVertex3f (xL + xW, yB, zF);
			
			glVertex3f (xL + xW, yB, zF);
			glVertex3f (xL + xW, yB, zF + zD);
			
			glVertex3f (xL + xW, yB, zF + zD);
			glVertex3f (xL, yB, zF + zD);
			
			glVertex3f (xL, yB, zF + zD);
			glVertex3f (xL, yB, zF);
			
			break;
			
	}
	
	glEnd();
	glDisable(GL_POLYGON_SMOOTH);
	
}

void GraphicsRenderer::strokeRect (int plane, float lineWidth) {
	glColor4f(red, green, blue, alpha);
	glEnable(GL_LINE_SMOOTH);
	glLineWidth(lineWidth);
	glBegin(GL_LINES);
	
	switch (plane)
	{
		case 0:
			glVertex3f (xL, yB, zF);
			glVertex3f (xL + xW, yB, zF);
			
			glVertex3f (xL + xW, yB, zF);
			glVertex3f (xL + xW, yB + yH, zF);
			
			glVertex3f (xL + xW, yB + yH, zF);
			glVertex3f (xL, yB + yH, zF);
			
			glVertex3f (xL, yB + yH, zF);
			glVertex3f (xL, yB, zF);
			
			break;
			
		case 1:
			glVertex3f (xL, yB, zF);
			glVertex3f (xL, yB, zF + zD);
			
			glVertex3f (xL, yB, zF + zD);
			glVertex3f (xL, yB + yH, zF + zD);
			
			glVertex3f (xL, yB + yH, zF + zD);
			glVertex3f (xL, yB + yH, zF);
			
			glVertex3f (xL, yB + yH, zF);
			glVertex3f (xL, yB, zF);
			
			break;
			
		case 2:
			glVertex3f (xL, yB, zF);
			glVertex3f (xL + xW, yB, zF);
			
			glVertex3f (xL + xW, yB, zF);
			glVertex3f (xL + xW, yB, zF + zD);
			
			glVertex3f (xL + xW, yB, zF + zD);
			glVertex3f (xL, yB, zF + zD);
			
			glVertex3f (xL, yB, zF + zD);
			glVertex3f (xL, yB, zF);
			
			break;
			
	}
	
	
	glEnd();
	glDisable(GL_LINE_SMOOTH);
}

void GraphicsRenderer::drawPoint (float x, float y, float z, float sz) {
	glColor4f(red, green, blue, alpha);
	glEnable(GL_POINT_SMOOTH);
	glPointSize(sz);
	glBegin(GL_POINTS);
	glVertex3f(x, y, z);
	glEnd();
	glDisable(GL_POINT_SMOOTH);
}


void GraphicsRenderer::drawLine (float startx, float starty, float startz, float endx, float endy, float endz, float lineWidth) {
	glColor4f(red, green, blue, alpha);
	glEnable(GL_LINE_SMOOTH);
	glLineWidth(lineWidth);
	glBegin(GL_LINES);
	
	glVertex3f(startx, starty, startz);
	glVertex3f(endx, endy, endz);
	
	glEnd();
	glDisable(GL_LINE_SMOOTH);
}

void GraphicsRenderer::drawCircle (int plane, float r, int num_segments, bool fill) { 
	int i;
	float theta, tangetial_factor, radial_factor, x, y;
	theta = 2 * pi / num_segments;
	tangetial_factor = tanf(theta);
	radial_factor = cosf(theta);
	x = r;
	y = 0;
	
	if (fill) {
		glBegin(GL_POLYGON);	
	}
	{
		glBegin(GL_LINE_LOOP);
	}
	glColor4f(red, green, blue, alpha);
	for(i = 0; i < num_segments; i++) 
	{ 
		switch (plane) {
			case 0:
				glVertex3f(x + xL, y + yB, zF);
				break;
			case 1: 
				glVertex3f(xL, x + yB, y + zF);
				break;
			case 2:
				glVertex3f(y + xL, yB, x + zF);
				break;
		}
		
        
		float tx = -y; 
		float ty = x; 
		x += tx * tangetial_factor; 
		y += ty * tangetial_factor; 
		x *= radial_factor; 
		y *= radial_factor; 
	} 
	glEnd(); 
}

