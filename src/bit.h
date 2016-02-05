/*
 *  osc.h
 *  lambda
 *
 *  Created by alo on 19/01/2016.
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

#ifndef __lambdaApp__bit__
#define __lambdaApp__bit__

#include <stdio.h>

#include "bitalino.h"

using namespace std;

class BitalinoCtr {
public:
    BitalinoCtr() {}
    ~BitalinoCtr();
    
    BitalinoCtr(string, int);
    
    void connect();
    void start();
    void stop();
    void readFrame();
    double mapValues();
    double convert(int);
    bool activated;
    double mean;
    double variance;
    double stdDev;
private:
    string _macAddress;
    BITalino* _bitalino;
    int _frameRate;
    int _batteryThreshold;
    int _numFrames;
    BITalino::VFrame* _frames;
    vector<double> _convertedValues;
};

#endif /* defined(__lambdaApp__lambdaBitalino__) */

