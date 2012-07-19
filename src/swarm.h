/*
 *  swarm.h
 *  funktApp
 *
 *  Created by alo on 07/07/2012.
 *  
 *	This file is part of funktApp.
 *
 *	funktApp is free software: you can redistribute it and/or modify
 *	it under the terms of the GNU General Public License as published by
 *	the Free Software Foundation, either version 3 of the License, or
 *	(at your option) any later version.
 
 *	funktApp is distributed in the hope that it will be useful,
 *	but WITHOUT ANY WARRANTY; without even the implied warranty of
 *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *	GNU General Public License for more details.
 
 *	You should have received a copy of the GNU General Public License
 *	along with funktApp.  If not, see <http://www.gnu.org/licenses/>. 
 *
 */

#ifndef SWARM_H
#define SWARM_H

#include "cinder/Vector.h"
#include <list>
#include "util.h"
#include "cinder/Rand.h"


using namespace ci;
using namespace std;

class Particle {
public:
	Particle();
	Particle( Vec3f, Vec3f );
	~Particle() { };
	void center(const Vec3f&, float, float);
	void update();
	void limitSpeed();
	
	Vec3f position, tailPosition, velocity, velocityNormal, acceleration, neighborPos; 
	int numNeighbors, decay, radius, length, maxSpeed, minSpeed, crowdFactor;
	
};

class Swarm {
public:
	Swarm() {};
	~Swarm() {};
	
	void move(const Vec3f&);
	void initParticles(int);
	void calc();
	void center(const Vec3f&);
	void update();
	
	int size() { return particles.size(); }
	
	list<Particle> particles;
	Vec3f centroid;
	float zoneRadius, lowerThresh, higherThresh, attractStrength, repelStrength, alignStrength;
	float maxDist, pull;
	
private:
		
	int _size;
	double _speed, _neighborhoodRadius, _maxSpeed, _maxSteer;
};

#endif