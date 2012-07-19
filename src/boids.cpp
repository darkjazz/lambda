/*
 *  boids.cpp
 *  lambdaApp
 *
 *  Created by alo on 13/07/2012.
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

#include "boids.h"

Boid::Boid(Vec3f apos, Vec3f avec, int lifeExp) {
	pos = apos;
	vec = avec;
	lifeExpectancy = lifeExp;
	init();
}

void Boid::init() {
	separation = Vec3f::zero();
	cohesion = Vec3fRS();
	alignment = Vec3fRS();
}

void Boid::reset() {
	separation = Vec3f::zero();
	cohesion.reset();
	alignment.reset();	
}

float Boid::distance(Boid* other) {
	return pos.distance(other->pos);
}

Boids::Boids(int numboids, Vec3f dimensions, double speed, double cohesion, double alignment, double separation, double center) {
	_num = numboids;
	_dim = dimensions;
	this->speed = speed;
	this->cohesion = cohesion;
	this->alignment = alignment;
	this->separation = separation;
	this->center = center;
	
	_ctype = ABS;
	
	maxNumBoids = 100;
	_minLifeExpectancy = 100;
	_maxLifeExpectancy = 1000;
	
	init();
}

Boids::~Boids() { _boids.clear(); }

void Boids::init() {
	for (int i = 0; i < _num; i++) {
		_boids.push_back(Boid(randVec3f(), Vec3f::zero(), Rand::randInt(_minLifeExpectancy, _maxLifeExpectancy)));
	}
	
	_ctr = Vec3fRS();
}

void Boids::update() {
	
	int itX, itY;
	
//	_ctr.reset();
	
	for ( itX=0 ; itX < _boids.size(); itX++ ) {
		for ( itY=0 ; itY < _boids.size(); itY++ ) {
			if (itX != itY) compare(&_boids[itX], &_boids[itY]);
		}
		calc(&_boids[itX]);
		_ctr.push(_boids[itX].pos);
	}
}

void Boids::setCenter(Vec3f value) { _ctype = SET; _ctrvec = value; }

void Boids::setAutoCenter() { _ctype = MEAN; }

void Boids::setNoCenter() { _ctype = ABS; }

void Boids::compare(Boid* boidX, Boid* boidY) {
	boidX->cohesion.push(boidY->pos);
	boidX->alignment.push(boidY->vec);
	if (boidX->distance(boidY) < separation) {
		boidX->separation -= (boidY->pos - boidX->pos);
	}
}

void Boids::calc(Boid* boid) {
	Vec3f centerpoint;
	switch (_ctype) {
		case MEAN:
			centerpoint = _ctr.mean();
			break;
		case SET:
			centerpoint = _ctrvec;
			break;
		default:
			centerpoint = _dim / 2.0;
			break;
	}
	
	boid->vec *= speed;
	boid->vec += ((boid->cohesion.mean() - boid->pos) / Vec3f(cohesion, cohesion, cohesion));
	boid->vec += ((boid->alignment.mean() - boid->vec) / Vec3f(alignment, alignment, alignment));
	boid->vec += boid->separation;	
	boid->vec += ((centerpoint - boid->pos) / Vec3f(center, center, center));	
	boid->pos += boid->vec;
	
	boid->pos = wrapVec3f(boid->pos, Vec3f::zero(), _dim);
	
	boid->reset();
	
}

void Boids::addBoid(Vec3f loc) {
	if (_boids.size() < maxNumBoids) 
		_boids.push_back(Boid(loc, Vec3f::zero(), Rand::randInt(_minLifeExpectancy, _maxLifeExpectancy)));
}

void Boids::removeBoid(int index) {
	_boids.erase(_boids.begin() + index);
}

Vec3f Boids::centroid() {
	switch (_ctype) {
		case MEAN:
			return _ctr.mean();
			break;
		case SET:
			return _ctrvec;
			break;
		default:
			return _dim / 2.0;
			break;
	}
	
}
