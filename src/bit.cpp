//
//  lambdaBitalino.cpp
//  lambdaApp
//
//  Created by alo on 19/01/2016.
//
//

#include "bit.h"
#include "util.h"

double VCC = 3.3;
double resolution = 10.0;
double offset = 0.5;
double gain = 1.008;

BitalinoCtr::BitalinoCtr(string address, int frameRate) {
    _macAddress = address;
    _frameRate = frameRate;
    activated = false;
    _batteryThreshold = 10;
    _numFrames = 100;
    _frames = new BITalino::VFrame(_numFrames);
}

void BitalinoCtr::connect() {
    _bitalino = new BITalino(_macAddress.c_str());
    _bitalino->battery(_batteryThreshold);
}

void BitalinoCtr::start() {
    _bitalino->start(_frameRate, {0, 1, 2, 3, 4, 5});
}

void BitalinoCtr::stop() {
    _bitalino->stop();
}

void BitalinoCtr::readFrame() {
    _bitalino->read(*_frames);
}

double BitalinoCtr::mapValues() {
    mean = 0.0;
    variance = 0.0;
    _convertedValues.clear();
    for (int i = 0; i < _numFrames; i++)
    {
        BITalino::Frame f = _frames->at(i);
        _convertedValues.push_back(convert(f.analog[0]));
        mean += _convertedValues[i];
    }
    mean /= _numFrames;
    for (int i = 0; i <_numFrames; i++)
    {
        variance += pow(_convertedValues[i] - mean, 2);
    }
    variance /= _numFrames;
    stdDev = sqrt(variance);
    return mean;
}

double BitalinoCtr::convert(int value) {
    return ((double)value*VCC/(pow(2.0,resolution)) - VCC*offset)/gain;
}

BitalinoCtr::~BitalinoCtr()
{
    delete _bitalino;
}