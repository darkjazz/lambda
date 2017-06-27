#pragma once

#include "cinder/Vector.h"
#include "cinder/Color.h"
#include <vector>

class Particle {
public:
    Particle( ci::Vec3f _loc, ci::Vec3f _vel, bool _bPerlin );
    void exist(int brownZ);
    void findPerlin(int brownZ);
    void findVelocity();
    void setPosition();
    void render();
    void renderTrails();
    void setAge();
    
    
    int len;            // number of elements in position array
    std::vector<ci::Vec3f> loc;        // array of position vectors
    ci::Vec3f startLoc;     // just used to make sure every loc[] is initialized to the same position
    ci::Vec3f vel;          // velocity vector
    ci::Vec3f perlin;       // perlin noise vector
    float radius;       // particle's size
    float age;          // current age of particle
    int lifeSpan;       // max allowed age of particle
    float agePer;       // range from 1.0 (birth) to 0.0 (death)
    bool ISDEAD;     // if age == lifeSpan, make particle die
    cinder::Color color;
    bool bPerlin;
};
