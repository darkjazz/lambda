#include "Particle.h"
#include "cinder/Rand.h"
#include "cinder/gl/gl.h"
#include "cinder/Perlin.h"

using namespace ci;

Perlin sPerlin( 2 );

Particle::Particle( Vec3f _loc, Vec3f _vel, bool _bPerlin)
{
    radius      = Rand::randFloat( 10, 40 );
    len         = (int)radius;
    
    startLoc = _loc + Rand::randVec3f() * Rand::randFloat( 5.0f );
    
    for( int i = 0; i < len; i++ ) {
        loc.push_back( startLoc );
    }
    
    vel = _vel * 0.5f + Rand::randVec3f() * Rand::randFloat( 10.0f );
    
    perlin = Vec3f::zero();
    
    age         = 0;
    agePer		= 1.0f;
    lifeSpan    = (int)( radius );
    ISDEAD		= false;
    bPerlin = _bPerlin;
}

void Particle::exist(int brownZ)
{
    if( bPerlin )
        findPerlin(brownZ);
    
    findVelocity();
    setPosition();
    render();
    //setAge();
}

void Particle::findPerlin(int brownZ)
{
    Vec3f noise = sPerlin.dfBm( loc[0] * 0.01f + Vec3f( 0, 0, brownZ / 100.0f ) );
    perlin = noise.normalized() * 0.5f;
}

void Particle::findVelocity()
{
    
    if( bPerlin )
        vel += perlin;
    
}

void Particle::setPosition()
{
    for( int i = len - 1; i > 0; i-- ) {
        loc[i] = loc[i-1];
    }
    
    loc[0] += vel;
}

void Particle::render()
{
    color = Color( agePer, agePer * 0.75f, 1.0f - agePer );
    //ogl->renderImage( loc[0], radius * agePer, c, 1.0f );
}

void Particle::renderTrails()
{
    gl::begin( GL_QUAD_STRIP );
    
    for( int i = 0; i < len - 2; i++ ) {
        float per     = 1.0f - i / (float)(len-1);
        Vec3f perp0 = loc[i] - loc[i+1];
        Vec3f perp1 = perp0.cross( Vec3f::yAxis() );
        Vec3f perp2 = perp0.cross( perp1 );
        perp1 = perp0.cross( perp2 ).normalized();
        
        Vec3f off = perp1 * ( radius * agePer * per * 0.1f );
        
        gl::color( per, per * 0.25f, 1.0f - per, per * 0.5f );
        gl::vertex( loc[i] - off );
        gl::vertex( loc[i] + off );
    }
    
    gl::end();
}

void Particle::setAge()
{
    age += 1.0f;
    
    if( age > lifeSpan ) {
        ISDEAD = true;
    }
    else {
        agePer = 1.0f - age / (float)lifeSpan;
    }
}