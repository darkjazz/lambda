/*
 *  fluidParticles.cpp
 *  lambdaApp
 *
 *  Created by alo on 29/08/2014.
 *  
 *	This file is part of lambdaApp.
 *
 *	lambdaApp is free software: you can redistribute it and/or modify
 *	it under the terms of the GNU General Public License as published by
 *	the Free Software Foundation, either version 3 of the License, or
 *	(at your option) any later version.
 
 *	lambdaApp is distributed in the hope that it will be useful,
 *	but WITHOUT ANY WARRANTY; without even the implied warranty of
 *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *	GNU General Public License for more details.
 
 *	You should have received a copy of the GNU General Public License
 *	along with lambdaApp.  If not, see <http://www.gnu.org/licenses/>. 
 *
 */

#include "fluidParticles.h"
#include "util.h"


void FluidParticles::setup()
{
	// setup fluid stuff
	fluidSolver.setup(100, 100);
    fluidSolver.enableRGB(true).setFadeSpeed(0.002).setDeltaT(0.5).setVisc(0.00015).setColorDiffusion(0);
	fluidDrawer.setup( &fluidSolver );
	particleSystem.setFluidSolver( &fluidSolver );
	
	fluidCellsX			= 150;
	
	drawFluid			= true;
	drawParticles		= true;
	renderUsingVA		= true;
	updateBoids			= true;
		
	gl::enableAlphaBlending();
	
	boids = new Boids(8, Vec3f(400.0, 300.0, 0.0), 0.7, 30.0, 8.0, 25.0, 100.0);
	
}

void FluidParticles::fadeToColor( float r, float g, float b, float speed )
{
	glColor4f( r, g, b, speed );
	gl::drawSolidRect( area );
}

// add force and dye to fluid, and create particles
void FluidParticles::addToFluid( Vec2f pos, Vec2f vel, bool addColor, bool addForce )
{
    float speed = vel.x * vel.x  + vel.y * vel.y * aspectRatio * aspectRatio;    // balance the x and y components of speed with the screen aspect ratio
    if( speed > 0 ) {
		pos.x = constrain( pos.x, 0.0f, 1.0f );
		pos.y = constrain( pos.y, 0.0f, 1.0f );
		
        const float colorMult = 100;
        const float velocityMult = 30;
		float scalar = ( elapsedFrames % 360 ) / 360.0f;
		
		if( addColor ) {
			Color drawColor( CM_HSV, scalar, scalar, scalar );
			
			fluidSolver.addColorAtPos( pos, drawColor * colorMult );
			
			if( drawParticles )
				particleSystem.addParticles( pos * Vec2f( surfaceSize ), 10 );
		}
		
		if( addForce )
			fluidSolver.addForceAtPos( pos, vel * velocityMult );
		
		if( ! drawFluid && elapsedFrames%5==0 )
			fadeToColor( 0, 0, 0, 0.1f );
    }
}

void FluidParticles::addToFluidWithColor( Vec2f pos, Vec2f vel, Color drawColor, bool addForce )
{
    float speed = vel.x * vel.x  + vel.y * vel.y * aspectRatio * aspectRatio;    // balance the x and y components of speed with the screen aspect ratio
    if( speed > 0 ) {
		pos.x = constrain( pos.x, 0.0f, 1.0f );
		pos.y = constrain( pos.y, 0.0f, 1.0f );
		
        const float colorMult = 10;
        const float velocityMult = 30;
		
		fluidSolver.addColorAtPos( pos, drawColor * colorMult );
		
		if( drawParticles )
			particleSystem.addParticles( pos * Vec2f( surfaceSize ), 4 );
		
		if( addForce )
			fluidSolver.addForceAtPos( pos, vel * velocityMult );
		
		if( ! drawFluid && elapsedFrames%5==0 )
			fadeToColor( 0, 0, 0, 0.1f );
    }
}

void FluidParticles::update()
{
	Vec2f boidNorm, boidVel;
		
	for (int i = 0; i < boids->numBoids(); i++) {
		float scalar = linlin((float)i, 0.0, (float)boids->numBoids() - 1, 120.0, 240.0) / 360.0;
		Color drawColor( CM_HSV, scalar, 1, 1);
		boidNorm = unmapVec2f(boids->getBoidAtIndex(i)->pos.xy(), 0, 400.0) ;
		boidVel = boids->getBoidAtIndex(i)->vec.xy();
		addToFluidWithColor( boidNorm, boidVel, drawColor, true );		
	}
	
	if( resizeFluid ) {
		fluidSolver.setSize(fluidCellsX, fluidCellsX / aspectRatio );
		fluidDrawer.setup(&fluidSolver);
		resizeFluid = false;
	}
	
	fluidSolver.update();
}

void FluidParticles::draw()
{
		
	if( drawFluid ) {
		glColor3f(1, 1, 1);
		fluidDrawer.draw(0, 0, area.getWidth(), area.getHeight() );
	}
	if( drawParticles )
		particleSystem.updateAndDraw( drawFluid );
}


void FluidParticles::resize( int w, int h )
{
	particleSystem.setWindowSize( Vec2i( w, h ) );
	resizeFluid = true;
}
