//
//  emitter.h
//  lambdaApp
//
//  Created by alo on 12/01/2017.
//
//
#ifndef EMITTER_H
#define EMITTER_H

#pragma once
#include "Particle.h"
#include "cinder/Vector.h"
#include "cinder/Color.h"
#include "cinder/gl/Texture.h"
#include <list>

class Emitter {
public:
    Emitter();
    void exist( ci::Vec3f boidLoc  );
    void setVelToBoid( ci::Vec3f boidLoc );
    void findVelocity();
    void setPosition();
//    void iterateListExist(int counter);
//    void render();
//    void iterateListRenderTrails();
    void addParticles( int _amt );
    
    ci::Vec3f loc;
    ci::Vec3f vel;
    ci::Vec3f velToBoid;
    ci::Color myColor;
    std::list<Particle>	particles;
    bool bPerlin;
};

#endif