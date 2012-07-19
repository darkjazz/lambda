/*
 *  swarm.cpp
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

#include "swarm.h"

Particle::Particle(Vec3f pos, Vec3f vel) {
	position = pos;
	tailPosition = pos;
	velocity = vel;
	velocityNormal = Vec3f::yAxis();
	acceleration = Vec3f::zero();
	neighborPos = Vec3f::zero();
	numNeighbors = 0;
	maxSpeed = Rand::randFloat(3.0, 6.0);
	minSpeed = Rand::randFloat(1.5, 2.5);
	decay = 0.99;
	radius = 1.0;
	length = 10.0;
	crowdFactor = 1.0;
}

void Particle::center(const Vec3f &center, float maxDist, float pull) {
	Vec3f dir = position - center;
	float dist = dir.length();
	
	if (dist > maxDist) {
		dir.normalize();
		velocity -= dir * ((dist - maxDist) * pull);
	}
}

void Particle::update() {

	crowdFactor -= (crowdFactor - (1.0 - numNeighbors * 0.01)) * 0.1;
	
	velocity += acceleration;
	velocityNormal = velocity.normalized();
	
	limitSpeed();
	
	position += velocity;
	
	tailPosition = position - (velocityNormal * length);
	
	velocity *= decay;
	acceleration = Vec3f::zero();
	
	neighborPos = Vec3f::zero();
	numNeighbors = 0;
}

void Particle::limitSpeed() {
	float lenSqr = velocity.lengthSquared();
	if (lenSqr > (maxSpeed*maxSpeed)) {
		velocity = velocityNormal * maxSpeed;
	} else if (lenSqr < (minSpeed * minSpeed)) {
		velocity = velocityNormal * minSpeed;
	}
}

void Swarm::initParticles(int num) {
	
	particles.clear();
	
	for (int i = 0; i < num; i++) {
		Vec3f randvec = Rand::randVec3f();
		Vec3f pos = randvec * Rand::randFloat(10.0, 60.0);
		Vec3f vec = -randvec;
		
		particles.push_back(Particle( pos, vec ));
	}
}


void Swarm::move(const Vec3f &ctr) {
	calc();
	center(ctr);
	update();
}

void Swarm::center(const Vec3f &ctr) {
	for( list<Particle>::iterator prt = particles.begin(); prt != particles.end(); ++prt ){
		prt->center(ctr, maxDist, pull);
	}		
}

void Swarm::update() {
	for( list<Particle>::iterator prt = particles.begin(); prt != particles.end(); ++prt ){
		prt->update();
	}		
}

void Swarm::calc() {
	float twopi = M_PI * 2.0;
	centroid = Vec3f::zero();
	_size = particles.size();
	
	for( list<Particle>::iterator pA = particles.begin(); pA != particles.end(); ++pA ){
		
		list<Particle>::iterator pB = pA;
		for( ++pB; pB != particles.end(); ++pB ) {
			Vec3f dir = pA->position - pB->position;
			float distSqrd = dir.lengthSquared();
			float zoneRadiusSqrd = zoneRadius * zoneRadius;
			
			if( distSqrd < zoneRadiusSqrd ){			// Neighbor is in the zone
				float percent = distSqrd/zoneRadiusSqrd;
				
				if( percent < lowerThresh ){			// Separation
					float F = ( lowerThresh/percent - 1.0f ) * repelStrength;
					dir = dir.normalized() * F;
					
					pA->acceleration += dir;
					pB->acceleration -= dir;
				} else if( percent < higherThresh ){	// Alignment
					float threshDelta		= higherThresh - lowerThresh;
					float adjustedPercent	= ( percent - lowerThresh )/threshDelta;
					float F					= ( 1.0 - ( cos( adjustedPercent * twopi ) * -0.5f + 0.5f ) ) * alignStrength;
					
					pA->acceleration += pB->velocityNormal * F;
					pB->acceleration += pA->velocityNormal * F;
					
				} else {								// Cohesion
					float threshDelta		= 1.0f - higherThresh;
					float adjustedPercent	= ( percent - higherThresh )/threshDelta;
					float F					= ( 1.0 - ( cos( adjustedPercent * twopi ) * -0.5f + 0.5f ) ) * attractStrength;
					
					dir.normalize();
					dir *= F;
					
					pA->acceleration -= dir;
					pB->acceleration += dir;
				}
			}
		}
		
		centroid += pA->position;
	}
	centroid /= (float)_size;
	
}
