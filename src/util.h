/*
 *  util.h
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
#ifndef UTIL_H
#define UTIL_H

#include "cinder/Vector.h"
#include "stdlib.h"
#include "math.h"

using namespace ci;

const double PI = atan(1.0)*4;

void initrand();
float mapf(float, float, float);
float unmapf(float, float, float);
int randint(int, int);
float randf();
double randd();
float randfloat(float, float);
int xmod(int, int);
int wrapi(int, int, int);
float wrapf(float, float, float);
double wrapd(double, double, double);
int isEven(int);
float xmodf(float, float);
double xmodd(double, double);
bool between(int, int, int);
float clipf(float, float, float);
double roundd(double, int);
int fold(int, int, int);
float foldf(float in, float lo, float hi);
double linInterp(double, double, double);
double cosInterp(double, double, double);

float linlin(float, float, float, float, float);
float linexp(float, float, float, float, float);
float explin(float, float, float, float, float);
float expexp(float, float, float, float, float);

Vec3f wrapVec3f(Vec3f, Vec3f, Vec3f);
Vec3f foldVec3f(Vec3f, Vec3f, Vec3f);
Vec2f unmapVec2f(Vec2f, float, float);

struct Vec3fRS{
public:
	Vec3fRS() { count = 0; };
	~Vec3fRS() {};
	
	void push(Vec3f value) {
		count++;
		if (count == 1) {
			oldM = Vec3f(value.x, value.y, value.z);
			newM = Vec3f(value.x, value.y, value.z);
			oldS = Vec3f::zero();
		} else {
			newM = (value - oldM) / (double)count + oldM;
			newS = (value - oldM) * (value - newM) + oldS;
			
			oldM = newM;
			oldS = newS;
		}
		
	}
	
	void reset() { count = 0; }
	Vec3f mean() { if (count > 0) { return newM; } else { return Vec3f::zero(); } }
	Vec3f variance() { if (count > 1) { return (newS / (double)(count - 1)); } else { return Vec3f::zero(); } }
	Vec3f stdDev() { Vec3f _var = variance(); return Vec3f(sqrt(_var.x), sqrt(_var.y), sqrt(_var.z)); }
	
private:
	int count;
	Vec3f oldM, newM, oldS, newS;
	
};

#endif