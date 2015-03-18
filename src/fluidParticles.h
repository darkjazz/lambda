/*
 *  fluidParticles.h
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

#ifndef FLUIDPARTICLES_H
#define FLUIDPARTICLES_H

#include "cinder/app/AppBasic.h"
#include "cinder/gl/gl.h"

#include "ciMsaFluidSolver.h"
#include "ciMsaFluidDrawerGl.h"

#include "Particle.h"
#include "ParticleSystem.h"

#include "boids.h"

class FluidParticles {
public:
	FluidParticles() {};
	~FluidParticles() {};
	
	void	setup();
	
	void	fadeToColor( float r, float g, float b, float speed );
	void	addToFluid( Vec2f pos, Vec2f vel, bool addColor, bool addForce );
	void	addToFluidWithColor( Vec2f pos, Vec2f vel, Color drawColor, bool addForce );

	void	resize( int w, int h );
	
	void	update();
	void	draw();
	
	int					fluidCellsX;
	bool				resizeFluid;
	bool				drawFluid;
	bool				drawParticles;
	bool				renderUsingVA;
	bool				updateBoids;
	
	float				aspectRatio;
	Vec2i				surfaceSize;
	Area				area;
	int					elapsedFrames;
	
	ciMsaFluidSolver	fluidSolver;
	ciMsaFluidDrawerGl	fluidDrawer;	
	ParticleSystem		particleSystem;
	Boids*				boids;
		
};

#endif