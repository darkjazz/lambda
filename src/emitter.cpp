//
//  emitter.cpp
//  lambdaApp
//
//  Created by alo on 12/01/2017.
//
//

#include "Emitter.h"

#include "cinder/gl/gl.h"

using namespace ci;
using std::list;

Emitter::Emitter()
{
    myColor = Color( 1, 1, 1 );
    loc = Vec3f::zero();
    vel = Vec3f::zero();
    bPerlin = false;
}

void Emitter::exist( Vec3f boidLoc )
{
    setVelToBoid( boidLoc );
    findVelocity();
    setPosition();
}

void Emitter::setVelToBoid( Vec3f boidLoc )
{
    velToBoid.set( boidLoc.x - loc.x, boidLoc.y - loc.y, boidLoc.z - loc.z );
}

void Emitter::findVelocity()
{
    vel += ( velToBoid - vel ) * 0.25f;
}

void Emitter::setPosition()
{
    loc += vel;
}

//void Emitter::iterateListExist(int counter)
//{
//    gl::enable( GL_TEXTURE_2D );
//    particleImg->bind();
//    
//    for( list<Particle>::iterator it = particles.begin(); it != particles.end(); ) {
//        if( ! it->ISDEAD ) {
//            it->exist(counter);
//            ++it;
//        }
//        else {
//            it = particles.erase( it );
//        }
//    }
//}

//void Emitter::render()
//{
//    emitterImg->bind();
//    renderImage( loc, 150, myColor, 1.0 );
//}

//void Emitter::iterateListRenderTrails()
//{
//    for( list<Particle>::iterator it = particles.begin(); it != particles.end(); ++it ) {
//        it->renderTrails();
//    }
//}

void Emitter::addParticles( int _amt )
{
    for( int i = 0; i < _amt; i++ ) {
        particles.push_back( Particle( loc, vel, bPerlin ) );
    }
}