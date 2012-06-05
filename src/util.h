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

#include "stdlib.h"
#include "math.h"

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
double linInterp(double, double, double);
double cosInterp(double, double, double);

#endif