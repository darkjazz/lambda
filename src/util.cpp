/*
 *  util.cpp
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

#include "util.h"

void initrand() 
{ 
//    srand((unsigned)(time(0))); 
} 

float mapf(float val, float lo, float hi)
{
	return val * (hi - lo) + lo;
}

float unmapf(float val, float lo, float hi) {
	return (val - lo) / (hi - lo);
}

int randint(int min, int max) 
{ 
    if (min>max) 
    { 
        return max+(int)((min-max+1)*rand()/(RAND_MAX+1.0)); 
    } 
    else 
    { 
        return min+(int)((max-min+1)*rand()/(RAND_MAX+1.0)); 
    } 
}

float randf() 
{ 
    return rand()/((float)(RAND_MAX)+1); 
} 

double randd() 
{ 
    return rand()/((double)(RAND_MAX)+1); 
} 

float randfloat(float min, float max) 
{ 
    if (min>max) 
    { 
        return randf()*(min-max)+max;     
    } 
    else 
    { 
        return randf()*(max-min)+min; 
    }     
} 

int xmod(int a, int n) {
	return a - (n * floor(a / (double)n));
}

int wrapi(int val, int lo, int hi) {
	int rtn;
	rtn = xmod((val - lo), (hi - lo + 1)) + lo;
	return rtn;
}

float wrapf(float val, float lo, float hi)
{
	return xmodf(val - lo, hi - lo) + lo;
}

double wrapd(double val, double lo, double hi)
{
	return xmodd(val - lo, hi - lo) + lo;
}

Vec3f wrapVec3f(Vec3f vec, Vec3f lo, Vec3f hi) {
	return Vec3f( wrapf(vec.x, lo.x, hi.x), wrapf(vec.y, lo.y, hi.y), wrapf(vec.z, lo.z, hi.z) );
}

Vec3f foldVec3f(Vec3f vec, Vec3f lo, Vec3f hi) {
	return Vec3f( foldf(vec.x, lo.x, hi.x), foldf(vec.y, lo.y, hi.y), foldf(vec.z, lo.z, hi.z) );
}

Vec2f unmapVec2f(Vec2f vec, float lo, float hi) {
	return Vec2f( unmapf(vec.x, lo, hi), unmapf(vec.y, lo, hi) );
}

float xmodf(float value, float hi)
{
	return value - hi*floor(value/hi);
}

double xmodd(double value, double hi) 
{
	return value - hi*floor(value/hi);
}

float foldf(float in, float lo, float hi)
{
	float x, c, range, range2;
	x = in - lo;
	
	if (in >= hi) {
		in = hi + hi - in;
		if (in >= lo) return in;
	} else if (in < lo) {
		in = lo + lo - in;
		if (in < hi) return in;
	} else return in;
	
	if (hi == lo) return lo;
	range = hi - lo;
	range2 = range + range;
	c = x - range2 * floor(x / range2);
	if (c>=range) c = range2 - c;
	return c + lo;
}


int isEven(int number)
{
	return (int)(number % 2 == 0);
}

bool between(int aNumber, int a, int b) {
	if (aNumber >= a && aNumber <= b) {
		return true;
	}
	else {
		return false;
	}
}

float clipf(float val, float min, float max)
{
	if (val < min)
		val = min;
	if (val > max)
		val = max;
	return	val;
}

double roundd(double val, int places) {
	return val;
}

int fold(int in, int lo, int hi) {
	int x, c, range, range2;
	x = in - lo;
	
	if (in >= hi) {
		in = hi + hi - in;
		if (in >= lo) return in;
	} else if (in < lo) {
		in = lo + lo - in;
		if (in < hi) return in;
	} else return in;
	
	if (hi == lo) return lo;
	range = hi - lo;
	range2 = range + range;
	c = x - range2 * floor(x / range2);
	if (c>=range) c = range2 - c;
	return c + lo;
	
}

double linInterp(double p1, double p2, double mu) {
	return (p1*(1-mu)+p2*mu);
}

double cosInterp(double p1, double p2, double mu) {
	double mu2;
	mu2 = (1-cos(mu*PI))/2;
	return (p1*(1-mu2)+p2*mu2);
}

float linlin(float val, float inmin, float inmax, float outmin, float outmax)
{
	if (val <= inmin) {
		return	outmin;
	}
	else if (val >= inmax) {
		return outmax;
	}
	return (val - inmin) / (inmax-inmin) * (outmax-outmin) + outmin;
}

float linexp(float val, float inmin, float inmax, float outmin, float outmax)
{
	if (val <= inmin) {
		return	outmin;
	}
	else if (val >= inmax) {
		return outmax;
	}
	return pow(outmax/outmin, (val - inmin) / (inmax-inmin)) * outmin;
}

float explin(float val, float inmin, float inmax, float outmin, float outmax)
{
	if (val <= inmin) {
		return	outmin;
	}
	else if (val >= inmax) {
		return outmax;
	}
	return (log(val/inmin)) / (log(inmax/inmin)) * (outmax-outmin) + outmin;
}

float expexp(float val, float inmin, float inmax, float outmin, float outmax)
{
	if (val <= inmin) {
		return	outmin;
	}
	else if (val >= inmax) {
		return outmax;
	}
	return pow(outmax/outmin, log(val/inmin) / log(inmax/inmin)) * outmin;
}
