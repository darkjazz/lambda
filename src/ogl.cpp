/*
 *  ogl.cpp
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

#include "ogl.h"

GLfloat no_mat[]			= { 0.0, 0.0, 0.0, 1.0 };
GLfloat mat_ambient[]		= { 0.3, 0.1, 0.4, 1.0 };
GLfloat mat_diffuse[]		= { 0.3, 0.5, 0.8, 1.0 };
GLfloat mat_specular[]		= { 0.1, 0.1, 0.3, 0.1 };
GLfloat mat_emission[]		= { 0.1, 0.1, 0.3, 0.1 };
GLfloat no_shininess[]		= { 0.0 };
GLfloat mat_shininess[]		= { 128.0 };


void GraphicsRenderer::setupOgl () {
	
	_bgr = _bgg = _bgb = 0.0;
	
	gl::clear( Color( _bgr, _bgg, _bgb ) );	
	
	smShader = gl::GlslProg(loadResource( "vert.glsl" ), loadResource( "frag.glsl" ) );	
	
	boidShader = gl::GlslProg( loadResource( "boid_vert.glsl" ), loadResource( "boid_frag.glsl" ) );
	boidShader01 = gl::GlslProg( loadResource( "glass_vert.glsl" ), loadResource( "glass_frag.glsl" ) );
	
	img00 = loadImage( loadResource("l_26.jpg") );
	img01 = loadImage( loadResource("mtrx_004.jpg") );
	img02 = loadImage( loadResource("mtrx_07.jpg") );
	img03 = loadImage( loadResource("fx_flat.png") );
	img04 = loadImage( loadResource("fu_00.png") );
	img05 = loadImage( loadResource("lambdaICO.png") );
    
    pImg = loadImage( loadResource( "particle.png" ) );
    eImg = loadImage( loadResource( "emitter.png" ) );
    
    for (int i = 0; i <= 8; i++) {
        std::stringstream sstm;
        sstm << "0" << i << ".png";
        img.push_back(loadImage( loadResource( sstm.str() ) ));
    }
	
	mMaps.push_back( CubeMap( GLsizei(128), GLsizei(128),
							 Surface8u( loadImage( loadResource( "fxic_pos_x.png" ) ) ),
							 Surface8u( loadImage( loadResource( "fxic_pos_y.png" ) ) ),
							 Surface8u( loadImage( loadResource( "fxic_pos_z.png" ) ) ),
							 Surface8u( loadImage( loadResource( "fxic_neg_x.png" ) ) ),
							 Surface8u( loadImage( loadResource( "fxic_neg_y.png" ) ) ),
							 Surface8u( loadImage( loadResource( "fxic_neg_z.png" ) ) ),
							 GL_RGB
							 ));
	
	mMaps.push_back( CubeMap( GLsizei(128), GLsizei(128),
							 Surface8u( loadImage( loadResource( "fxd_pos_x.png" ) ) ),
							 Surface8u( loadImage( loadResource( "fxd_pos_y.png" ) ) ),
							 Surface8u( loadImage( loadResource( "fxd_pos_z.png" ) ) ),
							 Surface8u( loadImage( loadResource( "fxd_neg_x.png" ) ) ),
							 Surface8u( loadImage( loadResource( "fxd_neg_y.png" ) ) ),
							 Surface8u( loadImage( loadResource( "fxd_neg_z.png" ) ) ),
							 GL_RGBA
							 ));
	mMaps.push_back( CubeMap( GLsizei(512), GLsizei(512),
							 Surface8u( loadImage( loadResource( "fxhl_pos_x.png" ) ) ),
							 Surface8u( loadImage( loadResource( "fxhl_pos_y.png" ) ) ),
							 Surface8u( loadImage( loadResource( "fxhl_pos_z.png" ) ) ),
							 Surface8u( loadImage( loadResource( "fxhl_neg_x.png" ) ) ),
							 Surface8u( loadImage( loadResource( "fxhl_neg_y.png" ) ) ),
							 Surface8u( loadImage( loadResource( "fxhl_neg_z.png" ) ) ),
							 GL_RGBA
							 ));	

	mMaps.push_back( CubeMap( GLsizei(99), GLsizei(99),
							 Surface8u( loadImage( loadResource( "fx_8_pos_x.png" ) ) ),
							 Surface8u( loadImage( loadResource( "fx_8_pos_y.png" ) ) ),
							 Surface8u( loadImage( loadResource( "fx_8_pos_z.png" ) ) ),
							 Surface8u( loadImage( loadResource( "fx_8_neg_x.png" ) ) ),
							 Surface8u( loadImage( loadResource( "fx_8_neg_y.png" ) ) ),
							 Surface8u( loadImage( loadResource( "fx_8_neg_z.png" ) ) ),
							 GL_RGBA
							 ));	

	mMaps.push_back( CubeMap( GLsizei(128), GLsizei(128),
							 Surface8u( loadImage( loadResource( "fxp_pos_x.png" ) ) ),
							 Surface8u( loadImage( loadResource( "fxp_pos_y.png" ) ) ),
							 Surface8u( loadImage( loadResource( "fxp_pos_z.png" ) ) ),
							 Surface8u( loadImage( loadResource( "fxp_neg_x.png" ) ) ),
							 Surface8u( loadImage( loadResource( "fxp_neg_y.png" ) ) ),
							 Surface8u( loadImage( loadResource( "fxp_neg_z.png" ) ) ),
							 GL_RGBA
							 ));	
	
	mMaps.push_back( CubeMap( GLsizei(221), GLsizei(221),
							 Surface8u( loadImage( loadResource( "fxh8_pos_x.png" ) ) ),
							 Surface8u( loadImage( loadResource( "fxh8_pos_y.png" ) ) ),
							 Surface8u( loadImage( loadResource( "fxh8_pos_z.png" ) ) ),
							 Surface8u( loadImage( loadResource( "fxh8_neg_x.png" ) ) ),
							 Surface8u( loadImage( loadResource( "fxh8_neg_y.png" ) ) ),
							 Surface8u( loadImage( loadResource( "fxh8_neg_z.png" ) ) ),
							 GL_RGBA
							 ));	
	
	
	mEye = Vec3f(0.0f, 0.0f, -30.0f);
	mCenter = Vec3f::zero();
	mUp = Vec3f::yAxis();
	
	mCam.lookAt(mEye, mCenter, mUp);
	mRotation.setToIdentity();
	
	glEnable( GL_TEXTURE_2D );
	codePanel.createTexture();	
	glDisable( GL_TEXTURE_2D );
	
	gl::enableDepthRead();
	gl::enableDepthWrite();		
	gl::enableAlphaBlending();	
	gl::enable(GL_LINE_SMOOTH);
    
//    mEmitter = Emitter();
//    bPerlin = true;
//    bTrails = true;
}

void GraphicsRenderer::setupBoidShader() {
	
	glEnable(GL_DEPTH_TEST);
	glDepthMask(GL_TRUE);
		
}

void GraphicsRenderer::reshape() {

	mCam.setPerspective(45.0, getWindowAspectRatio(), 0.1f, 2000.0f);
	gl::setMatrices( mCam );	

}

void GraphicsRenderer::update() {
		
	if (ptrWorld->initialized()) {
	
		fragSizeX = (double)(getWindowWidth() / ptrWorld->sizeX()) * 0.1;
		fragSizeY = (double)(getWindowHeight() / ptrWorld->sizeY()) * 0.1;
		fragSizeZ = (double)(getWindowWidth() / ptrWorld->sizeZ()) * 0.1;	
		
		hx = fragSizeX * ptrWorld->sizeX() * 0.5;
		hy = fragSizeY * ptrWorld->sizeY() * 0.5;
	}
	
	if (ptrWorld->somActivated) {
		ptrBMU = ptrWorld->currentBMU();
	}
	
	mRotation.rotate( rotateXYZ, rotateAngle );
	
	mCam.lookAt( mEye, mCenter, mUp );
	gl::setMatrices( mCam );

    gl::enableAdditiveBlending();
    glEnable( GL_MULTISAMPLE_ARB );
    glHint (GL_MULTISAMPLE_FILTER_HINT_NV, GL_NICEST);
    
    if (counter%3==0) {

        gl::clear( Color( _bgr, _bgg, _bgb ) );
        glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );

    }
    
	if (boids) {
	
		if (attachEyeToFirstBoid)
			mEye = boids->getBoidAtIndex(0)->pos;
		
		if (lookAtCentroid)
			mCenter = boids->centroid();	
		
	}
		
	if ( patternLib[21].active ) {
		
		bSHADER = true;
		
		gl::enable( GL_LIGHTING );
		gl::enable( GL_LIGHT0 );
		
		if (counter % 2 == 0) {
			bLIGHT = !bLIGHT;
		}
		
		if (ptrWorld->somActivated)
		{
			mDirectional -= ( mDirectional - 0.985f ) * 0.1f;
			blocx = ( ptrBMU->x * fragSizeX + (fragSizeX * 0.5f)) - getWindowWidth() * 0.05f;
			blocy = getWindowHeight() * 0.05f - ( ptrBMU->y * fragSizeY + (fragSizeY * 0.5f));
			blocz = ( ptrBMU->z * fragSizeX + (fragSizeX * 0.5f)) - getWindowWidth() * 0.05f;
		}
		else
		{
			mDirectional -= ( mDirectional - 0.51f ) * 0.1f;
		}
		
		mLightLoc -= ( mLightLoc - Vec3f(blocx, blocy, blocz) ) * 0.1f;
		
		GLfloat light_position[] = { mLightLoc.x, mLightLoc.y, mLightLoc.z, mDirectional };
		
		glLightfv( GL_LIGHT0, GL_POSITION, light_position );
		glLightf( GL_LIGHT0, GL_CONSTANT_ATTENUATION, 0.0f );
		glLightf( GL_LIGHT0, GL_LINEAR_ATTENUATION, 0.0f );
		glLightf( GL_LIGHT0, GL_QUADRATIC_ATTENUATION, 0.00015f );
		
	}
	else
	{
		bSHADER = false;
		gl::disable( GL_LIGHTING );
		gl::disable( GL_LIGHT0 );
		
	}

}

void GraphicsRenderer::drawCodePanel() {
	glDisable( GL_LIGHTING );
	glEnable( GL_TEXTURE_2D );
	glColor4f(1, 1, 1, 1);
	gl::pushMatrices();
	gl::setMatricesWindow( getWindowSize() );
	codePanel.update( Vec2f( getWindowWidth(), getWindowHeight() ) );
	gl::popMatrices();
	glDisable( GL_TEXTURE_2D );
}

void GraphicsRenderer::mapCodePanel() {
	glDisable( GL_LIGHTING );
	glEnable( GL_TEXTURE_2D );
	codePanel.bind();
	gl::pushMatrices();
	//gl::setMatricesWindow( getWindowSize() );
	//codePanel.update( Vec2f( getWindowWidth(), getWindowHeight() ) );
	gl::color( 0.8, 0.8, 0.8, codePanel.opacity );
	gl::drawCube( Vec3f( 0.0f, 0.0f, 0.0f ), Vec3f( hx * 2, hx * 2, hx * 2 ) );
	gl::popMatrices();
	codePanel.unbind();
	glDisable( GL_TEXTURE_2D );
}

/*
void GraphicsRenderer::drawMultiCodePanel()
{
	glDisable( GL_LIGHTING );
	
	
	for (int i = 0; i < multiCodePanel.panels.size(); i++)
	{
		glEnable( GL_TEXTURE_2D );
		multiCodePanel.panels[i].bind();
		gl::pushMatrices();
		gl::color( 0.8, 0.8, 0.8, multiCodePanel.panels[i].opacity );
//		gl::drawBillboard();
		//gl::drawCube( Vec3f( 0.0f, 0.0f, 0.0f ), Vec3f( hx * 2, hx * 2, hx * 2 ) );
		gl::popMatrices();
		multiCodePanel.panels[i].unbind();
		glDisable( GL_TEXTURE_2D );		
	}
		
}
*/

void GraphicsRenderer::createTriMesh() {
	//TriMesh mesh;
}

void GraphicsRenderer::startDraw() {
	gl::pushMatrices();
	gl::multModelView( mRotation );
}

void GraphicsRenderer::endDraw() {
	gl::popMatrices();
	if (codePanelActive) {
		if (codePanelMapped)
			mapCodePanel();		
		else
			drawCodePanel();
	}
	counter++;
}

void GraphicsRenderer::drawFragment(Cell* cell) {
	
	int x, y, z;
	currentCell = cell;
	x = currentCell->x;
	y = currentCell->y;
	z = currentCell->z;
	
	state = currentCell->phase;

	if (patternLib[0].active) {
		pattern00(x, y, z);
	}
	if (patternLib[1].active) {
		pattern01(x, y, z);	
	}
	if (patternLib[2].active) {
		pattern02(x, y, z);	
	}
	if (patternLib[3].active) {
		pattern03(x, y, z);	
	}
	if (patternLib[4].active) {
		pattern04(x, y, z);	
	}
	
    
	if (patternLib[5].active) {
		pattern05(x, y, z);	
	}
	if (patternLib[6].active) {
		pattern06(x, y, z);	
	}
	if (patternLib[7].active) {
		pattern07(x, y, z);	
	}
	if (patternLib[8].active) {
		pattern08(x, y, z);	
	}
	if (patternLib[9].active) {
		pattern09(x, y, z);	
	}
    
    
	if (patternLib[10].active) {
		pattern10(x, y, z);	
	}
	if (patternLib[11].active) {
		pattern11(x, y, z);	
	}
	if (patternLib[12].active) {
		pattern12(x, y, z);	
	}
	if (patternLib[13].active) {
		pattern13(x, y, z);	
	}
	if (patternLib[14].active) {
		pattern14(x, y, z);	
	}
    
    
	if (patternLib[15].active) {
		pattern15(x, y, z);	
	}
	if (patternLib[16].active) {
		pattern16(x, y, z);	
	}
	if (patternLib[17].active) {
		pattern17(x, y, z);	
	}
	if (patternLib[18].active) {
		pattern18(x, y, z);	
	}
	if (patternLib[19].active) {
		pattern19(x, y, z);	
	}
    
    
	if (patternLib[20].active) {
		pattern20(x, y, z);	
	}
	if (patternLib[21].active) {
		pattern21(x, y, z);	
	}
	if (patternLib[22].active) {
		pattern22(x, y, z);	
	}
	if (patternLib[23].active) {
		pattern23(x, y, z);	
	}
	if (patternLib[24].active) {
		pattern24(x, y, z);	
	}
    
    
	if (patternLib[25].active) {
		pattern25(x, y, z);	
	}
	if (patternLib[26].active) {
		pattern26(x, y, z);	
	}
	if (patternLib[27].active) {
		pattern27(x, y, z);	
	}
	if (patternLib[28].active) {
		pattern28(x, y, z);	
	}
	if (patternLib[29].active) {
		pattern29(x, y, z);	
	}
    
    
	if (patternLib[30].active) {
		pattern30(x, y, z);	
	}
	if (patternLib[31].active) {
		pattern31(x, y, z);	
	}
	if (patternLib[32].active) {
		pattern32(x, y, z);	
	}
	if (patternLib[33].active) {
		pattern33(x, y, z);	
	}
	if (patternLib[34].active) {
		pattern34(x, y, z);	
	}
    
    
	if (patternLib[35].active) {
		pattern35(x, y, z);	
	}
    if (patternLib[36].active) {
        pattern36(x, y, z);
    }
    if (patternLib[37].active) {
        pattern37(x, y, z);
    }
    if (patternLib[38].active) {
        pattern38(x, y, z);
    }
    if (patternLib[39].active) {
        pattern39(x, y, z);
    }
	
}

void GraphicsRenderer::pattern00(int x, int y, int z) {
	
	float cstate;
	
	if (ptrWorld->ruleType() == CONT) {
		cstate = state;
	}
	else {
		if (state != 0)
		{
			cstate = 1.0 / state;
		}
		else {
			cstate = 0.0f;
		}
	}
	
	if (ptrWorld->ruleType() == CONT || cstate != 0.0f) {
		
		xL = (float)x * fragSizeX + (fragSizeX * 0.5) - (fragSizeX * 2.0 * cstate);
		yB = (float)y * fragSizeX + (fragSizeY * 0.5) - (fragSizeY * 2.0 * cstate);
		zF = (float)z * fragSizeZ + (fragSizeZ * 0.5) - (fragSizeZ * 2.0 * cstate);
		
		xW = fragSizeX * cstate * 4.0;
		yH = fragSizeX * cstate * 4.0;
		zD = fragSizeZ * cstate * 4.0;
		
		xL -= hx;
		yB -= hx;
		zF -= hx;
		
		red = patternLib[0].color.r * abs(patternLib[0].colormap - cstate);
		green = patternLib[0].color.g * abs(patternLib[0].colormap - cstate);
		blue = patternLib[0].color.b * abs(patternLib[0].colormap - cstate);
		alpha = patternLib[0].alpha * abs(patternLib[0].alphamap - cstate);
		
		if (x == 0) { 
			strokeRect(1, 1.0);
		}
		
		if (y == 0) {
			strokeRect(2, 1.0);
		}
		
		if (z == 0) {
			strokeRect(0, 1.0);
		}
				
		if (x == ptrWorld->sizeX()-1 && y < ptrWorld->sizeY()-1 && z < ptrWorld->sizeZ()-1) {
			xL += (xW * cstate);
			strokeRect(1, 1.0);
		}
		if (y == ptrWorld->sizeY()-1 && z < ptrWorld->sizeZ()-1 && x < ptrWorld->sizeX()-1) {
			yB += (yH * cstate);
			strokeRect(2, 1.0);
		}	
		if (z == ptrWorld->sizeZ()-1 && x < ptrWorld->sizeX()-1 && y < ptrWorld->sizeY()-1) {
			zF += (zD * cstate);
			strokeRect(0, 1.0);	
		}
	}	
}

void GraphicsRenderer::pattern01(int x, int y, int z) {
	
	float cstate;
	
	if (ptrWorld->ruleType() == CONT) {
		cstate = state;
	}
	else {
		if (state != 0)
		{
			cstate = 1.0 / state;
		}
		else {
			cstate = 0.0f;
		}
	}
	
	if (ptrWorld->ruleType() == CONT || cstate != 0.0f) {
		xL = (float)x * fragSizeX + (fragSizeX * 0.5) - (fragSizeX * 2.0 * cstate);
		yB = (float)y * fragSizeX + (fragSizeY * 0.5) - (fragSizeY * 2.0 * cstate);
		zF = (float)z * fragSizeZ + (fragSizeZ * 0.5) - (fragSizeZ * 2.0 * cstate);
		
		xW = mapf(fragSizeX * cstate, 0.5, 2.0);
		yH = mapf(fragSizeX * cstate, 0.5, 2.0);
		zD = mapf(fragSizeX * cstate, 0.5, 2.0);
		
		xL -= hx;
		yB -= hx;
		zF -= hx;
		
		red = patternLib[1].color.r * abs(patternLib[1].colormap - cstate);
		green = patternLib[1].color.g * abs(patternLib[1].colormap - cstate);
		blue = patternLib[1].color.b * abs(patternLib[1].colormap - cstate);
		alpha = patternLib[1].alpha * abs(patternLib[1].alphamap - cstate);
        
		if (x == 0) { 
			fillRect(1);
		}
		
		if (y == 0) {
			fillRect(2);
		}
		
		if (z == 0) {
			fillRect(0);
		}
		
		if (x == ptrWorld->sizeX()-1 && y < ptrWorld->sizeY()-1 && z < ptrWorld->sizeZ()-1) {
			xL += (xW * state);
			fillRect(1);
		}
		if (y == ptrWorld->sizeY()-1 && z < ptrWorld->sizeZ()-1 && x < ptrWorld->sizeX()-1) {
			yB += (yH * state);
			fillRect(2);
		}	
		if (z == ptrWorld->sizeZ()-1 && x < ptrWorld->sizeX()-1 && y < ptrWorld->sizeY()-1) {
			zF += (zD * state);
			fillRect(0);	
		}
        
	}
}

void GraphicsRenderer::pattern02(int x, int y, int z) {

	float cstate;
	
	if (ptrWorld->ruleType() == CONT) {
		cstate = state;
	}
	else {
		if (state != 0)
		{
			cstate = 1.0 / state;
		}
		else {
			cstate = 0.0f;
		}
	}
	
	xL = ((ptrWorld->sizeX()*fragSizeX/2) - ((float)x * fragSizeX)) * cstate + (fragSizeX * 0.5) - (fragSizeX * 2.0 * cstate);
	yB = ((ptrWorld->sizeY()*fragSizeX/2) - ((float)y * fragSizeY)) * cstate + (fragSizeY * 0.5) - (fragSizeY * 2.0 * cstate);
	zF = ((ptrWorld->sizeZ()*fragSizeX/2) - ((float)z * fragSizeZ)) * cstate + (fragSizeZ * 0.5) - (fragSizeZ * 2.0 * cstate);
	
	xW = mapf(fragSizeX * cstate, fragSizeX * 0.5, fragSizeX * 2.0);
	yH = mapf(fragSizeX * cstate, fragSizeX * 0.5, fragSizeX * 2.0);
	zD = mapf(fragSizeX * cstate, fragSizeX * 0.5, fragSizeX * 2.0);
	
	red = patternLib[2].color.r * abs(patternLib[2].colormap - cstate);
	green = patternLib[2].color.g * abs(patternLib[2].colormap - cstate);
	blue = patternLib[2].color.b * abs(patternLib[2].colormap - cstate);
	alpha = patternLib[2].alpha * abs(patternLib[2].alphamap - cstate);

    glDisable( GL_LIGHTING );
    glEnable( GL_TEXTURE_2D );
    img[7].bind();
    gl::pushMatrices();
    
    gl::color(red, green, blue, alpha);
			
	if (x == 0) {
        gl::drawCube( Vec3f(x * fragSizeX, yB, zF), Vec3f( fragSizeX * 0.1, yH, zD ) );
//		fillRect(1);
	}
	
	if (y == 0) {
        gl::drawCube( Vec3f(xL, y * fragSizeY, zF), Vec3f( xW, fragSizeY * 0.1, zD ) );
//        fillRect(2);
	}
	
	if (z == 0) {
        gl::drawCube( Vec3f(xL, yB, z * fragSizeZ), Vec3f( xW, yH, fragSizeZ * 0.1 ) );
//        fillRect(0);
	}
	
	if (x == ptrWorld->sizeX()-1) {
        gl::drawCube( Vec3f(x * fragSizeX + fragSizeX, yB, zF), Vec3f( fragSizeX * 0.1, yH, zD ) );
//		xL += (xW * cstate);
//		fillRect(1);
	}
	if (y == ptrWorld->sizeY()-1 ) {
        gl::drawCube( Vec3f(xL, y * fragSizeY + fragSizeY, zF), Vec3f( xW, fragSizeY * 0.1, zD ) );
//		yB += (yH * cstate);
//		fillRect(2);
	}
	if (z == ptrWorld->sizeZ()-1 ) {
        gl::drawCube( Vec3f(xL, yB, z * fragSizeZ + fragSizeZ), Vec3f( xW, yH, fragSizeZ * 0.1 ) );
//		zF += (zD * cstate);
//		fillRect(0);
	}
    
    gl::popMatrices();
    img[7].unbind();
    glDisable( GL_TEXTURE_2D );
    

}

void GraphicsRenderer::pattern03(int x, int y, int z) {
    float cstate;
    
    if (ptrWorld->ruleType() == CONT) {
        cstate = state;
    }
    else {
        if (state != 0)
        {
            cstate = 1.0 / state;
        }
        else {
            cstate = 0.0f;
        }
    }
    
    if (ptrWorld->ruleType() == CONT || cstate != 0.0f) {
        
        float mapState, maxState;
        
        maxState = ptrWorld->rule()->numStates() - 1;
        mapState = (maxState - currentCell->states[ptrWorld->index()]) * (1 / maxState);
        
        xL = (float)x * fragSizeX + fragSizeX - (fragSizeX * 0.5);
        yB = (float)y * fragSizeX + fragSizeX - (fragSizeX * 0.5);
        zF = (float)z * fragSizeX + fragSizeX - (fragSizeX * 0.5);
        
        xW = yH = zD = mapf(fragSizeX * mapState, 0.25, 0.75);
        
        xL -= hx;
        yB -= hx;
        zF -= hx;
        
        red = patternLib[3].color.r * abs(patternLib[3].colormap - mapState);
        green = patternLib[3].color.g * abs(patternLib[3].colormap - mapState);
        blue = patternLib[3].color.b * abs(patternLib[3].colormap - mapState);
        alpha = patternLib[3].alpha * abs(patternLib[3].alphamap - mapState);
        
        gl::color(red, green, blue, alpha);
//        gl::drawStrokedCube( Vec3f(xL, yB, zF), Vec3f(xW, yH, zD) );
        gl::drawSphere( Vec3f(xL, yB, zF), xW);
        
    }
}

void GraphicsRenderer::pattern04(int x, int y, int z) {

	float cstate;
	
	if (ptrWorld->ruleType() == CONT) {
		cstate = state;
	}
	else {
		if (state != 0)
		{
			cstate = 1.0 / state;
		}
		else {
			cstate = 0.0f;
		}
	}

    xL = ((ptrWorld->sizeX()*fragSizeX/2) - ((float)x * fragSizeX)) * cstate + (fragSizeX * 0.5) - (fragSizeX * 2.0 * cstate);
    yB = ((ptrWorld->sizeY()*fragSizeX/2) - ((float)y * fragSizeY)) * cstate + (fragSizeY * 0.5) - (fragSizeY * 2.0 * cstate);
    zF = ((ptrWorld->sizeZ()*fragSizeX/2) - ((float)z * fragSizeZ)) * cstate + (fragSizeZ * 0.5) - (fragSizeZ * 2.0 * cstate);
    
    xW = mapf(fragSizeX * cstate, fragSizeX * 0.5, fragSizeX * 2.0);
    yH = mapf(fragSizeX * cstate, fragSizeX * 0.5, fragSizeX * 2.0);
    zD = mapf(fragSizeX * cstate, fragSizeX * 0.5, fragSizeX * 2.0);
    
    red = patternLib[4].color.r * abs(patternLib[4].colormap - cstate);
    green = patternLib[4].color.g * abs(patternLib[4].colormap - cstate);
    blue = patternLib[4].color.b * abs(patternLib[4].colormap - cstate);
    alpha = patternLib[4].alpha * abs(patternLib[4].alphamap - cstate);
    
    glDisable( GL_LIGHTING );
    glEnable( GL_TEXTURE_2D );
    img[0].bind();
    gl::pushMatrices();
    
    gl::color(red, green, blue, alpha);
    
    if (x == 0) {
        gl::drawCube( Vec3f(x * fragSizeX, yB, zF), Vec3f( fragSizeX * 0.1, yH, zD ) );
        //		fillRect(1);
    }
    
    if (y == 0) {
        gl::drawCube( Vec3f(xL, y * fragSizeY, zF), Vec3f( xW, fragSizeY * 0.1, zD ) );
        //        fillRect(2);
    }
    
    if (z == 0) {
        gl::drawCube( Vec3f(xL, yB, z * fragSizeZ), Vec3f( xW, yH, fragSizeZ * 0.1 ) );
        //        fillRect(0);
    }
    
    if (x == ptrWorld->sizeX()-1) {
        gl::drawCube( Vec3f(x * fragSizeX + fragSizeX, yB, zF), Vec3f( fragSizeX * 0.1, yH, zD ) );
        //		xL += (xW * cstate);
        //		fillRect(1);
    }
    if (y == ptrWorld->sizeY()-1 ) {
        gl::drawCube( Vec3f(xL, y * fragSizeY + fragSizeY, zF), Vec3f( xW, fragSizeY * 0.1, zD ) );
        //		yB += (yH * cstate);
        //		fillRect(2);
    }
    if (z == ptrWorld->sizeZ()-1 ) {
        gl::drawCube( Vec3f(xL, yB, z * fragSizeZ + fragSizeZ), Vec3f( xW, yH, fragSizeZ * 0.1 ) );
        //		zF += (zD * cstate);
        //		fillRect(0);
    }
    
    gl::popMatrices();
    img[0].bind();
    glDisable( GL_TEXTURE_2D );
    
	
}

/*

void GraphicsRenderer::pattern05(int x, int y, int z) {
	int i;
	float ex, ey, ez;
	float hx, hy;
	
	if (
		(	x != 0 && y != 0 && z != 0 && 
		 x != ptrWorld->sizeX()-1 && y != ptrWorld->sizeY()-1 && z != ptrWorld->sizeZ()-1
		 ) && 
		(
		 x == (int)(ptrWorld->sizeX() / 3.0) || x == (int)(ptrWorld->sizeX() * 2.0 / 3.0) ||
		 z == (int)(ptrWorld->sizeZ() / 3.0) || z == (int)(ptrWorld->sizeZ() * 2.0 / 3.0)	
		 )
		)
	{
		if (currentCell->states[ptrWorld->index()] > 0) {
			
			hx = fragSizeX * ptrWorld->sizeX() * 0.5;
			hy = fragSizeY * ptrWorld->sizeY() * 0.5;			
			
			xL = x * fragSizeX + (fragSizeX * 0.5);
			yB = y * fragSizeY + (fragSizeY * 0.5);
			zF = z * fragSizeZ + (fragSizeZ * 0.5);
			
			xL -= hx;
			yB -= hy;
			
			state = unmapf(state, 1, 10);
			
			for (i = 0; i < ptrWorld->rule()->nSize(); i++) {
				Cell* n;
				n = ptrWorld->rule()->getNeighbor(currentCell, i);
				if (n->states[ptrWorld->index()] > 0 && n->states[ptrWorld->index()] < 10)
				{
					ex = n->x * fragSizeX + (fragSizeX * 0.5);
					ey = n->y * fragSizeY + (fragSizeY * 0.5);
					ez = n->z * fragSizeZ + (fragSizeZ * 0.5);
					
					ex -= hx;
					ey -= hy;	
					
					red = patternLib[5].color.r;
					green = patternLib[5].color.g;
					blue = patternLib[5].color.b * abs(patternLib[14].colormap - state);
					alpha = patternLib[5].alpha * abs(patternLib[14].alphamap - state);
					
					gl::color(red, green, blue, alpha);				
					gl::drawLine( Vec3f(xL, yB, zF), Vec3f(ex, ey, ez) );
				}
			}
		}
	}
	
}

void GraphicsRenderer::pattern06(int x, int y, int z) {
	if (ptrWorld->currentBMU()) {
		Cell* bmu;
		double radius, dist, hx;
		bmu = ptrWorld->currentBMU();
		radius = ((double)ptrWorld->sizeX() / 3.0);		
		dist = pow(ptrWorld->currentBMU()->x - x, 2.0) + pow(ptrWorld->currentBMU()->y - y, 2.0) + pow(ptrWorld->currentBMU()->z - z, 2.0);

		hx = fragSizeX * ptrWorld->sizeX() * 0.5;

		if (dist < radius) {			
			
			xL = (float)x * fragSizeX + (fragSizeX * 0.5);
			yB = (float)y * fragSizeX + (fragSizeY * 0.5);
			zF = (float)z * fragSizeX + (fragSizeZ * 0.5);
			
			xL -= hx;
			yB -= hx;
			zF -= hx;
			
			if (dist == 0.0) {
				xW = fragSizeX * mapf(state, 1.0, 2.0);
				yH = fragSizeX * mapf(state, 1.0, 2.0);
				zD = fragSizeX * mapf(state, 1.0, 2.0);								
			}
			else {
				xW = fragSizeX * state * mapf(dist/radius, 1.0, 2.0);
				yH = fragSizeX * state * mapf(dist/radius, 1.0, 2.0);
				zD = fragSizeX * state * mapf(dist/radius, 1.0, 2.0);			
			}
			
			red = patternLib[6].color.r * abs(patternLib[6].colormap - state) * currentCell->weights[0];
			green = patternLib[6].color.g * abs(patternLib[6].colormap - state) * currentCell->weights[1];
			blue = patternLib[6].color.b * abs(patternLib[6].colormap - state) * currentCell->weights[2];
			alpha = patternLib[6].alpha * abs(patternLib[6].alphamap - state);	
//			alpha *= ((2.0/dist) * currentCell->weights[3]);


			if (x == ptrWorld->currentBMU()->x && y == ptrWorld->currentBMU()->y && z == ptrWorld->currentBMU()->z) {
				gl::color(red, green, blue, alpha);
				gl::drawSphere( Vec3f(xL, yB, zF), xW, 24 );
				
				gl::color(red*0.8, green*0.8, blue*0.8, alpha*0.8);
				
				gl::drawCube( Vec3f(xL, yB, zF), Vec3f(fragSizeX * 200.0, fragSizeX * 0.5, fragSizeX * 0.5) );
				gl::drawCube( Vec3f(xL, yB, zF), Vec3f(fragSizeX * 0.5, fragSizeX * 200.0, fragSizeX * 0.5) );
				gl::drawCube( Vec3f(xL, yB, zF), Vec3f(fragSizeX * 0.5, fragSizeX * 0.5, fragSizeX * 200.0) );
				
			}
			else {
				gl::color(red, green, blue, alpha*0.5);
				gl::drawSphere( Vec3f(xL, yB, zF), xW, 16 );				
			}

			
			
		}
		
		for (int i = 0; i < ptrWorld->bestMatchHistorySize(); i++) {
			
			Index3D* coords;
			coords = ptrWorld->bestMatchHistoryAt(i);
			
			if (coords->x == x && coords->y == y && coords->z == z) {
			
				xL = (float)x * fragSizeX + (fragSizeX * 0.5);
				yB = (float)y * fragSizeX + (fragSizeY * 0.5);
				zF = (float)z * fragSizeX + (fragSizeZ * 0.5);
				
				xL -= hx;
				yB -= hx;
				zF -= hx;
				
				xW = fragSizeX;
								
				alpha = (10.0 - (i + 1) / 10.0);
				
				gl::color(0.7, 0.7, 0.7, alpha);
				gl::drawSphere( Vec3f(xL, yB, zF), xW, 24 );

				gl::drawCube( Vec3f(xL, yB, zF), Vec3f(fragSizeX * (10.0 - (i + 1) / 10.0), fragSizeX * 0.25, fragSizeX * 0.25) );
				gl::drawCube( Vec3f(xL, yB, zF), Vec3f(fragSizeX * 0.25, fragSizeX * (10.0 - (i + 1) / 10.0), fragSizeX * 0.25) );
				gl::drawCube( Vec3f(xL, yB, zF), Vec3f(fragSizeX * 0.25, fragSizeX * 0.25, fragSizeX * (10.0 - (i + 1) / 10.0)) );				
				
			}		
		}	
	}

}

void GraphicsRenderer::pattern07(int x, int y, int z) {


	if (ptrWorld->currentBMU()) {
		Cell* bmu = ptrWorld->currentBMU();
		if (ptrWorld->currentBMU()->x == x && ptrWorld->currentBMU()->y == y && ptrWorld->currentBMU()->z == z) {
			
			double hx, ex, ey, ez;
			Index3D *prevCoords, *currCoords;
			hx = fragSizeX * ptrWorld->sizeX() * 0.5;

			xL = (float)x * fragSizeX + (fragSizeX * 0.5);
			yB = (float)y * fragSizeX + (fragSizeY * 0.5);
			zF = (float)z * fragSizeX + (fragSizeZ * 0.5);
			
			xL -= hx;
			yB -= hx;
			zF -= hx;
			
			xW = fragSizeX;
			
			red = patternLib[7].color.r * abs(patternLib[7].colormap - currentCell->weights[0]);
			green = patternLib[7].color.g * abs(patternLib[7].colormap - currentCell->weights[1]);
			blue = patternLib[7].color.b * abs(patternLib[7].colormap - currentCell->weights[2]);
//			alpha = patternLib[7].alpha * abs(patternLib[7].alphamap - 1.0);	
			
			alpha = 1.0;
			
			gl::color(red, green, blue, alpha);
			gl::drawSphere( Vec3f(xL, yB, zF), xW, 24 );
			
			if (ptrWorld->bestMatchHistorySize() > 0) {
			
				currCoords = ptrWorld->bestMatchHistoryAt(0);
				
				ex = (float)currCoords->x * fragSizeX + (fragSizeX * 0.5);
				ey = (float)currCoords->y * fragSizeX + (fragSizeY * 0.5);
				ez = (float)currCoords->z * fragSizeX + (fragSizeZ * 0.5);
				
				ex -= hx;
				ey -= hx;
				ez -= hx;			
				
				gl::drawLine( Vec3f(xL, yB, zF), Vec3f(ex, ey, ez));
				gl::drawSphere( Vec3f(ex, ey, ez ), fragSizeX * 0.9, 20 );
				
				for (int i = 1; i < ptrWorld->bestMatchHistorySize(); i++) {
					
					prevCoords = currCoords;
					currCoords = ptrWorld->bestMatchHistoryAt(i);
					
					xL = (float)prevCoords->x * fragSizeX + (fragSizeX * 0.5);
					yB = (float)prevCoords->y * fragSizeX + (fragSizeY * 0.5);
					zF = (float)prevCoords->z * fragSizeX + (fragSizeZ * 0.5);
					
					xL -= hx;
					yB -= hx;
					zF -= hx;
					
					ex = (float)currCoords->x * fragSizeX + (fragSizeX * 0.5);
					ey = (float)currCoords->y * fragSizeX + (fragSizeY * 0.5);
					ez = (float)currCoords->z * fragSizeX + (fragSizeZ * 0.5);
					
					ex -= hx;
					ey -= hx;
					ez -= hx;
					
					red *= 0.96;
					green *= 0.9605;
					blue *= 0.961;
					alpha *= 0.98;
					
					gl::color(red, green, blue, alpha);				
					
					gl::drawLine( Vec3f(xL, yB, zF), Vec3f(ex, ey, ez));
					gl::drawSphere( Vec3f(ex, ey, ez ), fragSizeX * (1.0-(i*0.02)), 16 );
					
				}
			}			
		}
	}
}
 
*/

// Life and Generations draw (sparsematrix)

void GraphicsRenderer::pattern05(int x, int y, int z) {

	if (state > 0.0) {
		
		float unmap, cstate;
		
		unmap = 1.0-unmapf(state, 0, ptrWorld->rule()->numStates()-1);
		cstate = currentCell->states[ptrWorld->index()];
		
		xL = (float)x * fragSizeX + (fragSizeX * 0.5) - (fragSizeX * unmap);
		yB = (float)y * fragSizeX + (fragSizeY * 0.5) - (fragSizeY * unmap);
		zF = (float)z * fragSizeZ + (fragSizeZ * 0.5) - (fragSizeZ * unmap);
		
		xW = fragSizeX * unmap * 2.0;
		yH = fragSizeX * unmap * 2.0;
		zD = fragSizeZ * unmap * 2.0;
		
		xL -= hx;
		yB -= hx;
		zF -= hx;
		
		red = patternLib[5].color.r * abs(patternLib[5].colormap - unmap);
		green = patternLib[5].color.g * abs(patternLib[5].colormap - unmap);
		blue = patternLib[5].color.b * abs(patternLib[5].colormap - unmap);
		alpha = patternLib[5].alpha * abs(patternLib[5].alphamap - unmap);
		
		
		if ((x == ptrWorld->sizeX() / 2 && isEven(state)) || (x == ptrWorld->sizeX() / 2 - 1 && !isEven(state))) {
			fillRect(1);
		}

		if ((y == ptrWorld->sizeY() / 2 && isEven(state)) || (y == ptrWorld->sizeY() / 2 - 1 && !isEven(state))) {
			fillRect(2);
		}
		
		if ((z == ptrWorld->sizeZ() / 2 && isEven(state)) || (z == ptrWorld->sizeZ() / 2 - 1 && !isEven(state))) {
			fillRect(0);			
		}
		
		/*

		if (x == ptrWorld->sizeX() / 3 && between(y, ptrWorld->sizeY() / 3, ptrWorld->sizeY()*2/3-2) && between(z, ptrWorld->sizeZ() / 3, ptrWorld->sizeZ()*2/3-2) ) { 
			if (cstate > 0.0 && cstate < 2.0) 
				strokeRect(1, 1.0);
			else
				fillRect(1);
		}
		
		if (y == ptrWorld->sizeY() / 3 && between(z, ptrWorld->sizeZ() / 3, ptrWorld->sizeZ()*2/3-2) && between(x, ptrWorld->sizeX() / 3, ptrWorld->sizeX()*2/3-2)) {
			if (cstate > 0.0 && cstate < 2.0)
				strokeRect(2, 1.0);
			else
				fillRect(2);
		}
		
		if (z == ptrWorld->sizeZ() / 3 && between(x, ptrWorld->sizeX() / 3, ptrWorld->sizeX()*2/3-2) && between(y, ptrWorld->sizeY() / 3, ptrWorld->sizeY()*2/3-2)) {
			if (cstate > 0.0 && cstate < 2.0)
				strokeRect(0, 1.0);
			else
				fillRect(0);
		}
		
		if (x == ptrWorld->sizeX()*2/3-1 && between(y, ptrWorld->sizeY() / 3, ptrWorld->sizeY()*2/3-2) && between(z, ptrWorld->sizeZ() / 3, ptrWorld->sizeZ()*2/3-2)) {
			xL += (xW * unmap);
			if (cstate > 0.0 && cstate < 2.0) 
				strokeRect(1, 1.0);
			else
				fillRect(1);
			
		}
		if (y == ptrWorld->sizeY()*2/3-1 && between(z, ptrWorld->sizeZ() / 3, ptrWorld->sizeZ()*2/3-2) && between(x, ptrWorld->sizeX() / 3, ptrWorld->sizeX()*2/3-2)) {
			yB += (yH * unmap);
			if (cstate > 0.0 && cstate < 2.0)
				strokeRect(2, 1.0);
			else
				fillRect(2);
		}	
		if (z == ptrWorld->sizeZ()*2/3-1 && between(x, ptrWorld->sizeX() / 3, ptrWorld->sizeX()*2/3-2) && between(y, ptrWorld->sizeY() / 3, ptrWorld->sizeY()*2/3-2)) {
			zF += (zD * unmap);
			if (cstate > 0.0 && cstate < 2.0)
				strokeRect(0, 1.0);	
			else
				fillRect(0);
		}
		 
		*/

	}
	
}

void GraphicsRenderer::pattern06(int x, int y, int z) {

	if (x != 0 && y != 0 && (z == ptrWorld->sizeZ() / 2 || z == 0 || z == ptrWorld->sizeZ() - 1) && x < ptrWorld->sizeX() - 1 && y < ptrWorld->sizeY() - 1 && state > 0.0) {
		
		float unmap, unother;
		int i;
		
		unmap = unmapf(state, 0, ptrWorld->rule()->numStates()-1);
		
		hx = fragSizeX * ptrWorld->sizeX() * 0.5;		
		xL = x * fragSizeX + (fragSizeX * 0.5);
		yB = y * fragSizeY + (fragSizeY * 0.5);
		
		xL -= hx;
		yB -= hx;
		
		zF = z * fragSizeX + (fragSizeX * unmap * -4.0);
		
		zF -= hx;
		
		red = patternLib[6].color.r * abs(patternLib[6].colormap - unmap);
		green = patternLib[6].color.g * abs(patternLib[6].colormap - unmap);
		blue = patternLib[6].color.b * abs(patternLib[6].colormap - unmap);
		alpha = patternLib[6].alpha * abs(patternLib[6].alphamap - unmap);	
		
		gl::color(red, green, blue, alpha);

		gl::drawSphere( Vec3f(xL, yB, zF), fragSizeY * unmap * 0.1f, 16 );

		glBegin(GL_LINES);
		
		for (i = 2; i < 26; i+=3) {
			
			if (ptrWorld->rule()->getNeighbor(currentCell, i)->states[currentIndex] > 0.0) {
				xW = ptrWorld->rule()->getNeighbor(currentCell, i)->x * fragSizeX + (fragSizeX * 0.5);
				yH = ptrWorld->rule()->getNeighbor(currentCell, i)->y * fragSizeY + (fragSizeY * 0.5);
				
				xW -= hx;
				yH -= hx;

				red = patternLib[6].color.r * abs(patternLib[6].colormap - unmap);
				green = patternLib[6].color.g * abs(patternLib[6].colormap - unmap);
				blue = patternLib[6].color.b * abs(patternLib[6].colormap - unmap);
				alpha = patternLib[6].alpha * abs(patternLib[6].alphamap - unmap);	
				
				gl::color(red, green, blue, alpha);

				gl::vertex( Vec3f(xL, yB, zF) );
				
				unother = unmapf(ptrWorld->rule()->getNeighbor(currentCell, i)->states[currentIndex], 0, ptrWorld->rule()->numStates()-1);
				
				zD = z * fragSizeX + (fragSizeX * unother * -4.0);
				
				zD -= hx;	
				
				red = patternLib[6].color.r * abs(patternLib[6].colormap - unother);
				green = patternLib[6].color.b * abs(patternLib[6].colormap - unother);
				blue = patternLib[6].color.g * abs(patternLib[6].colormap - unother);
				alpha = patternLib[6].alpha * abs(patternLib[6].alphamap - unother);	
				
				gl::color( red, green, blue, alpha );
				
				gl::vertex( Vec3f(xW, yH, zD) );
				
//				gl::drawLine( Vec3f(xL, yB, zF), Vec3f(xW, yH, zD) );
				
			}
			
		}
		
		glEnd();
		
	}
	
}

void GraphicsRenderer::pattern07(int x, int y, int z) {
	
    if (state > 0.0) {
        
        float t, c, unmap, w, h, d;
        
        float rx= sin(counter*0.035f);
        float ry= sin(counter*0.025f);
        float rz= sin(counter*0.045f);
        float tx= sin(counter*0.020f)+rx;
        float ty= sin(counter*0.023f)+ry;
        float tz= sin(counter*0.027f)+rz;
        
        unmap = unmapf(state, 0, ptrWorld->rule()->numStates()-1);
        
        w = x*fragSizeX + (fragSizeX * unmap);
        h = y*fragSizeY + (fragSizeY * unmap);
        d = z*fragSizeX + (fragSizeX * unmap);
        
        w -= hx;
        h -= hx;
        d -= hx;
        
        red = patternLib[7].color.r * abs(patternLib[7].colormap - unmap);
        green = patternLib[7].color.g * abs(patternLib[7].colormap - unmap);
        blue = patternLib[7].color.b * abs(patternLib[7].colormap - unmap);
        alpha = patternLib[7].alpha * abs(patternLib[7].alphamap - unmap);
        
        t = ((float)x + 50.0f) / (ptrWorld->sizeX() + 50.0);
        c= sin(t*PI*2)*0.5f+0.5f;
        xL = (sin(t*PI*2*rx*tx)*unmap*t*0.5f)*w;
        yB = (cos(t*PI*2*ry*ty)*unmap*t*0.5f)*h;
        zF = (sin(t*PI*2*rz*tz)*unmap*t*0.5f)*d;
        
        xW = (cos(t*PI*2*rx*tx)*(1-unmap)*t*0.5f)*w;
        yH = (sin(t*PI*2*rx*tx)*(1-unmap)*t*0.5f)*h;
        zD = (cos(t*PI*2*rz*tz)*(1-unmap)*t*0.5f)*d;
        
        gl::color( red, green, blue, alpha );
        drawPoint(xL, yB, zF, mapf(unmap, 17.0, 1.0));
        drawPoint(xW, yH, zD, mapf(unmap, 17.0, 1.0));
    }
}

void GraphicsRenderer::pattern08(int x, int y, int z) {

	if (state > 0.0) {
		
		float t, c, unmap, w, h, d;
		
		float rx= sin(counter*0.035f);
		float ry= sin(counter*0.025f);
		float rz= sin(counter*0.045f);
		float tx= sin(counter*0.020f)+rx;
		float ty= sin(counter*0.023f)+ry;
		float tz= sin(counter*0.027f)+rz;

		unmap = unmapf(state, 0, ptrWorld->rule()->numStates()-1);
		
		w = x*fragSizeX + (fragSizeX * unmap);
		h = y*fragSizeY + (fragSizeY * unmap);
		d = z*fragSizeX + (fragSizeX * unmap);
		
		w -= hx;
		h -= hx;
		d -= hx;

		red = patternLib[8].color.r * abs(patternLib[8].colormap - unmap);
		green = patternLib[8].color.g * abs(patternLib[8].colormap - unmap);
		blue = patternLib[8].color.b * abs(patternLib[8].colormap - unmap);
		alpha = patternLib[8].alpha * abs(patternLib[8].alphamap - unmap);	
		
		t = ((float)x + 50.0f) / (ptrWorld->sizeX() + 50.0);
		c= sin(t*PI*2)*0.5f+0.5f;
		xL = (sin(t*PI*2*rx*tx)*unmap*t*0.5f)*w;
		yB = (cos(t*PI*2*ry*ty)*unmap*t*0.5f)*h;
		zF = (sin(t*PI*2*rz*tz)*unmap*t*0.5f)*d;
		
		xW = (cos(t*PI*2*rx*tx)*(1-unmap)*t*0.5f)*w;
		yH = (sin(t*PI*2*rx*tx)*(1-unmap)*t*0.5f)*h;
		zD = (cos(t*PI*2*rz*tz)*(1-unmap)*t*0.5f)*d;
		
		glLineWidth(unmap * 2.0f);
		gl::enable(GL_LINE_STIPPLE);
		glLineStipple(3, (GLushort)state);
		gl::color( red, green, blue, alpha );
		gl::drawLine( Vec3f(xL, yB, zF), Vec3f(xW, yH, zD) );
		gl::disable(GL_LINE_STIPPLE);
		glLineWidth(1.0f);
	}
}

void GraphicsRenderer::pattern09(int x, int y, int z) {
	
	if (state > 0.0) {
	
		float unmap, cstate;
		
		unmap = 1.0-unmapf(state, 0, ptrWorld->rule()->numStates()-1);
		cstate = currentCell->states[ptrWorld->index()];
		
		xL = (float)x * fragSizeX + (fragSizeX * 0.5) - (fragSizeX * unmap);
		yB = (float)y * fragSizeX + (fragSizeY * 0.5) - (fragSizeY * unmap);
		zF = (float)z * fragSizeZ + (fragSizeZ * 0.5) - (fragSizeZ * unmap);
		
		xW = fragSizeX * unmap * 2.0;
		yH = fragSizeX * unmap * 2.0;
		zD = fragSizeZ * unmap * 2.0;
		
		xL -= hx;
		yB -= hx;
		zF -= hx;
		
		red = patternLib[9].color.r * abs(patternLib[9].colormap - unmap);
		green = patternLib[9].color.g * abs(patternLib[9].colormap - unmap);
		blue = patternLib[9].color.b * abs(patternLib[9].colormap - unmap);
		alpha = patternLib[9].alpha * abs(patternLib[9].alphamap - unmap);
		
		if (x == 0) { 
			if (cstate > 0.0 && cstate < 2.0) 
				fillRect(1);
			else
				strokeRect(1, 1.0);
		}
		
		if (y == 0) {
			if (cstate > 0.0 && cstate < 2.0)
				fillRect(2);
			else
				strokeRect(2, 1.0);
		}
		
		if (z == 0) {
			if (cstate > 0.0 && cstate < 2.0)
				fillRect(0);
			else
				strokeRect(0, 1.0);
		}
		
		if (x == ptrWorld->sizeX()-1 && y < ptrWorld->sizeY()-1 && z < ptrWorld->sizeZ()-1) {
			xL += (xW * unmap);
			if (cstate > 0.0 && cstate < 2.0) 
				fillRect(1);
			else
				strokeRect(1, 1.0);

		}
		if (y == ptrWorld->sizeY()-1 && z < ptrWorld->sizeZ()-1 && x < ptrWorld->sizeX()-1) {
			yB += (yH * unmap);
			if (cstate > 0.0 && cstate < 2.0)
				fillRect(2);
			else
				strokeRect(2, 1.0);
		}	
		if (z == ptrWorld->sizeZ()-1 && x < ptrWorld->sizeX()-1 && y < ptrWorld->sizeY()-1) {
			zF += (zD * unmap);
			if (cstate > 0.0 && cstate < 2.0)
				fillRect(0);
			else
				strokeRect(0, 1.0);	
		}

	}
}

void GraphicsRenderer::pattern10(int x, int y, int z) {
	
	if (state > 0.0 && z % 3 == 0 ) {
		
		float unmap, thetaA, phiA, rhoA, thetaB, phiB, rhoB, otherstate;
		Cell* othercell;
		
		othercell = ptrWorld->rule()->getNeighbor(currentCell, 3);
		otherstate = othercell->phase;
		
		unmap = unmapf(state, 0, ptrWorld->rule()->numStates()-1);
		
		thetaA = ((2 * PI)/ptrWorld->sizeX() * x) + (2 * PI / maxphase * (wrapi(counter, 0, maxphase) / maxphase));
		phiA = ((2 * PI)/ptrWorld->sizeY() * y) + (2 * PI / maxphase * (wrapi(counter, 0, maxphase) / maxphase));
		rhoA = z * (fragSizeX * 0.5) + (fragSizeX * unmap);

		thetaB = ((2 * PI)/ptrWorld->sizeX() * othercell->x) + (2 * PI / maxphase * (wrapi(counter, 0, maxphase) / maxphase));
		phiB = ((2 * PI)/ptrWorld->sizeY() * othercell->y) + (2 * PI / maxphase * (wrapi(counter, 0, maxphase) / maxphase));
		rhoB = z * (fragSizeX * 0.5) + (fragSizeX * otherstate);
		
		xL = rhoA * cos( thetaA ) * cos( phiA );
		yB = rhoA * sin( thetaA ) * cos( phiA );
		zF = rhoA * sin( phiA );
		
		xW = rhoB * cos( thetaB ) * cos( phiB );
		yH = rhoB * sin( thetaB ) * cos( phiB );
		zD = rhoB * sin( phiB );
		
		red = patternLib[10].color.r * abs(patternLib[10].colormap - unmap);
		green = patternLib[10].color.g * abs(patternLib[10].colormap - unmap);
		blue = patternLib[10].color.b * abs(patternLib[10].colormap - unmap);
		alpha = patternLib[10].alpha * abs(patternLib[10].alphamap - unmap);
		
		gl::color(red, green, blue, alpha);
		drawPoint(xL, yB, zF, 4.0);
		drawPoint(xW, yH, zD, 4.0);
		
		drawLine(xL, yB, zF, xW, yH, zD, 1.0f);
		
	}
	
}


void GraphicsRenderer::pattern11(int x, int y, int z) {
	
	if (state > 0.0 && (z == 0 || z == ptrWorld->sizeZ() / 2 + 3 || z == ptrWorld->sizeZ() / 2 || z == ptrWorld->sizeZ() / 2 - 3 || z == ptrWorld->sizeZ()-1))
	{
		float mapState, maxState;
		hx = fragSizeX * ptrWorld->sizeX() * 0.5;

		maxState = ptrWorld->rule()->numStates() - 1;
		mapState = (maxState - currentCell->states[ptrWorld->index()]) * (1 / maxState);
				
		red = patternLib[11].color.r * abs(patternLib[11].colormap - mapState);
		green = patternLib[11].color.g * abs(patternLib[11].colormap - mapState);
		blue = patternLib[11].color.b * abs(patternLib[11].colormap - mapState);
		alpha = patternLib[11].alpha * abs(patternLib[11].alphamap - mapState);	
					
		xL = (float)x * fragSizeX;
		yB = (float)y * (fragSizeX * 0.5) + (fragSizeX * 0.25);
		zF = (float)z * fragSizeX + (fragSizeX * 0.5);

		xL -= hx;
		yB -= (hx * 0.5);
		zF -= hx;
	
		yH = zD = fragSizeX * 0.25;
		xW = fragSizeX * 4.0 + (mapState * fragSizeX);
		
		gl::color(red, green, blue, alpha);
		gl::drawCube(Vec3f(xL , yB, zF), Vec3f( xW, yH, zD ));			
	
	}	
	
}

void GraphicsRenderer::pattern12(int x, int y, int z) {
		
	if (currentCell->states[ptrWorld->index()] > 0 && currentCell->states[ptrWorld->index()] <= 4 )
	{
		float mapState, maxState;
		
		maxState = 4; //ptrWorld->rule()->numStates() - 1;
		mapState = (maxState - currentCell->states[ptrWorld->index()]) * (1 / maxState);
		
//		xL = (float)x * fragSizeX + fragSizeX - (fragSizeX * mapState);
//		yB = (float)y * fragSizeX + fragSizeX - (fragSizeX * mapState);
//		zF = (float)z * fragSizeX + fragSizeX - (fragSizeX * mapState);

		xL = (float)x * fragSizeX + fragSizeX - (fragSizeX * 0.5);
		yB = (float)y * fragSizeX + fragSizeX - (fragSizeX * 0.5);
		zF = (float)z * fragSizeX + fragSizeX - (fragSizeX * 0.5);
		
		xW = yH = zD = fragSizeX * mapState;

		xL -= hx;
		yB -= hx;
		zF -= hx;
		
		red = patternLib[12].color.r * abs(patternLib[12].colormap - mapState);
		green = patternLib[12].color.g * abs(patternLib[12].colormap - mapState);
		blue = patternLib[12].color.b * abs(patternLib[12].colormap - mapState);
		alpha = patternLib[12].alpha * abs(patternLib[12].alphamap - mapState);
		
		gl::color(red, green, blue, alpha);
		
		gl::drawSphere( Vec3f(xL, yB, zF), xW*0.5, 16 );
		
		gl::color(clipf(red + 0.2, 0.0, 1.0), clipf(green + 0.2, 0.0, 1.0), clipf(blue + 0.2, 0.0, 1.0), alpha);

		gl::drawCube( Vec3f(xL, yB, zF), Vec3f(xW, yH, zD) );
		
		gl::color(red, green, blue, 1.0);
		
		gl::drawStrokedCube( Vec3f(xL, yB, zF), Vec3f(xW, yH, zD) );
		
//			if (currentCell->states[ptrWorld->index()] == 1)
//			{
//				gl::drawSphere( Vec3f(xL, yB, zF), xW, 12 );
////				gl::drawCube( Vec3f(xL, yB, zF), Vec3f(xW, yH, zD) );
////				fillCube();
//			}
//			{
//				gl::drawStrokedCube( Vec3f(xL, yB, zF), Vec3f(xW, yH, zD) );
////				strokeCube();
//			}
		
	}	
	
}

void GraphicsRenderer::pattern13(int x, int y, int z) {
	
	if (
		(x > 0 && y > 0 && z > 0 &&  x < (ptrWorld->sizeX() - 1) && y < (ptrWorld->sizeY() - 1) && z < (ptrWorld->sizeZ() - 1))
	)
	{
		if (state > 0.0 && (x % 4 == 0 || y % 4 == 0 || z % 4 == 0)) {
			
			int i, map;
			float ex, ey, ez, mapState, maxState;
			Cell *neighbor;

			maxState = ptrWorld->rule()->numStates() - 1;
			mapState = (maxState - state) * (1 / maxState);
            
			xL = (float)x * fragSizeX + (fragSizeX * 0.5 + (fragSizeX * sin((1.0-mapState) * 2 * PI)));
			yB = (float)y * fragSizeX + (fragSizeX * 0.5 + (fragSizeX * cos((1.0-mapState) * 2 * PI)));
			zF = (float)z * fragSizeX + (fragSizeX * 0.5 + (fragSizeX * sin((1.0-mapState) * 2 * PI)));
			
			xL -= hx;
			yB -= hx;
			zF -= hx;
			
            red = patternLib[13].color.r * abs(patternLib[13].colormap - mapState);
            green = patternLib[13].color.g * abs(patternLib[13].colormap - mapState);
            blue = patternLib[13].color.b * abs(patternLib[13].colormap - mapState);
            alpha = patternLib[13].alpha * abs(patternLib[13].alphamap - mapState);
            map = 4;
            mMaps[map].bindMulti(4);
            boidShader.bind();
            boidShader.uniform( "LightPos", Vec3f( getWindowWidth()/2 + 350.0f, getWindowHeight()/2 - 150.0f, 150.0f ) );
            boidShader.uniform( "EnvMap", 4 );
            
            boidShader.uniform( "BaseColor", Vec4f( 0.3f, 0.3f, 0.3f, 0.7f ) );
            boidShader.uniform( "MixRatio", 0.5f );
            glPushMatrix();
            gl::color(red, green, blue, alpha);
			if (state == 1.0)
				gl::drawSphere(Vec3f(xL, yB, zF), fragSizeX*0.25, 12);
			else
				gl::drawSphere(Vec3f(xL, yB, zF), mapState*fragSizeX*0.25, 12);
            glPopMatrix();
            boidShader.unbind();
            mMaps[map].unbind();
            
			for (i = 0; i < 26; i++) {
				neighbor = ptrWorld->rule()->getNeighbor(currentCell, i);
				if (neighbor->phase > 0.0 && neighbor->phase < 10.0)
				{
					ex = neighbor->x * fragSizeX + (fragSizeX * 0.5 + (fragSizeX * sin((1.0-mapState) * 2 * PI)));
					ey = neighbor->y * fragSizeX + (fragSizeX * 0.5 + (fragSizeX * sin((1.0-mapState) * 2 * PI)));
					ez = neighbor->z * fragSizeX + (fragSizeX * 0.5 + (fragSizeX * sin((1.0-mapState) * 2 * PI)));
					
					ex -= hx;
					ey -= hx;
					ez -= hx;
					
					red = patternLib[13].color.r * abs(patternLib[13].colormap - mapState) * (1.0 - linlin(neighbor->phase, 1, 12, 0.0, 0.7));
					green = patternLib[13].color.g * abs(patternLib[13].colormap - mapState) * (1.0 - linlin(neighbor->phase, 1, 12, 0.0, 0.7));
					blue = patternLib[13].color.b * abs(patternLib[13].colormap - mapState) * (1.0 - linlin(neighbor->phase, 1, 12, 0.0, 0.7));
					alpha = patternLib[13].alpha * abs(patternLib[13].alphamap - mapState);
					
					gl::color(red, green, blue, alpha);				
					gl::drawLine( Vec3f(xL, yB, zF), Vec3f(ex, ey, ez) );
				}
			}
		}
	}
	
}

void GraphicsRenderer::pattern14(int x, int y, int z) {
    float maxState = 13;
    if (state < maxState && state > 0.0) {
        float mapState;
        
        mapState = (maxState - currentCell->states[ptrWorld->index()]) * (1 / maxState);
        
        xL = (float)x * fragSizeX + (fragSizeX * 0.5);
        yB = (float)y * fragSizeX + (fragSizeX * 0.5);
        zF = (float)z * fragSizeX + (fragSizeX * 0.5);
        
        xW = yH = zD = mapf(fragSizeX, 1.0, 4.0);
        
        xL -= hx;
        yB -= hx;
        zF -= hx;
        
        red = patternLib[14].color.r * abs(patternLib[14].colormap - mapState);
        green = patternLib[14].color.g * abs(patternLib[14].colormap - mapState);
        blue = patternLib[14].color.b * abs(patternLib[14].colormap - mapState);
        alpha = patternLib[14].alpha * abs(patternLib[14].alphamap - mapState);
        
        glDisable( GL_LIGHTING );
        glEnable( GL_TEXTURE_2D );
        img[1].bind();
        gl::pushMatrices();
        
        gl::color(red, green, blue, alpha);
        gl::drawCube( Vec3f(xL, yB, zF), Vec3f(xW, yH, zD) );
        
        gl::popMatrices();
        img[1].unbind();
        glDisable( GL_TEXTURE_2D );
			
	}
	
}

void GraphicsRenderer::pattern15(int x, int y, int z) {

	if ((x % 4 == 0 || y % 4 == 0 || z % 4 == 0) && state > 0.0)
	{
		float cstate;
		
		if (ptrWorld->ruleType() == CONT) {
			cstate = state;
		}
		else {
			if (state != 0)
			{
				cstate = 1.0 / state;
			}
			else {
				cstate = 0.0f;
			}
		}
						
		xL = (float)x * fragSizeX + (fragSizeX * 0.5);
		yB = (float)y * fragSizeX + (fragSizeX * 0.5);
		zF = (float)z * fragSizeX + (fragSizeX * 0.5);
		
		xL -= hx;
		yB -= hx;
		zF -= hx;
		
		cstate = mapf(cstate, 0.5, 2.0);
				
		red = patternLib[15].color.r * abs(patternLib[15].colormap - cstate);
		green = patternLib[15].color.g * abs(patternLib[15].colormap - cstate);
		blue = patternLib[15].color.b * abs(patternLib[15].colormap - cstate);
		alpha = patternLib[15].alpha * abs(patternLib[15].alphamap - cstate);
				
		xW = yH = zD = fragSizeX * cstate;

		glDisable( GL_LIGHTING );
		glEnable( GL_TEXTURE_2D );
		img00.bind();
		gl::pushMatrices();
		
		gl::color(red, green, blue, alpha);
		gl::drawCube( Vec3f(xL, yB, zF), Vec3f(xW, yH, zD) );	

		gl::popMatrices();
		img00.unbind();
		glDisable( GL_TEXTURE_2D );
	
	}
		
}

/**
 SKISM -----------------------------------o----------------------------o------------------------o--------------------
**/

void GraphicsRenderer::pattern16(int x, int y, int z) {
	float cstate;
	
	if (ptrWorld->ruleType() == CONT) {
		cstate = state;
	}
	else {
		if (state != 0)
		{
			cstate = 1.0 / state;
		}
		else {
			cstate = 0.0f;
		}
	}
	
	if (ptrWorld->ruleType() == CONT || cstate != 0.0f) {
		
        float mapState, maxState;
        
        maxState = 4; //ptrWorld->rule()->numStates() - 1;
        mapState = (maxState - currentCell->states[ptrWorld->index()]) * (1 / maxState);
        
        //		xL = (float)x * fragSizeX + fragSizeX - (fragSizeX * mapState);
        //		yB = (float)y * fragSizeX + fragSizeX - (fragSizeX * mapState);
        //		zF = (float)z * fragSizeX + fragSizeX - (fragSizeX * mapState);
        
        xL = (float)x * fragSizeX + fragSizeX - (fragSizeX * 0.5);
        yB = (float)y * fragSizeX + fragSizeX - (fragSizeX * 0.5);
        zF = (float)z * fragSizeX + fragSizeX - (fragSizeX * 0.5);
        
        xW = yH = zD = fragSizeX * mapState;
        
        xL -= hx;
        yB -= hx;
        zF -= hx;
        
        red = patternLib[16].color.r * abs(patternLib[16].colormap - mapState);
        green = patternLib[16].color.g * abs(patternLib[16].colormap - mapState);
        blue = patternLib[16].color.b * abs(patternLib[16].colormap - mapState);
        alpha = patternLib[16].alpha * abs(patternLib[16].alphamap - mapState);
        
        mMaps[0].bindMulti(4);
        boidShader.bind();        
        boidShader.uniform( "LightPos", Vec3f( getWindowWidth()/2 + 350.0f, getWindowHeight()/2 - 150.0f, 150.0f ) );
        boidShader.uniform( "EnvMap", 4 );
        
        boidShader.uniform( "BaseColor", Vec4f( 0.3f, 0.3f, 0.3f, 0.7f ) );
        boidShader.uniform( "MixRatio", 0.5f );
        glPushMatrix();
        gl::color(red, green, blue, alpha);
        gl::drawSphere( Vec3f(xL, yB, zF), xW*0.25, 16 );
        glPopMatrix();
        boidShader.unbind();
        mMaps[0].unbind();

	}	
}

void GraphicsRenderer::pattern17(int x, int y, int z) {

	float cstate;
	
	if (ptrWorld->ruleType() == CONT) {
		cstate = state;
	}
	else {
		if (state != 0)
		{
			cstate = 1.0 / state;
		}
		else {
			cstate = 0.0f;
		}
	}
	
	if (ptrWorld->ruleType() == CONT || cstate != 0.0f) {
		
		if (z%2==0 || x%2==0 || y%2==0) {
		
			xL = (ptrWorld->sizeX() * fragSizeX * 0.5f) + (((ptrWorld->sizeX() * fragSizeX * 0.5f) - (x * fragSizeX)) * 0.4f);
			yB = y * fragSizeY + fragSizeY - (fragSizeY * 10.0 * cstate);
			zF = z * fragSizeX + (fragSizeX * 0.5);
			
			xL -= hx;
			yB -= hy;
			zF -= hx;

			zD = zF;
			
			xW = fragSizeX * cstate * 0.2;
			yH = fragSizeY * cstate * 20.0;
			
			red = patternLib[17].color.r * abs(patternLib[17].colormap - cstate);
			green = patternLib[17].color.g * abs(patternLib[17].colormap - cstate);
			blue = patternLib[17].color.b * abs(patternLib[17].colormap - cstate);
			alpha = patternLib[17].alpha * abs(patternLib[17].alphamap - cstate);
			
			gl::color(red, green, blue, alpha);
            gl::drawCube( Vec3f(xL, yB, zF), Vec3f(xW, yH, xW) );
//			strokeRect(0, 1.0);
				
		}
	}	
}

void GraphicsRenderer::pattern18(int x, int y, int z) {

    
    if (state > 0.0 && z%5==0) {
        
        float unmap, cstate, theta, rho, phi, otunmap;
        float scale = 0.05;
        
        unmap = 1.0-unmapf(state, 0, ptrWorld->rule()->numStates()-1);
        cstate = currentCell->states[ptrWorld->index()];
        
        xW = yH = zD = fragSizeX * unmap;

        red = patternLib[18].color.r * abs(patternLib[18].colormap - unmap);
        green = patternLib[18].color.g * abs(patternLib[18].colormap - unmap);
        blue = patternLib[18].color.b * abs(patternLib[18].colormap - unmap);
        alpha = patternLib[18].alpha * abs(patternLib[18].alphamap - unmap);
        
        theta = ((2 * PI)/ptrWorld->sizeX() * x);
        phi = ((2 * PI)/ptrWorld->sizeY() * y);
        rho = z * (fragSizeX * 0.5);
        
        xL = rho * cos( theta ) * cos( phi );
        yB = rho * sin( theta ) * cos( phi );
        zF = rho * sin( phi );

        gl::color(red, green, blue, alpha);
        glEnable(GL_LINE_SMOOTH);
        glBegin(GL_LINES);
        
        gl::vertex( Vec3f(xL, yB, zF) );
        
        theta = ((2 * PI)/ptrWorld->sizeX() * (x - 1));
        phi = ((2 * PI)/ptrWorld->sizeY() * y);
        
        xL = rho * cos( theta ) * cos( phi );
        yB = rho * sin( theta ) * cos( phi );
        zF = rho * sin( phi );
        
        otunmap = sin(unmap * PI);
        red = patternLib[18].color.r * abs(patternLib[18].colormap - otunmap);
        green = patternLib[18].color.g * abs(patternLib[18].colormap - otunmap);
        blue = patternLib[18].color.b * abs(patternLib[18].colormap - otunmap);
        alpha = patternLib[18].alpha * abs(patternLib[18].alphamap - otunmap);
        gl::color(red, green, blue, alpha);
        
        gl::vertex( Vec3f(xL, yB, zF) );
        
        theta = ((2 * PI)/ptrWorld->sizeX() * (x - 1));
        phi = ((2 * PI)/ptrWorld->sizeY() * (y - 1));
        
        xL = rho * cos( theta ) * cos( phi );
        yB = rho * sin( theta ) * cos( phi );
        zF = rho * sin( phi );
        
        otunmap = cos(unmap * PI);
        red = patternLib[18].color.r * abs(patternLib[18].colormap - otunmap);
        green = patternLib[18].color.g * abs(patternLib[18].colormap - otunmap);
        blue = patternLib[18].color.b * abs(patternLib[18].colormap - otunmap);
        alpha = patternLib[18].alpha * abs(patternLib[18].alphamap - otunmap);
        gl::color(red, green, blue, alpha);
        
        gl::vertex( Vec3f(xL, yB, zF) );
        
        theta = ((2 * PI)/ptrWorld->sizeX() * x);
        phi = ((2 * PI)/ptrWorld->sizeY() * (y - 1));
        
        xL = rho * cos( theta ) * cos( phi );
        yB = rho * sin( theta ) * cos( phi );
        zF = rho * sin( phi );
        
        otunmap = sin(unmap * PI);
        red = patternLib[18].color.r * abs(patternLib[18].colormap - otunmap);
        green = patternLib[18].color.g * abs(patternLib[18].colormap - otunmap);
        blue = patternLib[18].color.b * abs(patternLib[18].colormap - otunmap);
        alpha = patternLib[18].alpha * abs(patternLib[18].alphamap - otunmap);
        gl::color(red, green, blue, alpha);
        
        gl::vertex( Vec3f(xL, yB, zF) );
        
        glEnd();
        glDisable(GL_LINE_SMOOTH);

        red = patternLib[18].color.r * abs(patternLib[18].colormap - unmap);
        green = patternLib[18].color.g * abs(patternLib[18].colormap - unmap);
        blue = patternLib[18].color.b * abs(patternLib[18].colormap - unmap);
        alpha = patternLib[18].alpha * abs(patternLib[18].alphamap - unmap);
        
        theta = ((2 * PI)/ptrWorld->sizeX() * x);
        phi = ((2 * PI)/ptrWorld->sizeY() * y);
        rho = z * (fragSizeX * 0.5);
        
        xL = rho * cos( theta ) * cos( phi );
        yB = rho * sin( theta ) * cos( phi );
        zF = rho * sin( phi );
        
        gl::color(red, green, blue, alpha);

        gl::drawSphere( Vec3f(xL, yB, zF), xW*scale, 8 );

//        gl::drawCube( Vec3f(xL, yB, zF), Vec3f(xW*scale, yH*scale, zD*scale) );
        
        theta = ((2 * PI)/ptrWorld->sizeX() * (x - 1));
        phi = ((2 * PI)/ptrWorld->sizeY() * y);
        
        xL = rho * cos( theta ) * cos( phi );
        yB = rho * sin( theta ) * cos( phi );
        zF = rho * sin( phi );
        
        otunmap = sin(unmap * PI);
        red = patternLib[18].color.r * abs(patternLib[18].colormap - otunmap);
        green = patternLib[18].color.g * abs(patternLib[18].colormap - otunmap);
        blue = patternLib[18].color.b * abs(patternLib[18].colormap - otunmap);
        alpha = patternLib[18].alpha * abs(patternLib[18].alphamap - otunmap);
        gl::color(red, green, blue, alpha);

        gl::drawSphere( Vec3f(xL, yB, zF), xW*scale, 8 );

//        gl::drawCube( Vec3f(xL, yB, zF), Vec3f(xW*scale, yH*scale, zD*scale) );
        
        theta = ((2 * PI)/ptrWorld->sizeX() * (x - 1));
        phi = ((2 * PI)/ptrWorld->sizeY() * (y - 1));
        
        xL = rho * cos( theta ) * cos( phi );
        yB = rho * sin( theta ) * cos( phi );
        zF = rho * sin( phi );
        
        otunmap = cos(unmap * PI);
        red = patternLib[18].color.r * abs(patternLib[18].colormap - otunmap);
        green = patternLib[18].color.g * abs(patternLib[18].colormap - otunmap);
        blue = patternLib[18].color.b * abs(patternLib[18].colormap - otunmap);
        alpha = patternLib[18].alpha * abs(patternLib[18].alphamap - otunmap);
        gl::color(red, green, blue, alpha);

        gl::drawSphere( Vec3f(xL, yB, zF), xW*scale, 8 );

//        gl::drawCube( Vec3f(xL, yB, zF), Vec3f(xW*scale, yH*scale, zD*scale) );
        
        theta = ((2 * PI)/ptrWorld->sizeX() * x);
        phi = ((2 * PI)/ptrWorld->sizeY() * (y - 1));
        
        xL = rho * cos( theta ) * cos( phi );
        yB = rho * sin( theta ) * cos( phi );
        zF = rho * sin( phi );
        
        otunmap = sin(unmap * PI);
        red = patternLib[18].color.r * abs(patternLib[18].colormap - otunmap);
        green = patternLib[18].color.g * abs(patternLib[18].colormap - otunmap);
        blue = patternLib[18].color.b * abs(patternLib[18].colormap - otunmap);
        alpha = patternLib[18].alpha * abs(patternLib[18].alphamap - otunmap);
        gl::color(red, green, blue, alpha);

        gl::drawSphere( Vec3f(xL, yB, zF), xW*scale, 8 );

//        gl::drawCube( Vec3f(xL, yB, zF), Vec3f(xW*scale, yH*scale, zD*scale) );
    }
}

void GraphicsRenderer::pattern19(int x, int y, int z) {
	
    if (
        (x > 0 && y > 0 && z > 0 &&  x < (ptrWorld->sizeX() - 1) && y < (ptrWorld->sizeY() - 1) && z < (ptrWorld->sizeZ() - 1))
        )
    {
        if (state > 0.0 && (x % 4 == 0 || y % 4 == 0 || z % 4 == 0)) {
            
            int i, map;
            float ex, ey, ez, mapState, maxState;
            Cell *neighbor;
            
            maxState = ptrWorld->rule()->numStates() - 1;
            mapState = (maxState - state) * (1 / maxState);
            
            xL = (float)x * fragSizeX + (fragSizeX * 0.5 + (fragSizeX * sin((1.0-mapState) * 2 * PI)));
            yB = (float)y * fragSizeX + (fragSizeX * 0.5 + (fragSizeX * cos((1.0-mapState) * 2 * PI)));
            zF = (float)z * fragSizeX + (fragSizeX * 0.5 + (fragSizeX * sin((1.0-mapState) * 2 * PI)));
            
            xL -= hx;
            yB -= hx;
            zF -= hx;
            
            red = patternLib[19].color.r * abs(patternLib[19].colormap - mapState);
            green = patternLib[19].color.g * abs(patternLib[19].colormap - mapState);
            blue = patternLib[19].color.b * abs(patternLib[19].colormap - mapState);
            alpha = patternLib[19].alpha * abs(patternLib[19].alphamap - mapState);

            glDisable( GL_LIGHTING );
            glEnable( GL_TEXTURE_2D );
            img01.bind();
            gl::pushMatrices();
            
            gl::color(red, green, blue, alpha);
            if (state == 1.0)
                gl::drawCube(Vec3f(xL, yB, zF), Vec3f(fragSizeX*1.5, fragSizeX*1.5, fragSizeX*1.5));
            else
                gl::drawCube(Vec3f(xL, yB, zF), Vec3f(mapState*fragSizeX*1.5, mapState*fragSizeX*1.5, mapState*fragSizeX*1.5));
                             
             gl::popMatrices();
             img01.unbind();
             glDisable( GL_TEXTURE_2D );
                             
//            for (i = 0; i < 26; i++) {
//                neighbor = ptrWorld->rule()->getNeighbor(currentCell, i);
//                if (neighbor->phase > 0.0 && neighbor->phase < 10.0)
//                {
//                    ex = neighbor->x * fragSizeX + (fragSizeX * 0.5 + (fragSizeX * sin((1.0-mapState) * 2 * PI)));
//                    ey = neighbor->y * fragSizeX + (fragSizeX * 0.5 + (fragSizeX * sin((1.0-mapState) * 2 * PI)));
//                    ez = neighbor->z * fragSizeX + (fragSizeX * 0.5 + (fragSizeX * sin((1.0-mapState) * 2 * PI)));
//                    
//                    ex -= hx;
//                    ey -= hx;
//                    ez -= hx;
//                    
//                    red = patternLib[13].color.r * abs(patternLib[13].colormap - mapState) * (1.0 - linlin(neighbor->phase, 1, 12, 0.0, 0.7));
//                    green = patternLib[13].color.g * abs(patternLib[13].colormap - mapState) * (1.0 - linlin(neighbor->phase, 1, 12, 0.0, 0.7));
//                    blue = patternLib[13].color.b * abs(patternLib[13].colormap - mapState) * (1.0 - linlin(neighbor->phase, 1, 12, 0.0, 0.7));
//                    alpha = patternLib[13].alpha * abs(patternLib[13].alphamap - mapState);
//                    
//                    gl::color(red, green, blue, alpha);				
//                    gl::drawLine( Vec3f(xL, yB, zF), Vec3f(ex, ey, ez) );
//                }
//            }
        }
    }
}

void GraphicsRenderer::pattern20(int x, int y, int z) {
    float cstate;
    
    if (ptrWorld->ruleType() == CONT) {
        cstate = state;
    }
    else {
        if (state != 0)
        {
            cstate = 1.0 / state;
        }
        else {
            cstate = 0.0f;
        }
    }
    
    if (ptrWorld->ruleType() == CONT || cstate != 0.0f) {
        
        float mapState, maxState;
        
        maxState = 4;
        mapState = (maxState - currentCell->states[ptrWorld->index()]) * (1 / maxState);
        
        xL = (float)x * fragSizeX + fragSizeX - (fragSizeX * 0.5);
        yB = (float)y * fragSizeX + fragSizeX - (fragSizeX * 0.5);
        zF = (float)z * fragSizeX + fragSizeX - (fragSizeX * 0.5);
        
        xW = yH = zD = mapf(fragSizeX * mapState, 0.25f, 0.5f);
        
        xL -= hx;
        yB -= hx;
        zF -= hx;
        
        red = patternLib[20].color.r * abs(patternLib[20].colormap - mapState);
        green = patternLib[20].color.g * abs(patternLib[20].colormap - mapState);
        blue = patternLib[20].color.b * abs(patternLib[20].colormap - mapState);
        alpha = patternLib[20].alpha * abs(patternLib[20].alphamap - mapState);
        
        mMaps[4].bindMulti(4);
        boidShader.bind();
        boidShader.uniform( "LightPos", Vec3f( getWindowWidth()/2 + 350.0f, getWindowHeight()/2 - 150.0f, 150.0f ) );
        boidShader.uniform( "EnvMap", 4 );
        
        boidShader.uniform( "BaseColor", Vec4f( 0.3f, 0.3f, 0.3f, 0.7f ) );
        boidShader.uniform( "MixRatio", 0.5f );
        glPushMatrix();
        gl::color(red, green, blue, alpha);
        gl::drawSphere( Vec3f(xL, yB, zF), xW, 16 );
        glPopMatrix();
        boidShader.unbind();
        mMaps[4].unbind();
        
    }	
}

void GraphicsRenderer::pattern21(int x, int y, int z) {
	Vec3f sphereLoc, dirFromLight;
	float distFromLight, distFromLightPer;
	
	float cstate;
	
	if (ptrWorld->ruleType() != CONT) 
	{
		if (state > 0) {
			cstate = (int)(1.0f/state);
		}
	}
	else
	{
		cstate = state;
	}
	
	xL = x * fragSizeX + fragSizeX - (fragSizeX * mapf(cstate, 0.1, 1.5));
	xW = fragSizeX * mapf(cstate, 0.1, 1.5);
	
	yB = y * fragSizeY + fragSizeY - (fragSizeY * mapf(cstate, 0.1, 1.5));
	yH = fragSizeY * mapf(cstate, 0.1, 1.5);
	
	zF = z * fragSizeX + fragSizeX - (fragSizeX * mapf(cstate, 0.1, 1.5));
	zD = fragSizeX * mapf(cstate, 0.1, 1.5);
		
	xL -= hx;
	yB -= hy;
	zF -= hx;
	
	red = patternLib[21].color.r * abs(patternLib[21].colormap - cstate);
	green = patternLib[21].color.g * abs(patternLib[21].colormap - cstate);
	blue = patternLib[21].color.b * abs(patternLib[21].colormap - cstate);
	alpha = patternLib[21].alpha * abs(patternLib[21].alphamap - cstate);
	
	sphereLoc = Vec3f( xL + cos(fragSizeX * (2*PI*(state))), yB + sin(fragSizeY * (2*PI*state)), zF + sin(fragSizeX * (2*PI*state))  );
	dirFromLight = sphereLoc - mLightLoc;
	distFromLight = dirFromLight.length();
	
	distFromLightPer = 1.20f - distFromLight/30.0f;
	
	if (distFromLightPer < 0.0f) distFromLightPer = 0.0f;
	distFromLightPer = pow( distFromLightPer, 10.0f );
		
	if (distFromLight < 20.0)
	{
		
		if (bLIGHT) {
			
			ci::ColorA color(CM_HSV, red, green, blue, alpha);
			
			glMaterialfv(GL_FRONT, GL_DIFFUSE, color);
			glMaterialfv(GL_FRONT, GL_AMBIENT, mat_ambient);
			glMaterialfv(GL_FRONT, GL_SPECULAR, mat_specular);
			glMaterialfv(GL_FRONT, GL_SHININESS, mat_shininess);
			glMaterialfv( GL_FRONT, GL_EMISSION, no_mat );	
		}
		else
		{
			glMaterialfv( GL_FRONT, GL_DIFFUSE,	no_mat );
			glMaterialfv( GL_FRONT, GL_AMBIENT,	no_mat );
			glMaterialfv( GL_FRONT, GL_SPECULAR, no_mat );
			glMaterialfv( GL_FRONT, GL_SHININESS, no_shininess );
			glMaterialfv( GL_FRONT, GL_EMISSION, no_mat );	
		}
		
		if ( bSHADER ) {
			smShader.bind();
			smShader.uniform( "NumEnabledLights", 1 );
		}
		
		gl::drawCube( Vec3f(xL, yB, zF), Vec3f(xW, yH, zD) );
				
		if ( smShader) smShader.unbind();
	}
}

void GraphicsRenderer::pattern22(int x, int y, int z) {

	float cstate, ostate;
	
	if (ptrWorld->ruleType() == CONT) {
		cstate = state;
	}
	else {
		if (state != 0)
		{
			cstate = 1.0 / state;
		}
		else {
			cstate = 0.0f;
		}
	}
	
	if (ptrWorld->ruleType() == CONT || cstate != 0.0f) {
				
        int i, pts;
        
        pts = 7;
        
        for (i = 1; i <= pts; i++) {
            
            ostate = currentCell->states[i];
            
            if (ptrWorld->ruleType() != CONT && ostate != 0.0)
            {
                ostate = 1.0/ostate;
            }
            
            xL = x * fragSizeX + randfloat(0.0, fragSizeX);
            yB = y * fragSizeY + randfloat(0.0, fragSizeY);
            zF = z * fragSizeZ + randfloat(0.0, fragSizeZ);
            
            xL -= hx;
            yB -= hy;
            zF -= hx;
            
            red = patternLib[22].color.r * abs(patternLib[22].colormap - cstate);
            green = patternLib[22].color.g * abs(patternLib[22].colormap - cstate);
            blue = patternLib[22].color.b * abs(patternLib[22].colormap - cstate);
            alpha = patternLib[22].alpha * abs(patternLib[22].alphamap - cstate);
            
            drawPoint(xL, yB, zF, 1.0);
        }
	}	
}

void GraphicsRenderer::pattern23(int x, int y, int z) {
	
    float cstate;
    
    if (ptrWorld->ruleType() == CONT) {
        cstate = state;
    }
    else {
        if (state != 0)
        {
            cstate = 1.0 / state;
        }
        else {
            cstate = 0.0f;
        }
    }
    
    if (cstate > 0.0f && x > 0 && y > 0 && z > 0
        && x < ptrWorld->sizeX() - 1 && y < ptrWorld->sizeY() - 1 && ptrWorld->sizeZ() - 1) {
        
        float unmap;
        int ind[12] = { 4, 1, 10, 2, 12, 0, 14, 0, 16, 2, 22, 1 };
        
        unmap = 1.0-unmapf(state, 0, ptrWorld->rule()->numStates()-1);
        cstate = currentCell->states[ptrWorld->index()];
        
        xL = (float)x * fragSizeX + (fragSizeX * 0.5) - (fragSizeX * mapf(unmap, 0.3, 0.8));
        yB = (float)y * fragSizeX + (fragSizeY * 0.5) - (fragSizeY * mapf(unmap, 0.3, 0.8));
        zF = (float)z * fragSizeZ + (fragSizeZ * 0.5) - (fragSizeZ * mapf(unmap, 0.3, 0.8));
        
        xW = fragSizeX * mapf(unmap, 0.3, 0.8);
        yH = fragSizeX * mapf(unmap, 0.3, 0.8);
        zD = fragSizeZ * mapf(unmap, 0.3, 0.8);
        
        xL -= hx;
        yB -= hx;
        zF -= hx;
        
        red = patternLib[23].color.r * abs(patternLib[23].colormap - unmap);
        green = patternLib[23].color.g * abs(patternLib[23].colormap - unmap);
        blue = patternLib[23].color.b * abs(patternLib[23].colormap - unmap);
        alpha = patternLib[23].alpha * abs(patternLib[23].alphamap - unmap);
        
        for (int i = 0; i < 12; i+=2)
        {
            if (ptrWorld->rule()->getNeighbor(currentCell, ind[i])->states[currentIndex] == 0) {
                fillRect(ind[i+1]);
            }
        }
    }
}

void GraphicsRenderer::pattern24(int x, int y, int z) {

	float cstate;
	
	if (ptrWorld->ruleType() == CONT) {
		cstate = state;
	}
	else {
		if (state != 0)
		{
			cstate = 1.0 / state;
		}
		else {
			cstate = 0.0f;
		}
	}
	
	if (ptrWorld->ruleType() == CONT || cstate != 0.0f) {
		
		if (z%5==0) {
		
			xL = x * fragSizeX + fragSizeX - (fragSizeX * 2.0 * cstate);
			yB = y * fragSizeY + (fragSizeY * 0.5);
			zF = z * fragSizeX + (fragSizeX * 0.5);
			
			xL -= hx;
			yB -= hy;
			zF -= hx;
			
			zD = zF;
			
			yB += (fragSizeY * 4.0 * sin(cstate * 2 * PI)) - (fragSizeY * 8.0 * sin(cstate * 2 * PI));
			
			xW = fragSizeX * cstate * 4.0;
			yH = yB;
			
			red = patternLib[24].color.r * abs(patternLib[24].colormap - cstate);
			green = patternLib[24].color.g * abs(patternLib[24].colormap - cstate);
			blue = patternLib[24].color.b * abs(patternLib[24].colormap - cstate);
			alpha = patternLib[24].alpha * abs(patternLib[24].alphamap - cstate);
			
			gl::color(red, green, blue, alpha);
			gl::drawLine( Vec3f(xL, yB, zF), Vec3f(xL+xW, yH, zD) );
		
		}
	}	
}

void GraphicsRenderer::pattern25(int x, int y, int z) {

	float cstate;
	
	if (ptrWorld->ruleType() == CONT) {
		cstate = state;
	}
	else {
		if (state != 0)
		{
			cstate = 1.0 / state;
		}
		else {
			cstate = 0.0f;
		}
	}
	
	if (ptrWorld->ruleType() == CONT || cstate != 0.0f) {
		
		if (z%5==0) {
		
			red = patternLib[25].color.r * abs(patternLib[25].colormap - cstate);
			green = patternLib[25].color.g * abs(patternLib[25].colormap - cstate);
			blue = patternLib[25].color.b * abs(patternLib[25].colormap - cstate);
			alpha = patternLib[25].alpha * abs(patternLib[25].alphamap - cstate);
			
			xL = x * fragSizeX + (fragSizeX * 0.25);
			yB = y * fragSizeY + (fragSizeY * 0.25);
			zF = z * fragSizeX + (fragSizeX * 0.5);
			
			xW = fragSizeX * cstate * 2.0;
					
			xL -= hx;
			yB -= hy;
			zF -= hx;
			
			gl::color(red, green, blue, alpha);
			
			gl::drawLine( Vec3f(xL, yB, zF), Vec3f(xL + xW, yB, zF) );
			
			xL = x * fragSizeX + (fragSizeX * 0.75);
			yB = y * fragSizeY + (fragSizeY * 0.75);
			
			xW = fragSizeX * cstate * -2.0;
			
			xL -= hx;
			yB -= hy;	
			
			gl::drawLine( Vec3f(xL, yB, zF), Vec3f(xL + xW, yB, zF) );
			
			red = 1.0 - (patternLib[25].color.r * abs(patternLib[25].colormap - cstate));
			green = 1.0 - (patternLib[25].color.g * abs(patternLib[25].colormap - cstate));
			blue = 1.0 - (patternLib[25].color.b * abs(patternLib[25].colormap - cstate));
			alpha = 1.0 - (patternLib[25].alpha * abs(patternLib[25].alphamap - cstate));
			
			xL = x * fragSizeX + (fragSizeX * 0.75);
			yB = y * fragSizeY + (fragSizeY * 0.25);
			
			yH = fragSizeX * cstate * 2.0;
			
			xL -= hx;
			yB -= hy;
			
			gl::color(red, green, blue, alpha);
			
			gl::drawLine( Vec3f(xL, yB, zF), Vec3f(xL, yB + yH, zF) );
			
			xL = x * fragSizeX + (fragSizeX * 0.25);
			yB = y * fragSizeY + (fragSizeY * 0.75);
			
			yH = fragSizeX * cstate * -2.0;
			
			xL -= hx;
			yB -= hy;	
			
			gl::drawLine( Vec3f(xL, yB, zF), Vec3f(xL, yB + yH, zF) );
			
		}
	}
}

void GraphicsRenderer::pattern26(int x, int y, int z) {
	
	if (state > 0.0 && z > 0 && z % 4 == 0 ) {
		
		float unmap, thetaA, phiA, rhoA, thetaB, phiB, rhoB, thetaC, phiC, rhoC, thetaD, phiD, rhoD;
		float otherstate1, otherstate2, otherstate3, otherstate4, unmapother;
		Cell *othercell1, *othercell2, *othercell3, *othercell4;
		
		othercell1 = ptrWorld->rule()->getNeighbor(currentCell, 3);
		othercell2 = ptrWorld->rule()->getNeighbor(currentCell, 5);
		othercell3 = ptrWorld->rule()->getNeighbor(currentCell, 17);
		othercell4 = ptrWorld->rule()->getNeighbor(currentCell, 19);
		
		otherstate1 = othercell1->phase;
		otherstate2 = othercell2->phase;
		otherstate3 = othercell3->phase;
		otherstate4 = othercell4->phase;
		
		unmap = unmapf(state, 0, ptrWorld->rule()->numStates()-1);
		
		thetaA = ((2 * PI)/ptrWorld->sizeX() * othercell1->x) + (2 * PI / maxphase * (wrapi(counter, 0, maxphase) / maxphase));
		phiA = ((2 * PI)/ptrWorld->sizeY() * othercell1->y) + (2 * PI / maxphase * (wrapi(counter, 0, maxphase) / maxphase));
		rhoA = othercell1->z * (fragSizeX * 0.5) + (fragSizeX * otherstate1 * 0.5);
		
		thetaB = ((2 * PI)/ptrWorld->sizeX() * othercell2->x) + (2 * PI / maxphase * (wrapi(counter, 0, maxphase) / maxphase));
		phiB = ((2 * PI)/ptrWorld->sizeY() * othercell2->y) + (2 * PI / maxphase * (wrapi(counter, 0, maxphase) / maxphase));
		rhoB = othercell2->z * (fragSizeX * 0.5) + (fragSizeX * otherstate2* 0.5);

		thetaC = ((2 * PI)/ptrWorld->sizeX() * othercell3->x) + (2 * PI / maxphase * (wrapi(counter, 0, maxphase) / maxphase));
		phiC = ((2 * PI)/ptrWorld->sizeY() * othercell3->y) + (2 * PI / maxphase * (wrapi(counter, 0, maxphase) / maxphase));
		rhoC = othercell3->z * (fragSizeX * 0.5) + (fragSizeX * otherstate3 * 0.5);

		thetaD = ((2 * PI)/ptrWorld->sizeX() * othercell4->x) + (2 * PI / maxphase * (wrapi(counter, 0, maxphase) / maxphase));
		phiD = ((2 * PI)/ptrWorld->sizeY() * othercell4->y) + (2 * PI / maxphase * (wrapi(counter, 0, maxphase) / maxphase));
		rhoD = othercell4->z * (fragSizeX * 0.5) + (fragSizeX * otherstate4 * 0.5);

		red = patternLib[26].color.r * abs(patternLib[26].colormap - unmap);
		green = patternLib[26].color.g * abs(patternLib[26].colormap - unmap);
		blue = patternLib[26].color.b * abs(patternLib[26].colormap - unmap);
		alpha = patternLib[26].alpha * abs(patternLib[26].alphamap - unmap);

		glColor4f(red, green, blue, alpha);
		glEnable(GL_POLYGON_SMOOTH);
		glBegin(GL_POLYGON);
		
		xL = rhoA * cos( thetaA ) * cos( phiA );
		yB = rhoA * sin( thetaA ) * cos( phiA );
		zF = rhoA * sin( phiA );
		
		glVertex3f(xL, yB, zF);
        
        unmapother = unmapf(otherstate1, 0, ptrWorld->rule()->numStates()-1);
        red = patternLib[26].color.r * abs(patternLib[26].colormap - unmapother);
        green = patternLib[26].color.g * abs(patternLib[26].colormap - unmapother);
        blue = patternLib[26].color.b * abs(patternLib[26].colormap - unmapother);
        alpha = patternLib[26].alpha * abs(patternLib[26].alphamap - unmapother);
        glColor4f(red, green, blue, alpha);
        
		xL = rhoB * cos( thetaB ) * cos( phiB );
		yB = rhoB * sin( thetaB ) * cos( phiB );
		zF = rhoB * sin( phiB );

		glVertex3f(xL, yB, zF);

        unmapother = unmapf(otherstate2, 0, ptrWorld->rule()->numStates()-1);
        red = patternLib[26].color.r * abs(patternLib[26].colormap - unmapother);
        green = patternLib[26].color.g * abs(patternLib[26].colormap - unmapother);
        blue = patternLib[26].color.b * abs(patternLib[26].colormap - unmapother);
        alpha = patternLib[26].alpha * abs(patternLib[26].alphamap - unmapother);
        glColor4f(red, green, blue, alpha);

		xL = rhoC * cos( thetaC ) * cos( phiC );
		yB = rhoC * sin( thetaC ) * cos( phiC );
		zF = rhoC * sin( phiC );
		
		glVertex3f(xL, yB, zF);

        unmapother = unmapf(otherstate3, 0, ptrWorld->rule()->numStates()-1);
        red = patternLib[26].color.r * abs(patternLib[26].colormap - unmapother);
        green = patternLib[26].color.g * abs(patternLib[26].colormap - unmapother);
        blue = patternLib[26].color.b * abs(patternLib[26].colormap - unmapother);
        alpha = patternLib[26].alpha * abs(patternLib[26].alphamap - unmapother);
        glColor4f(red, green, blue, alpha);

		xL = rhoD * cos( thetaD ) * cos( phiD );
		yB = rhoD * sin( thetaD ) * cos( phiD );
		zF = rhoD * sin( phiD );
		
		glVertex3f(xL, yB, zF);
				
		glEnd();
		glDisable(GL_POLYGON_SMOOTH);
				
	}

}

void GraphicsRenderer::pattern27(int x, int y, int z) {

	if (state > 0.0 && z > 0 && z % 4 == 0 ) {
		
		float unmap, thetaA, phiA, rhoA, thetaB, phiB, rhoB, thetaC, phiC, rhoC, thetaD, phiD, rhoD;
		float otherstate1, otherstate2, otherstate3, otherstate4, unmapother;
		Cell *othercell1, *othercell2, *othercell3, *othercell4;
		
		othercell1 = ptrWorld->rule()->getNeighbor(currentCell, 4);
		othercell2 = ptrWorld->rule()->getNeighbor(currentCell, 12);
		othercell3 = ptrWorld->rule()->getNeighbor(currentCell, 14);
		othercell4 = ptrWorld->rule()->getNeighbor(currentCell, 22);
		
		otherstate1 = othercell1->phase;
		otherstate2 = othercell2->phase;
		otherstate3 = othercell3->phase;
		otherstate4 = othercell4->phase;
		
		unmap = unmapf(state, 0, ptrWorld->rule()->numStates()-1);
		
		thetaA = ((2 * PI)/ptrWorld->sizeX() * othercell1->x) + (2 * PI / maxphase * (wrapi(counter, 0, maxphase) / maxphase));
		phiA = ((2 * PI)/ptrWorld->sizeY() * othercell1->y) + (2 * PI / maxphase * (wrapi(counter, 0, maxphase) / maxphase));
		rhoA = othercell1->z * (fragSizeX * 0.5) + (fragSizeX * otherstate1 * 0.5);
		
		thetaB = ((2 * PI)/ptrWorld->sizeX() * othercell2->x) + (2 * PI / maxphase * (wrapi(counter, 0, maxphase) / maxphase));
		phiB = ((2 * PI)/ptrWorld->sizeY() * othercell2->y) + (2 * PI / maxphase * (wrapi(counter, 0, maxphase) / maxphase));
		rhoB = othercell2->z * (fragSizeX * 0.5) + (fragSizeX * otherstate2* 0.5);
		
		thetaC = ((2 * PI)/ptrWorld->sizeX() * othercell3->x) + (2 * PI / maxphase * (wrapi(counter, 0, maxphase) / maxphase));
		phiC = ((2 * PI)/ptrWorld->sizeY() * othercell3->y) + (2 * PI / maxphase * (wrapi(counter, 0, maxphase) / maxphase));
		rhoC = othercell3->z * (fragSizeX * 0.5) + (fragSizeX * otherstate3 * 0.5);
		
		thetaD = ((2 * PI)/ptrWorld->sizeX() * othercell4->x) + (2 * PI / maxphase * (wrapi(counter, 0, maxphase) / maxphase));
		phiD = ((2 * PI)/ptrWorld->sizeY() * othercell4->y) + (2 * PI / maxphase * (wrapi(counter, 0, maxphase) / maxphase));
		rhoD = othercell4->z * (fragSizeX * 0.5) + (fragSizeX * otherstate4 * 0.5);
		
		red = patternLib[27].color.r * abs(patternLib[27].colormap - unmap);
		green = patternLib[27].color.g * abs(patternLib[27].colormap - unmap);
		blue = patternLib[27].color.b * abs(patternLib[27].colormap - unmap);
		alpha = patternLib[27].alpha * abs(patternLib[27].alphamap - unmap);

		glColor4f(red, green, blue, alpha);
		glEnable(GL_POLYGON_SMOOTH);
		glBegin(GL_POLYGON);
		
		xL = rhoA * cos( thetaA ) * cos( phiA );
		yB = rhoA * sin( thetaA ) * cos( phiA );
		zF = rhoA * sin( phiA );
		
		glVertex3f(xL, yB, zF);
        
        unmapother = unmapf(otherstate1, 0, ptrWorld->rule()->numStates()-1);
        red = patternLib[27].color.r * abs(patternLib[27].colormap - unmapother);
        green = patternLib[27].color.g * abs(patternLib[27].colormap - unmapother);
        blue = patternLib[27].color.b * abs(patternLib[27].colormap - unmapother);
        alpha = patternLib[27].alpha * abs(patternLib[27].alphamap - unmapother);
        glColor4f(red, green, blue, alpha);
		
		xL = rhoB * cos( thetaB ) * cos( phiB );
		yB = rhoB * sin( thetaB ) * cos( phiB );
		zF = rhoB * sin( phiB );
		
		glVertex3f(xL, yB, zF);

        unmapother = unmapf(otherstate2, 0, ptrWorld->rule()->numStates()-1);
        red = patternLib[27].color.r * abs(patternLib[27].colormap - unmapother);
        green = patternLib[27].color.g * abs(patternLib[27].colormap - unmapother);
        blue = patternLib[27].color.b * abs(patternLib[27].colormap - unmapother);
        alpha = patternLib[27].alpha * abs(patternLib[27].alphamap - unmapother);
        glColor4f(red, green, blue, alpha);

		xL = rhoC * cos( thetaC ) * cos( phiC );
		yB = rhoC * sin( thetaC ) * cos( phiC );
		zF = rhoC * sin( phiC );
		
		glVertex3f(xL, yB, zF);

        unmapother = unmapf(otherstate3, 0, ptrWorld->rule()->numStates()-1);
        red = patternLib[27].color.r * abs(patternLib[27].colormap - unmapother);
        green = patternLib[27].color.g * abs(patternLib[27].colormap - unmapother);
        blue = patternLib[27].color.b * abs(patternLib[27].colormap - unmapother);
        alpha = patternLib[27].alpha * abs(patternLib[27].alphamap - unmapother);
        glColor4f(red, green, blue, alpha);

		xL = rhoD * cos( thetaD ) * cos( phiD );
		yB = rhoD * sin( thetaD ) * cos( phiD );
		zF = rhoD * sin( phiD );
		
		glVertex3f(xL, yB, zF);
		
		glEnd();
		glDisable(GL_POLYGON_SMOOTH);
		
	}
}

void GraphicsRenderer::pattern28(int x, int y, int z) {
	if ((x % 5 == 0 || y % 4 == 0 || z % 6 == 0) && state > 0.0)
	{
		float cstate;
		
		if (ptrWorld->ruleType() == CONT) {
			cstate = state;
		}
		else {
			if (state != 0)
			{
				cstate = 1.0 / state;
			}
			else {
				cstate = 0.0f;
			}
		}
		
		xL = (float)x * fragSizeX + (fragSizeX * 0.5);
		yB = (float)y * fragSizeX + (fragSizeX * 0.5);
		zF = (float)z * fragSizeX + (fragSizeX * 0.5);
		
		xL -= hx;
		yB -= hx;
		zF -= hx;
		
		cstate = mapf(cstate, 0.5, 2.0);
		
		red = patternLib[28].color.r * abs(patternLib[28].colormap - cstate);
		green = patternLib[28].color.g * abs(patternLib[28].colormap - cstate);
		blue = patternLib[28].color.b * abs(patternLib[28].colormap - cstate);
		alpha = patternLib[28].alpha * abs(patternLib[28].alphamap - cstate);
		
		xW = yH = zD = fragSizeX * cstate;
		
		glDisable( GL_LIGHTING );
		glEnable( GL_TEXTURE_2D );
		img01.bind();
		gl::pushMatrices();
		
		gl::color(red, green, blue, alpha);
		gl::drawCube( Vec3f(xL, yB, zF), Vec3f(xW, yH, zD) );	
		
		gl::popMatrices();
		img01.unbind();
		glDisable( GL_TEXTURE_2D );
		
	}
	
}

void GraphicsRenderer::pattern29(int x, int y, int z) {
	
	
	if (state > 0.0 && z%4==0) {
		
		float unmap, cstate, theta, rho, phi, otunmap;
		
		unmap = 1.0-unmapf(state, 0, ptrWorld->rule()->numStates()-1);
		cstate = currentCell->states[ptrWorld->index()];
		
		xL = (float)x * fragSizeX + (fragSizeX * 0.5);
		yB = (float)y * fragSizeX + (fragSizeX * 0.5);
		zF = (float)z * fragSizeX + (fragSizeX * 0.5);
		
		xW = fragSizeX * unmap * 2.0;
		yH = fragSizeX * unmap * 2.0;
		zD = fragSizeZ * unmap * 2.0;
		
		xL -= hx;
		yB -= hx;
		zF -= hx;
		
		red = patternLib[29].color.r * abs(patternLib[29].colormap - unmap);
		green = patternLib[29].color.g * abs(patternLib[29].colormap - unmap);
		blue = patternLib[29].color.b * abs(patternLib[29].colormap - unmap);
		alpha = patternLib[29].alpha * abs(patternLib[29].alphamap - unmap);
		
		theta = ((2 * PI)/ptrWorld->sizeX() * x);
		phi = ((2 * PI)/ptrWorld->sizeY() * y);
		rho = z * (fragSizeX * 0.5);
		
		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );
				
		gl::color(red, green, blue, alpha);
		glEnable(GL_POLYGON_SMOOTH);
		glBegin(GL_POLYGON);
		
		gl::vertex( Vec3f(xL, yB, zF) );
		
		theta = ((2 * PI)/ptrWorld->sizeX() * (x - 1));
		phi = ((2 * PI)/ptrWorld->sizeY() * y);
		
		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

        otunmap = sin(unmap * PI);
        red = patternLib[29].color.r * abs(patternLib[29].colormap - otunmap);
        green = patternLib[29].color.g * abs(patternLib[29].colormap - otunmap);
        blue = patternLib[29].color.b * abs(patternLib[29].colormap - otunmap);
        alpha = patternLib[29].alpha * abs(patternLib[29].alphamap - otunmap);
        gl::color(red, green, blue, alpha);
        
		gl::vertex( Vec3f(xL, yB, zF) );
		
		theta = ((2 * PI)/ptrWorld->sizeX() * (x - 1));
		phi = ((2 * PI)/ptrWorld->sizeY() * (y - 1));
		
		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

        otunmap = cos(unmap * PI);
        red = patternLib[29].color.r * abs(patternLib[29].colormap - otunmap);
        green = patternLib[29].color.g * abs(patternLib[29].colormap - otunmap);
        blue = patternLib[29].color.b * abs(patternLib[29].colormap - otunmap);
        alpha = patternLib[29].alpha * abs(patternLib[29].alphamap - otunmap);
        gl::color(red, green, blue, alpha);
		
		gl::vertex( Vec3f(xL, yB, zF) );

		theta = ((2 * PI)/ptrWorld->sizeX() * x);
		phi = ((2 * PI)/ptrWorld->sizeY() * (y - 1));

		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

        otunmap = sin(unmap * PI);
        red = patternLib[29].color.r * abs(patternLib[29].colormap - otunmap);
        green = patternLib[29].color.g * abs(patternLib[29].colormap - otunmap);
        blue = patternLib[29].color.b * abs(patternLib[29].colormap - otunmap);
        alpha = patternLib[29].alpha * abs(patternLib[29].alphamap - otunmap);
        gl::color(red, green, blue, alpha);

		gl::vertex( Vec3f(xL, yB, zF) );
		
		glEnd();
		glDisable(GL_POLYGON_SMOOTH);
		
	}	
}

void GraphicsRenderer::pattern30(int x, int y, int z) {

	if ( 
		((x == ptrWorld->sizeX() / 2 && isEven(state)) || (x == ptrWorld->sizeX() / 2 - 1 && !isEven(state))) || 
		((y == ptrWorld->sizeY() / 2 && isEven(state)) || (y == ptrWorld->sizeY() / 2 - 1 && !isEven(state))) || 
		((z == ptrWorld->sizeZ() / 2 && isEven(state)) || (z == ptrWorld->sizeZ() / 2 - 1 && !isEven(state)))
	) 	
	{
		float cstate;
		
		if (ptrWorld->ruleType() == CONT) {
			cstate = state;
		}
		else {
			if (state != 0)
			{
				cstate = 1.0 / state;
			}
			else {
				cstate = 0.0f;
			}
		}
		
		if (cstate > 0.01f)
		{
		
			xL = (float)x * fragSizeX + (fragSizeX * 0.5);
			yB = (float)y * fragSizeX + (fragSizeX * 0.5);
			zF = (float)z * fragSizeX + (fragSizeX * 0.5);
			
			xL -= hx;
			yB -= hx;
			zF -= hx;
			
			cstate = mapf(cstate, 0.5, 2.0);
			
			red = patternLib[30].color.r * abs(patternLib[30].colormap - cstate);
			green = patternLib[30].color.g * abs(patternLib[30].colormap - cstate);
			blue = patternLib[30].color.b * abs(patternLib[30].colormap - cstate);
			alpha = patternLib[30].alpha * abs(patternLib[30].alphamap - cstate);
			
			xW = yH = zD = fragSizeX * cstate;
			
			glDisable( GL_LIGHTING );
			glEnable( GL_TEXTURE_2D );
			img03.bind();
			gl::pushMatrices();
			
			gl::color(red, green, blue, 1.0);
			gl::drawCube( Vec3f(xL, yB, zF), Vec3f(xW, yH, zD) );	
			
			gl::popMatrices();
			img03.unbind();
			glDisable( GL_TEXTURE_2D );
		}		
	}	
		
}

void GraphicsRenderer::pattern31(int x, int y, int z) {
	
	if (state > 0.0 && z%4==0) {
		
		float unmap, cstate, theta, rho, phi, otunmap;
		
		unmap = 1.0-unmapf(state, 0, ptrWorld->rule()->numStates()-1);
		cstate = currentCell->states[ptrWorld->index()];
		
		xL = (float)x * fragSizeX + (fragSizeX * 0.5);
		yB = (float)y * fragSizeX + (fragSizeX * 0.5);
		zF = (float)z * fragSizeX + (fragSizeX * 0.5);
		
		xW = fragSizeX * unmap * 2.0;
		yH = fragSizeX * unmap * 2.0;
		zD = fragSizeZ * unmap * 2.0;
		
		xL -= hx;
		yB -= hx;
		zF -= hx;
		
		red = patternLib[31].color.r * abs(patternLib[31].colormap - unmap);
		green = patternLib[31].color.g * abs(patternLib[31].colormap - unmap);
		blue = patternLib[31].color.b * abs(patternLib[31].colormap - unmap);
		alpha = patternLib[31].alpha * abs(patternLib[31].alphamap - unmap);
		
		theta = ((2 * PI)/ptrWorld->sizeX() * x);
		phi = ((2 * PI)/ptrWorld->sizeY() * y);
		rho = z * (fragSizeX * 0.5) + (fragSizeX * mapf(unmap, -2.0, 2.0));
		
		theta *= mapf(unmap, 0.2, 0.8 );
		phi *= mapf(unmap, 0.2, 0.8 );
		
		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );
        
		glColor4f(red, green, blue, alpha);
		glEnable(GL_POLYGON_SMOOTH);
		glBegin(GL_POLYGON);
		
		glVertex3f(xL, yB, zF);
		
		theta = ((2 * PI)/ptrWorld->sizeX() * (x - 1));
		phi = ((2 * PI)/ptrWorld->sizeY() * y);

		theta *= mapf(unmap, 0.2, 0.8 );
		phi *= mapf(unmap, 0.2, 0.8 );

		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );
        
        otunmap = sin(unmap * PI);
        red = patternLib[31].color.r * abs(patternLib[31].colormap - otunmap);
        green = patternLib[31].color.g * abs(patternLib[31].colormap - otunmap);
        blue = patternLib[31].color.b * abs(patternLib[31].colormap - otunmap);
        alpha = patternLib[31].alpha * abs(patternLib[31].alphamap - otunmap);
        gl::color(red, green, blue, alpha);
        
		glVertex3f(xL, yB, zF);
		
		theta = ((2 * PI)/ptrWorld->sizeX() * (x - 1));
		phi = ((2 * PI)/ptrWorld->sizeY() * (y - 1));

		theta *= mapf(unmap, 0.2, 0.8 );
		phi *= mapf(unmap, 0.2, 0.8 );

		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

        otunmap = cos(unmap * PI);
        red = patternLib[31].color.r * abs(patternLib[31].colormap - otunmap);
        green = patternLib[31].color.g * abs(patternLib[31].colormap - otunmap);
        blue = patternLib[31].color.b * abs(patternLib[31].colormap - otunmap);
        alpha = patternLib[31].alpha * abs(patternLib[31].alphamap - otunmap);
        gl::color(red, green, blue, alpha);

		glVertex3f(xL, yB, zF);
		
		theta = ((2 * PI)/ptrWorld->sizeX() * x);
		phi = ((2 * PI)/ptrWorld->sizeY() * (y - 1));

		theta *= mapf(unmap, 0.2, 0.8 );
		phi *= mapf(unmap, 0.2, 0.8 );

		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

        otunmap = sin(unmap * PI);
        red = patternLib[31].color.r * abs(patternLib[31].colormap - otunmap);
        green = patternLib[31].color.g * abs(patternLib[31].colormap - otunmap);
        blue = patternLib[31].color.b * abs(patternLib[31].colormap - otunmap);
        alpha = patternLib[31].alpha * abs(patternLib[31].alphamap - otunmap);
        gl::color(red, green, blue, alpha);

		glVertex3f(xL, yB, zF);
		
		glEnd();
		glDisable(GL_POLYGON_SMOOTH);
        
		
	}
	
}

void GraphicsRenderer::pattern32(int x, int y, int z) {
	if (state > 0.0 && z%4==0) {
		
		float unmap, cstate, theta, rho, phi, cmap;
		
		unmap = 1.0-unmapf(state, 0, ptrWorld->rule()->numStates()-1);
		cstate = currentCell->states[ptrWorld->index()];
		
		xL = (float)x * fragSizeX + (fragSizeX * 0.5);
		yB = (float)y * fragSizeX + (fragSizeX * 0.5);
		zF = (float)z * fragSizeX + (fragSizeX * 0.5);
		
		xW = fragSizeX * unmap * 2.0;
		yH = fragSizeX * unmap * 2.0;
		zD = fragSizeZ * unmap * 2.0;
		
		xL -= hx;
		yB -= hx;
		zF -= hx;
		
		red = patternLib[32].color.r * abs(patternLib[32].colormap - unmap);
		green = patternLib[32].color.g * abs(patternLib[32].colormap - unmap);
		blue = patternLib[32].color.b * abs(patternLib[32].colormap - unmap);
		alpha = patternLib[32].alpha * abs(patternLib[32].alphamap - unmap);
		
		theta = ((2 * PI)/ptrWorld->sizeX() * x);
		phi = ((2 * PI)/ptrWorld->sizeY() * y);
		rho = z * (fragSizeX * 0.5) + (fragSizeX * mapf(unmap, 2.0, 0.5));
		
		theta *= mapf(unmap, 0.5, 2.0 );
		phi *= mapf(unmap, 0.2, 0.8 );
		
		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );
		
		glColor4f(red, green, blue, alpha);
		glEnable(GL_POLYGON_SMOOTH);
		glBegin(GL_POLYGON);
		
		glVertex3f(xL, yB, zF);
		
		theta = ((2 * PI)/ptrWorld->sizeX() * (x - 1));
		phi = ((2 * PI)/ptrWorld->sizeY() * y);
		
		theta *= mapf(unmap, 0.5, 2.0 );
		phi *= mapf(unmap, 0.2, 0.8 );
		
		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );
		
        cmap = theta / (2 * PI);
        red = patternLib[32].color.r * abs(patternLib[32].colormap - cmap);
        green = patternLib[32].color.g * abs(patternLib[32].colormap - cmap);
        blue = patternLib[32].color.b * abs(patternLib[32].colormap - cmap);
        alpha = patternLib[32].alpha * abs(patternLib[32].alphamap - cmap);
        glColor4f(red, green, blue, alpha);
        
		glVertex3f(xL, yB, zF);
		
		theta = ((2 * PI)/ptrWorld->sizeX() * (x - 1));
		phi = ((2 * PI)/ptrWorld->sizeY() * (y - 1));
		
		theta *= mapf(unmap, 0.5, 2.0 );
		phi *= mapf(unmap, 0.2, 0.8 );
		
		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

        cmap = rho / (2 * PI);
        red = patternLib[32].color.r * abs(patternLib[32].colormap - cmap);
        green = patternLib[32].color.g * abs(patternLib[32].colormap - cmap);
        blue = patternLib[32].color.b * abs(patternLib[32].colormap - cmap);
        alpha = patternLib[32].alpha * abs(patternLib[32].alphamap - cmap);
        glColor4f(red, green, blue, alpha);

		glVertex3f(xL, yB, zF);
		
		theta = ((2 * PI)/ptrWorld->sizeX() * x);
		phi = ((2 * PI)/ptrWorld->sizeY() * (y - 1));
		
		theta *= mapf(unmap, 0.5, 2.0 );
		phi *= mapf(unmap, 0.2, 0.8 );
		
		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

        cmap = sin(unmap * PI);
        red = patternLib[32].color.r * abs(patternLib[32].colormap - cmap);
        green = patternLib[32].color.g * abs(patternLib[32].colormap - cmap);
        blue = patternLib[32].color.b * abs(patternLib[32].colormap - cmap);
        alpha = patternLib[32].alpha * abs(patternLib[32].alphamap - cmap);
        glColor4f(red, green, blue, alpha);

		glVertex3f(xL, yB, zF);
		
		theta = ((2 * PI)/ptrWorld->sizeX() * x + 1);
		phi = ((2 * PI)/ptrWorld->sizeY() * y);
		rho += mapf(unmap, fragSizeX*0.5, fragSizeX*2.0);

		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

        cmap = cos(unmap * PI);
        red = patternLib[32].color.r * abs(patternLib[32].colormap - cmap);
        green = patternLib[32].color.g * abs(patternLib[32].colormap - cmap);
        blue = patternLib[32].color.b * abs(patternLib[32].colormap - cmap);
        alpha = patternLib[32].alpha * abs(patternLib[32].alphamap - cmap);
        glColor4f(red, green, blue, alpha);

		glVertex3f(xL, yB, zF);

		phi = ((2 * PI)/ptrWorld->sizeY() * y + 1);
		
		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

        cmap = rho / (2 * PI);
        red = patternLib[32].color.r * abs(patternLib[32].colormap - cmap);
        green = patternLib[32].color.g * abs(patternLib[32].colormap - cmap);
        blue = patternLib[32].color.b * abs(patternLib[32].colormap - cmap);
        alpha = patternLib[32].alpha * abs(patternLib[32].alphamap - cmap);
        glColor4f(red, green, blue, alpha);

		glVertex3f(xL, yB, zF);

		phi = ((2 * PI)/ptrWorld->sizeY() * x);
		
		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

        cmap = theta / (2 * PI);
        red = patternLib[32].color.r * abs(patternLib[32].colormap - cmap);
        green = patternLib[32].color.g * abs(patternLib[32].colormap - cmap);
        blue = patternLib[32].color.b * abs(patternLib[32].colormap - cmap);
        alpha = patternLib[32].alpha * abs(patternLib[32].alphamap - cmap);
        glColor4f(red, green, blue, alpha);

		glVertex3f(xL, yB, zF);

		phi = ((2 * PI)/ptrWorld->sizeY() * y);
		
		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

        red = patternLib[32].color.r * abs(patternLib[32].colormap - unmap);
        green = patternLib[32].color.g * abs(patternLib[32].colormap - unmap);
        blue = patternLib[32].color.b * abs(patternLib[32].colormap - unmap);
        alpha = patternLib[32].alpha * abs(patternLib[32].alphamap - unmap);
        glColor4f(red, green, blue, alpha);

		glVertex3f(xL, yB, zF);
		
		glEnd();
		glDisable(GL_POLYGON_SMOOTH);
		
	}	
	
}

void GraphicsRenderer::pattern33(int x, int y, int z) {
	if (state > 0.0 && x%3==0 && y%3==0 && z%4==0) {
		
		float unmap, cstate, theta, rho, phi, nunmap, cmap;
		Cell *neighbor;
		
		neighbor = ptrWorld->rule()->getNeighbor(currentCell, 4);
		
		unmap = 1.0-unmapf(state, 0, ptrWorld->rule()->numStates()-1);
		cstate = currentCell->states[ptrWorld->index()];
		
		nunmap = unmapf(neighbor->phase, 0, ptrWorld->rule()->numStates()-1);
				
		red = patternLib[33].color.r * abs(patternLib[33].colormap - unmap);
		green = patternLib[33].color.g * abs(patternLib[33].colormap - unmap);
		blue = patternLib[33].color.b * abs(patternLib[33].colormap - unmap);
		alpha = patternLib[33].alpha * abs(patternLib[33].alphamap - unmap);

		glColor4f(red, green, blue, alpha);
		
		glEnable(GL_POLYGON_SMOOTH);
		glBegin(GL_POLYGON);
		
		theta = ((2 * PI)/ptrWorld->sizeX() * x);
		phi = ((2 * PI)/ptrWorld->sizeY() * y);
		rho = z * fragSizeX;
		
		theta *= mapf(unmap, 0.3, 1.0 );
		phi *= mapf(unmap, 0.3, 1.0 );
		
		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );
				
		glVertex3f(xL, yB, zF);
		
		theta = ((2 * PI)/ptrWorld->sizeX() * (x - 1));
		phi = ((2 * PI)/ptrWorld->sizeY() * y);
		
		theta *= mapf(unmap, 0.3, 1.0 );
		phi *= mapf(unmap, 0.3, 1.0 );
		
		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

        cmap = sin(unmap * PI);
        red = patternLib[33].color.r * abs(patternLib[33].colormap - unmap);
        green = patternLib[33].color.g * abs(patternLib[33].colormap - unmap);
        blue = patternLib[33].color.b * abs(patternLib[33].colormap - unmap);
        alpha = patternLib[33].alpha * abs(patternLib[33].alphamap - unmap);
        
        glColor4f(red, green, blue, alpha);
        
		glVertex3f(xL, yB, zF);
		
		theta = ((2 * PI)/ptrWorld->sizeX() * (x - 1));
		phi = ((2 * PI)/ptrWorld->sizeY() * (y - 1));
		
		theta *= mapf(unmap, 0.3, 1.0 );
		phi *= mapf(unmap, 0.3, 1.0 );
		
		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

        cmap = cos(unmap * PI);
        red = patternLib[33].color.r * abs(patternLib[33].colormap - unmap);
        green = patternLib[33].color.g * abs(patternLib[33].colormap - unmap);
        blue = patternLib[33].color.b * abs(patternLib[33].colormap - unmap);
        alpha = patternLib[33].alpha * abs(patternLib[33].alphamap - unmap);
        
        glColor4f(red, green, blue, alpha);

		glVertex3f(xL, yB, zF);
		
		theta = ((2 * PI)/ptrWorld->sizeX() * x);
		phi = ((2 * PI)/ptrWorld->sizeY() * (y - 1));
		
		theta *= mapf(unmap, 0.3, 1.0 );
		phi *= mapf(unmap, 0.3, 1.0 );
		
		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

        cmap = sin(unmap * PI);
        red = patternLib[33].color.r * abs(patternLib[33].colormap - unmap);
        green = patternLib[33].color.g * abs(patternLib[33].colormap - unmap);
        blue = patternLib[33].color.b * abs(patternLib[33].colormap - unmap);
        alpha = patternLib[33].alpha * abs(patternLib[33].alphamap - unmap);
        
        glColor4f(red, green, blue, alpha);

		glVertex3f(xL, yB, zF);
	
		glEnd();

		glBegin(GL_POLYGON);

		// second structure

		theta = ((2 * PI)/ptrWorld->sizeX() * x);
		phi = ((2 * PI)/ptrWorld->sizeY() * y);
		rho = z * fragSizeX - fragSizeX;
		
		theta *= mapf(nunmap, 0.3, 1.0 );
		phi *= mapf(nunmap, 0.3, 1.0 );
		
		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

        red = patternLib[33].color.r * abs(patternLib[33].colormap - nunmap);
        green = patternLib[33].color.g * abs(patternLib[33].colormap - nunmap);
        blue = patternLib[33].color.b * abs(patternLib[33].colormap - nunmap);
        alpha = patternLib[33].alpha * abs(patternLib[33].alphamap - nunmap);
        
        glColor4f(red, green, blue, alpha);

		glVertex3f(xL, yB, zF);
		
		theta = ((2 * PI)/ptrWorld->sizeX() * (x - 1));
		phi = ((2 * PI)/ptrWorld->sizeY() * y);
		
		theta *= mapf(nunmap, 0.3, 1.0 );
		phi *= mapf(nunmap, 0.3, 1.0 );
		
		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

        cmap = sin(nunmap * PI);
        red = patternLib[33].color.r * abs(patternLib[33].colormap - cmap);
        green = patternLib[33].color.g * abs(patternLib[33].colormap - cmap);
        blue = patternLib[33].color.b * abs(patternLib[33].colormap - cmap);
        alpha = patternLib[33].alpha * abs(patternLib[33].alphamap - cmap);
        
        glColor4f(red, green, blue, alpha);

		glVertex3f(xL, yB, zF);
		
		theta = ((2 * PI)/ptrWorld->sizeX() * (x - 1));
		phi = ((2 * PI)/ptrWorld->sizeY() * (y - 1));
		
		theta *= mapf(nunmap, 0.3, 1.0 );
		phi *= mapf(nunmap, 0.3, 1.0 );
		
		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

        red = patternLib[33].color.r * abs(patternLib[33].colormap - nunmap);
        green = patternLib[33].color.g * abs(patternLib[33].colormap - nunmap);
        blue = patternLib[33].color.b * abs(patternLib[33].colormap - nunmap);
        alpha = patternLib[33].alpha * abs(patternLib[33].alphamap - nunmap);
        
        glColor4f(red, green, blue, alpha);
        
		glVertex3f(xL, yB, zF);
				
		theta = ((2 * PI)/ptrWorld->sizeX() * x);
		phi = ((2 * PI)/ptrWorld->sizeY() * (y - 1));
		
		theta *= mapf(nunmap, 0.3, 1.0 );
		phi *= mapf(nunmap, 0.3, 1.0 );
		
		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

        cmap = cos(nunmap * PI);
        red = patternLib[33].color.r * abs(patternLib[33].colormap - cmap);
        green = patternLib[33].color.g * abs(patternLib[33].colormap - cmap);
        blue = patternLib[33].color.b * abs(patternLib[33].colormap - cmap);
        alpha = patternLib[33].alpha * abs(patternLib[33].alphamap - cmap);
        
        glColor4f(red, green, blue, alpha);

		glVertex3f(xL, yB, zF);
						
		theta = ((2 * PI)/ptrWorld->sizeX() * x);
		phi = ((2 * PI)/ptrWorld->sizeY() * y);
		rho = z * fragSizeX;
		
		theta *= mapf(unmap, 0.3, 1.0 );
		phi *= mapf(unmap, 0.3, 1.0 );
		
		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

        red = patternLib[33].color.r * abs(patternLib[33].colormap - nunmap);
        green = patternLib[33].color.g * abs(patternLib[33].colormap - nunmap);
        blue = patternLib[33].color.b * abs(patternLib[33].colormap - nunmap);
        alpha = patternLib[33].alpha * abs(patternLib[33].alphamap - nunmap);
        
        glColor4f(red, green, blue, alpha);

		glVertex3f(xL, yB, zF);
		
		theta *= mapf(nunmap, 0.3, 1.0 );
		phi *= mapf(nunmap, 0.3, 1.0 );
		rho = z * fragSizeX - fragSizeX;
		
		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

        cmap = cos(nunmap * PI);
        red = patternLib[33].color.r * abs(patternLib[33].colormap - cmap);
        green = patternLib[33].color.g * abs(patternLib[33].colormap - cmap);
        blue = patternLib[33].color.b * abs(patternLib[33].colormap - cmap);
        alpha = patternLib[33].alpha * abs(patternLib[33].alphamap - cmap);
        
        glColor4f(red, green, blue, alpha);

		glVertex3f(xL, yB, zF);

		theta = ((2 * PI)/ptrWorld->sizeX() * (x - 1));
		phi = ((2 * PI)/ptrWorld->sizeY() * y);
		
		theta *= mapf(nunmap, 0.3, 1.0 );
		phi *= mapf(nunmap, 0.3, 1.0 );
		
		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

        red = patternLib[33].color.r * abs(patternLib[33].colormap - nunmap);
        green = patternLib[33].color.g * abs(patternLib[33].colormap - nunmap);
        blue = patternLib[33].color.b * abs(patternLib[33].colormap - nunmap);
        alpha = patternLib[33].alpha * abs(patternLib[33].alphamap - nunmap);
        
        glColor4f(red, green, blue, alpha);

		glVertex3f(xL, yB, zF);

		theta = ((2 * PI)/ptrWorld->sizeX() * (x - 1));
		phi = ((2 * PI)/ptrWorld->sizeY() * y);
		rho = z * fragSizeX;
		
		theta *= mapf(unmap, 0.3, 1.0 );
		phi *= mapf(unmap, 0.3, 1.0 );
		
		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

        cmap = sin(nunmap * PI);
        red = patternLib[33].color.r * abs(patternLib[33].colormap - cmap);
        green = patternLib[33].color.g * abs(patternLib[33].colormap - cmap);
        blue = patternLib[33].color.b * abs(patternLib[33].colormap - cmap);
        alpha = patternLib[33].alpha * abs(patternLib[33].alphamap - cmap);
        
        glColor4f(red, green, blue, alpha);

		glVertex3f(xL, yB, zF);

		theta = ((2 * PI)/ptrWorld->sizeX() * (x - 1));
		phi = ((2 * PI)/ptrWorld->sizeY() * (y - 1));
		
		theta *= mapf(nunmap, 0.3, 1.0 );
		phi *= mapf(nunmap, 0.3, 1.0 );
		
		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

        red = patternLib[33].color.r * abs(patternLib[33].colormap - nunmap);
        green = patternLib[33].color.g * abs(patternLib[33].colormap - nunmap);
        blue = patternLib[33].color.b * abs(patternLib[33].colormap - nunmap);
        alpha = patternLib[33].alpha * abs(patternLib[33].alphamap - nunmap);
        
        glColor4f(red, green, blue, alpha);

		glVertex3f(xL, yB, zF);
		
		rho = z * fragSizeX - fragSizeX;

		theta *= mapf(nunmap, 0.3, 1.0 );
		phi *= mapf(nunmap, 0.3, 1.0 );
		
		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

        cmap = cos(nunmap * PI);
        red = patternLib[33].color.r * abs(patternLib[33].colormap - cmap);
        green = patternLib[33].color.g * abs(patternLib[33].colormap - cmap);
        blue = patternLib[33].color.b * abs(patternLib[33].colormap - cmap);
        alpha = patternLib[33].alpha * abs(patternLib[33].alphamap - cmap);
        
        glColor4f(red, green, blue, alpha);

		glVertex3f(xL, yB, zF);

		theta = ((2 * PI)/ptrWorld->sizeX() * x);
		phi = ((2 * PI)/ptrWorld->sizeY() * (y - 1));
		
		theta *= mapf(nunmap, 0.3, 1.0 );
		phi *= mapf(nunmap, 0.3, 1.0 );
		
		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

        red = patternLib[33].color.r * abs(patternLib[33].colormap - nunmap);
        green = patternLib[33].color.g * abs(patternLib[33].colormap - nunmap);
        blue = patternLib[33].color.b * abs(patternLib[33].colormap - nunmap);
        alpha = patternLib[33].alpha * abs(patternLib[33].alphamap - nunmap);
        
        glColor4f(red, green, blue, alpha);

		glVertex3f(xL, yB, zF);
		
		rho = z * fragSizeX;

		theta *= mapf(unmap, 0.3, 1.0 );
		phi *= mapf(unmap, 0.3, 1.0 );
		
		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

        cmap = sin(nunmap * PI);
        red = patternLib[33].color.r * abs(patternLib[33].colormap - cmap);
        green = patternLib[33].color.g * abs(patternLib[33].colormap - cmap);
        blue = patternLib[33].color.b * abs(patternLib[33].colormap - cmap);
        alpha = patternLib[33].alpha * abs(patternLib[33].alphamap - cmap);
        
        glColor4f(red, green, blue, alpha);

		glVertex3f(xL, yB, zF);
		
		glEnd();
		glDisable(GL_POLYGON_SMOOTH);		
		
	}	
	
}

void GraphicsRenderer::pattern34(int x, int y, int z) {
	if (state > 0.0 && (x%5==0 || y%5==0 || z%5==0)) {
		
		float unmap, cstate;
				
		unmap = 1.0-unmapf(state, 0, ptrWorld->rule()->numStates()-1);
		cstate = currentCell->states[ptrWorld->index()];
				
		red = patternLib[34].color.r * abs(patternLib[34].colormap - unmap);
		green = patternLib[34].color.g * abs(patternLib[34].colormap - unmap);
		blue = patternLib[34].color.b * abs(patternLib[34].colormap - unmap);
		alpha = patternLib[34].alpha * abs(patternLib[34].alphamap - unmap);
		
		xL = (float)x * fragSizeX + (fragSizeX * 0.5);
		yB = (float)y * fragSizeX + (fragSizeX * 0.5);
		zF = (float)z * fragSizeX + (fragSizeX * 0.5);
				
		xL -= hx;
		yB -= hx;
		zF -= hx;
		
		gl::color(red, green, blue, alpha);	
		
		if (x%5==0)
		{
			xW = fragSizeX * 0.33;
			yH = fragSizeX * 0.33;
			zD = fragSizeX + mapf(fragSizeX * unmap, 1.0, 4.0);
			
			gl::drawCube(Vec3f(xL, yB, zF), Vec3f(xW, yH, zD) );
			
		}
		
		if (y%5==0)
		{
			xW = fragSizeX + mapf(fragSizeX * unmap, 1.0, 4.0);
			yH = fragSizeX * 0.33;
			zD = fragSizeX * 0.33;
			
			gl::drawCube(Vec3f(xL, yB, zF), Vec3f(xW, yH, zD) );
			
		}

		if (z%5==0)
		{
			xW = fragSizeX * 0.33;
			yH = fragSizeX + mapf(fragSizeX * unmap, 1.0, 4.0);
			zD = fragSizeX * 0.33;
			
			gl::drawCube(Vec3f(xL, yB, zF), Vec3f(xW, yH, zD) );
			
		}
		
	}
}

void GraphicsRenderer::pattern35(int x, int y, int z) {
	if (state > 0.0 && x > 0 && y > 0 && z > 0 && 
		x < ptrWorld->sizeX() - 1 && y < ptrWorld->sizeY() - 1 && z < ptrWorld->sizeZ() - 1 &&
		(x%4 == 0 || y%4==0 || z%4==0) ) {
		
		float unmap, cstate;
		
		unmap = 1.0-unmapf(state, 0, ptrWorld->rule()->numStates()-1);
		cstate = currentCell->states[ptrWorld->index()];
		
		red = patternLib[35].color.r * abs(patternLib[35].colormap - unmap);
		green = patternLib[35].color.g * abs(patternLib[35].colormap - unmap);
		blue = patternLib[35].color.b * abs(patternLib[35].colormap - unmap);
		alpha = patternLib[35].alpha * abs(patternLib[35].alphamap - unmap);
		
		xL = (float)x * fragSizeX + (fragSizeX * 0.5);
		yB = (float)y * fragSizeY + (fragSizeY * 0.5);
		zF = (float)z * fragSizeZ + (fragSizeZ * 0.5);
		
		xL -= hx;
		yB -= hx;
		zF -= hx;
		
		gl::color(red, green, blue, alpha);	

		glEnable(GL_POLYGON_SMOOTH);
		glBegin(GL_POLYGON);
		
		glVertex3f(xL, yB, zF);
		
		for (int i = 0; i < ptrWorld->rule()->nSize(); i++) {
			Cell* neighbor;
			neighbor = ptrWorld->rule()->getNeighbor(currentCell, i);
			if (neighbor->phase > 0.0)
			{
                
                unmap = 1.0-unmapf(neighbor->phase, 0, ptrWorld->rule()->numStates()-1);
                red = patternLib[35].color.r * abs(patternLib[35].colormap - unmap);
                green = patternLib[35].color.g * abs(patternLib[35].colormap - unmap);
                blue = patternLib[35].color.b * abs(patternLib[35].colormap - unmap);
                alpha = patternLib[35].alpha * abs(patternLib[35].alphamap - unmap);
                
                gl::color(red, green, blue, alpha);
                
				xL = (float)neighbor->x * fragSizeX + (fragSizeX * 0.5);
				yB = (float)neighbor->y * fragSizeY + (fragSizeY * 0.5);
				zF = (float)neighbor->z * fragSizeZ + (fragSizeZ * 0.5);
				
				xL -= hx;
				yB -= hx;
				zF -= hx;
				
				glVertex3f(xL, yB, zF);
				
			}
		}
		
		glVertex3f(xL, yB, zF);

		glEnd();
		glDisable(GL_POLYGON_SMOOTH);
		
	}
}

void GraphicsRenderer::pattern36(int x, int y, int z) {
    if ((x % 4 == 0 || y % 4 == 0 || z % 4 == 0) && state > 0.0)
    {
        float cstate;
        
        if (ptrWorld->ruleType() == CONT) {
            cstate = state;
        }
        else {
            if (state != 0)
            {
                cstate = 1.0 / state;
            }
            else {
                cstate = 0.0f;
            }
        }
        
        xL = (float)x * fragSizeX + (fragSizeX * 0.5);
        yB = (float)y * fragSizeX + (fragSizeX * 0.5);
        zF = (float)z * fragSizeX + (fragSizeX * 0.5);
        
        xL -= hx;
        yB -= hx;
        zF -= hx;
        
        cstate = mapf(cstate, 1.0, 4.0);
        
        red = patternLib[36].color.r * abs(patternLib[36].colormap - cstate);
        green = patternLib[36].color.g * abs(patternLib[36].colormap - cstate);
        blue = patternLib[36].color.b * abs(patternLib[36].colormap - cstate);
        alpha = patternLib[36].alpha * abs(patternLib[36].alphamap - cstate);
        
        xW = yH = zD = fragSizeX * cstate;
        
        glDisable( GL_LIGHTING );
        glEnable( GL_TEXTURE_2D );
        img[2].bind();
        gl::pushMatrices();
        
        gl::color(red, green, blue, alpha);
        gl::drawCube( Vec3f(xL, yB, zF), Vec3f(xW, yH, zD) );	
        
        gl::popMatrices();
        img[2].unbind();
        glDisable( GL_TEXTURE_2D );
        
    }
	
}

void GraphicsRenderer::pattern37(int x, int y, int z) {
    if ((x % 3 == 0 || y % 3 == 0 || z % 3 == 0) && state > 0.0)
    {
        float cstate;
        
        if (ptrWorld->ruleType() == CONT) {
            cstate = state;
        }
        else {
            if (state != 0)
            {
                cstate = state;
            }
            else {
                cstate = 0.0f;
            }
        }
        
        xL = (float)x * fragSizeX + (fragSizeX * 0.5);
        yB = (float)y * fragSizeX + (fragSizeX * 0.5);
        zF = (float)z * fragSizeX + (fragSizeX * 0.5);
        
        xL -= hx;
        yB -= hx;
        zF -= hx;
        
        cstate = mapf(cstate, 0.5, 1.0);
        
        red = patternLib[37].color.r * abs(patternLib[37].colormap - cstate);
        green = patternLib[37].color.g * abs(patternLib[37].colormap - cstate);
        blue = patternLib[37].color.b * abs(patternLib[37].colormap - cstate);
        alpha = patternLib[37].alpha * abs(patternLib[37].alphamap - cstate);
        
        xW = yH = zD = fragSizeX * cstate;
        
        glDisable( GL_LIGHTING );
        glEnable( GL_TEXTURE_2D );
        img[3].bind();
        gl::pushMatrices();
        
        gl::color(red, green, blue, alpha);
        gl::drawCube( Vec3f(xL, yB, zF), Vec3f(xW, yH, zD) );	
        
        gl::popMatrices();
        img[3].unbind();
        glDisable( GL_TEXTURE_2D );
        
    }
	
}

void GraphicsRenderer::pattern38(int x, int y, int z) {
    if ((x % 4 == 0 || y % 4 == 0 || z % 4 == 0) && state > 0.0)
    {
        float cstate;
        
        if (ptrWorld->ruleType() == CONT) {
            cstate = state;
        }
        else {
            if (state != 0)
            {
                cstate = 1.0 / state;
            }
            else {
                cstate = 0.0f;
            }
        }
        
        xL = (float)x * fragSizeX + (fragSizeX * 0.5);
        yB = (float)y * fragSizeX + (fragSizeX * 0.5);
        zF = (float)z * fragSizeX + (fragSizeX * 0.5);
        
        xL -= hx;
        yB -= hx;
        zF -= hx;
        
        cstate = mapf(cstate, 0.5, 2.0);
        
        red = patternLib[38].color.r * abs(patternLib[38].colormap - cstate);
        green = patternLib[38].color.g * abs(patternLib[38].colormap - cstate);
        blue = patternLib[38].color.b * abs(patternLib[38].colormap - cstate);
        alpha = patternLib[38].alpha * abs(patternLib[38].alphamap - cstate);
        
        xW = yH = zD = fragSizeX * cstate;
        
        glDisable( GL_LIGHTING );
        glEnable( GL_TEXTURE_2D );
        img[6].bind();
        gl::pushMatrices();
        
        gl::color(red, green, blue, alpha);
        gl::drawCube( Vec3f(xL, yB, zF), Vec3f(xW, yH, zD) );
        
        gl::popMatrices();
        img[6].unbind();
        glDisable( GL_TEXTURE_2D );
        
    }
	
}


void GraphicsRenderer::pattern39(int x, int y, int z) {
    if ((x % 2 == 0 || y % 2 == 0 || z % 2 == 0) && state > 0.0)
    {
        float cstate;
        
        if (ptrWorld->ruleType() == CONT) {
            cstate = state;
        }
        else {
            if (state != 0)
            {
                cstate = 1.0 / state;
            }
            else {
                cstate = 0.0f;
            }
        }
        
        xL = (float)x * fragSizeX + (fragSizeX * 0.5);
        yB = (float)y * fragSizeX + (fragSizeX * 0.5);
        zF = (float)z * fragSizeX + (fragSizeX * 0.5);
        
        xL -= hx;
        yB -= hx;
        zF -= hx;
        
        cstate = mapf(cstate, 0.3, 1.0);
        
        red = patternLib[39].color.r * abs(patternLib[39].colormap - cstate);
        green = patternLib[39].color.g * abs(patternLib[39].colormap - cstate);
        blue = patternLib[39].color.b * abs(patternLib[39].colormap - cstate);
        alpha = patternLib[39].alpha * abs(patternLib[39].alphamap - cstate);
        
        xW = yH = zD = fragSizeX * cstate;
        
        glDisable( GL_LIGHTING );
        glEnable( GL_TEXTURE_2D );
        img04.bind();
        gl::pushMatrices();
        
        gl::color(red, green, blue, alpha);
        gl::drawCube( Vec3f(xL, yB, zF), Vec3f(xW, yH, zD) );
//        gl::drawCube( Vec3f(xL, yB, zF), Vec3f(xW, yH, zD) );
//        gl::drawCube( Vec3f(xL, yB, zF), Vec3f(xW, yH, zD) );
        
        gl::popMatrices();
        img04.unbind();
        glDisable( GL_TEXTURE_2D );
        
    }
	
}

/*
void GraphicsRenderer::pattern39(int x, int y, int z) {
    float cstate;
    
    if (ptrWorld->ruleType() == CONT) {
        cstate = state;
    }
    else {
        if (state != 0)
        {
            cstate = 1.0 / state;
        }
        else {
            cstate = 0.0f;
        }
    }
    
    if (cstate == 1.0f) {
        
        xL = (float)x * fragSizeX + (fragSizeX * 0.5);
        yB = (float)(counter%100) * fragSizeX + (fragSizeX * 0.5);
        zF = (float)y * fragSizeX + (fragSizeX * 0.5);
        
        xL -= hx;
        yB -= hx;
        zF -= hx;
        
        cstate = mapf(cstate, 0.5, 1.0);
        red = patternLib[39].color.r * abs(patternLib[39].colormap - cstate);
        green = patternLib[39].color.g * abs(patternLib[39].colormap - cstate);
        blue = patternLib[39].color.b * abs(patternLib[39].colormap - cstate);
        alpha = patternLib[39].alpha * abs(patternLib[39].alphamap - cstate);
        
        xW = zD = fragSizeX * cstate;
        yH = fragSizeX;
        
        gl::color(red, green, blue, alpha);
        gl::drawCube( Vec3f(xL, yB, zF), Vec3f(xW, yH, zD) );
        
    }
}
*/

void GraphicsRenderer::drawBoids() {

	if (attachEyeToFirstBoid)
		mEye = boids->getBoidAtIndex(0)->pos - (boids->dimensions() * 0.5f);
	
	if (lookAtCentroid)
		mCenter = boids->centroid() - (boids->dimensions() * 0.5f);
				
	if (boidPatternLib[0].active) {
		drawBoids00();
	}
	if (boidPatternLib[1].active) {
		drawBoids01();
	}
	if (boidPatternLib[2].active) {
		drawBoids02();
	}
	if (boidPatternLib[3].active) {
		drawBoids03();
	}
	if (boidPatternLib[4].active) {
		drawBoids04();
	}
	if (boidPatternLib[5].active) {
		drawBoids05();
	}
//    if (boidPatternLib[6].active) {
//        drawBoids06();
//    }
	
}

void GraphicsRenderer::drawBoids00() {
	int i;
		
	mMaps[boidPatternLib[0].mapIndex].bindMulti(4);
	
	boidShader.bind();
	
	boidShader.uniform( "LightPos", Vec3f( getWindowWidth()/2 + 350.0f, getWindowHeight()/2 - 150.0f, 150.0f ) );
	boidShader.uniform( "EnvMap", 4 );
	
	boidShader.uniform( "BaseColor", Vec4f( 0.3f, 0.3f, 0.3f, 0.7f ) );
	boidShader.uniform( "MixRatio", 0.5f );
	
	glPushMatrix();	
	
	if (attachEyeToFirstBoid)
		i = 1;
	else
		i = 0;
	
	
	for (i; i < boids->numBoids(); i++) {
		gl::drawSphere( boids->getBoidAtIndex(i)->pos - (boids->dimensions() * 0.5f), linlin((i+1) * (1.0/(float)boids->numBoids()), 0.0, 1.0, 1.6, 3.2), 16 );		
	}
	
	glPopMatrix();
	
	boidShader.unbind();

	mMaps[boidPatternLib[0].mapIndex].unbind();
			
}


void GraphicsRenderer::drawBoids01() {
	int i;
	float line, maxdist;
	
	maxdist = boids->dimensions().distance(boids->dimensions() * 0.5f);
	
	Vec3f h = boids->dimensions() * 0.5f;
	
//	drawBoidWorldBorders();
	
//	if (attachEyeToFirstBoid)
//		mEye = boids->getBoidAtIndex(0)->pos;
//	
//	if (lookAtCentroid)
//		mCenter = boids->centroid();
		
	boidShader01.bind();
	
//	boidShader01.uniform( "LightPosition", Vec3f( getWindowWidth()/2 + 250.0f, getWindowHeight()/2 - 150.0f, 150.0f ) );
	
	boidShader01.uniform( "LightPosition", boids->getBoidAtIndex(0)->pos + (boids->dimensions() * 0.5f));
	
	boidShader01.uniform( "GlassColor", Vec4f( 
											  clipf(ptrWorld->currentBMU()->weights[0], 0.0, 1.0),
											  clipf(ptrWorld->currentBMU()->weights[0], 0.0, 1.0),
											  clipf(ptrWorld->currentBMU()->weights[0], 0.0, 1.0),
											  0.1f
											  ));
	boidShader01.uniform( "SpecularColor1", Vec4f( 0.2f, 0.6f, 0.7f, 0.1f) );
	boidShader01.uniform( "SpecularColor2", Vec4f( 0.8f, 0.8f, 0.9f, 0.1f) );
	boidShader01.uniform( "SpecularFactor1", 0.65f );
	boidShader01.uniform( "SpecularFactor2", 0.8f );
	glPushMatrix();	
	
	if (attachEyeToFirstBoid)
		i = 1;
	else
		i = 0;
		
	for (i; i < boids->numBoids(); i++) {
//		gl::drawSphere( boids->getBoidAtIndex(i)->pos, 4.0f, 16 );	
		if (i > 1) {
			//			glLineWidth(4.0f);
			//			gl::drawLine( boids->getBoidAtIndex(i)->pos, boids->getBoidAtIndex(i-1)->pos );
			line = linexp(boids->getBoidAtIndex(i)->pos.distance(boids->dimensions() * 0.5f), 0.0f, maxdist, 4.0f, 1.0f);
			gl::drawCube(
						 Vec3f(boids->dimensions().x * 0.5f - h.x, boids->getBoidAtIndex(i)->pos.y - h.y, boids->getBoidAtIndex(i)->pos.z - h.z), 
						 Vec3f(boids->dimensions().x, line, line)
						 );
			gl::drawCube(
						 Vec3f(boids->getBoidAtIndex(i)->pos.x - h.x, boids->getBoidAtIndex(i)->pos.y - h.y, boids->dimensions().z * 0.5f - h.z), 
						 Vec3f(line, line, boids->dimensions().z)
						 );
			gl::drawCube(
						 Vec3f(boids->getBoidAtIndex(i)->pos.x - h.x, boids->dimensions().y * 0.5f - h.y, boids->getBoidAtIndex(i)->pos.z - h.z), 
						 Vec3f(line, boids->dimensions().y, line)
						 );
			glLineWidth(1.0f);
		}
	}
		
	glPopMatrix();
	
	boidShader01.unbind();
		
}

void GraphicsRenderer::drawBoids02() {
	int i; float maxdist;
	
	maxdist = boids->dimensions().distance(boids->dimensions() * 0.5f);
		
	boidShader01.bind();
	
	boidShader01.uniform( "LightPosition", Vec3f( getWindowWidth()/2 + 350.0f, getWindowHeight()/2 - 150.0f, 150.0f ) );
	
	boidShader01.uniform( "GlassColor", Vec4f( 0.8f, 0.8f, 0.8f, 0.1f ));
	boidShader01.uniform( "SpecularColor1", Vec4f( 0.8f, 0.8f, 0.8f, 0.1f) );
	boidShader01.uniform( "SpecularColor2", Vec4f( 0.8f, 0.8f, 0.8f, 0.1f) );
	boidShader01.uniform( "SpecularFactor1", 0.1f );
	boidShader01.uniform( "SpecularFactor2", 0.1f );
	glPushMatrix();	
	
	if (attachEyeToFirstBoid)
		i = 1;
	else
		i = 0;

	Vec3f d = boids->dimensions();
	Vec3f h = boids->dimensions() * 0.5f;

	for (i; i < boids->numBoids(); i++) {
		Boid* b;
		b = boids->getBoidAtIndex(i);
//		gl::drawSphere( b->pos, 4.0f, 16 );	
//		line = linexp(boids->centroid().distance(boids->getBoidAtIndex(i)->pos), 0.0, maxdist, 5.0f, 1.0f);
		glLineWidth(1.0f);
		
		gl::drawLine( Vec3f(0.0, 0.0, b->pos.z) - h, Vec3f(0.0, d.y, b->pos.z) - h );
		gl::drawLine( Vec3f(0.0, b->pos.y, 0.0) - h, Vec3f(0.0, b->pos.y, d.z) - h );

		gl::drawLine( Vec3f(d.x, 0.0, b->pos.z) - h, Vec3f(d.x, d.y, b->pos.z) - h );
		gl::drawLine( Vec3f(d.x, b->pos.y, 0.0) - h, Vec3f(d.x, b->pos.y, d.z) - h );

		gl::drawLine( Vec3f(0.0, 0.0, b->pos.z) - h, Vec3f(d.x, 0.0, b->pos.z) - h );
		gl::drawLine( Vec3f(b->pos.x, 0.0, 0.0) - h, Vec3f(b->pos.x, 0.0, d.z) - h);

		gl::drawLine( Vec3f(0.0, d.y, b->pos.z) - h, Vec3f(d.x, d.y, b->pos.z) - h );
		gl::drawLine( Vec3f(b->pos.x, d.y, 0.0) - h, Vec3f(b->pos.x, d.y, d.z) - h );

		gl::drawLine( Vec3f(0.0, b->pos.y, 0.0) - h, Vec3f(d.x, b->pos.y, 0.0) - h );
		gl::drawLine( Vec3f(b->pos.x, 0.0, 0.0) - h, Vec3f(b->pos.x, d.y, 0.0) - h );

		gl::drawLine( Vec3f(0.0, b->pos.y, d.z) - h, Vec3f(d.x, b->pos.y, d.z) - h );
		gl::drawLine( Vec3f(b->pos.x, 0.0, d.z) - h, Vec3f(b->pos.x, d.y, d.z) - h );

		glLineWidth(1.0f);

	}
	
	glPopMatrix();
	
	boidShader01.unbind();
}


void GraphicsRenderer::drawBoids03() {
	int i;
	float maxdist;
	vector<Vec3f> points;
	PolyLine<Vec3f> polyX;
	PolyLine<Vec3f> polyY;
	PolyLine<Vec3f> polyZ;
	
	maxdist = boids->dimensions().distance(boids->dimensions() * 0.5f);
			
	mMaps[boidPatternLib[3].mapIndex].bindMulti(4);
	
	boidShader.bind();
	
	boidShader.uniform( "LightPos", Vec3f( getWindowWidth()/2 + 350.0f, getWindowHeight()/2 - 150.0f, 150.0f ) );
	boidShader.uniform( "EnvMap", 4 );
	
	boidShader.uniform( "BaseColor", Vec4f( 
										   clipf(ptrWorld->currentBMU()->weights[0], 0.0, 1.0),
										   clipf(ptrWorld->currentBMU()->weights[1], 0.0, 1.0),
										   clipf(ptrWorld->currentBMU()->weights[2], 0.0, 1.0),
										   clipf(ptrWorld->currentBMU()->weights[3], 0.0, 1.0)
										   ));
	boidShader.uniform( "MixRatio", 0.2f );
	
	glPushMatrix();	
	
	if (attachEyeToFirstBoid)
		i = 1;
	else
		i = 0;
	
	for (i; i < boids->numBoids(); i++) {
		points.push_back(boids->getBoidAtIndex(i)->pos - (boids->dimensions() * 0.5f));
	}
	
	BSpline3f splineX(points, 3, true, false);
	BSpline3f splineY(points, 5, true, false);
	BSpline3f splineZ(points, 11, true, false);
	
	for (float t = 0; t < 1.0f; t+= 0.005f) {
		polyX.push_back(splineX.getPosition(t));
		polyY.push_back(splineY.getPosition(t));
		polyZ.push_back(splineZ.getPosition(t));
	}
	
	glLineWidth(1.0f);	
	gl::draw( polyX );
	glLineWidth(3.0f);
	gl::draw( polyY );
	glLineWidth(5.0f);
	gl::draw( polyZ );
	glLineWidth(1.0f);
	
	glPopMatrix();
	
	boidShader.unbind();
	
	mMaps[boidPatternLib[3].mapIndex].unbind();
	
}

void GraphicsRenderer::drawBoids04() {
	int i;
	
	mMaps[boidPatternLib[4].mapIndex].bindMulti(4);
	
	boidShader.bind();
	
	boidShader.uniform( "LightPos", Vec3f( getWindowWidth()/2 + 350.0f, getWindowHeight()/2 - 150.0f, 150.0f ) );
	boidShader.uniform( "EnvMap", 4 );
	
	boidShader.uniform( "BaseColor", Vec4f( 0.3f, 0.3f, 0.3f, 0.7f ) );
	boidShader.uniform( "MixRatio", 0.5f );
	
	glPushMatrix();	
	
	if (attachEyeToFirstBoid)
		i = 1;
	else
		i = 0;
	
	
	for (i; i < boids->numBoids(); i++) {
				
		if (i > 1) {
			glLineWidth(4.0f);
			gl::drawLine( boids->getBoidAtIndex(i)->pos - (boids->dimensions() * 0.5f), boids->getBoidAtIndex(i-1)->pos - (boids->dimensions() * 0.5f));
			glLineWidth(1.0f);
		}
	}
	
	glPopMatrix();
	
	boidShader.unbind();
	
	mMaps[boidPatternLib[4].mapIndex].unbind();
	
}

void GraphicsRenderer::drawBoids05() {
	int i;
	
	mMaps[boidPatternLib[5].mapIndex].bindMulti(4);
	
	boidShader.bind();
	
	boidShader.uniform( "LightPos", Vec3f( getWindowWidth()/2 + 350.0f, getWindowHeight()/2 - 150.0f, 150.0f ) );
	boidShader.uniform( "EnvMap", 4 );
	
	boidShader.uniform( "BaseColor", Vec4f( 0.3f, 0.3f, 0.3f, 0.7f ) );
	boidShader.uniform( "MixRatio", 0.5f );
	
	glPushMatrix();	
	
	if (attachEyeToFirstBoid)
		i = 1;
	else
		i = 0;
	
	
	glBegin(GL_POLYGON);
	
	for (i; i < boids->numBoids(); i++) {
		
		if (i > 1) {
			gl::vertex(boids->getBoidAtIndex(i)->pos - (boids->dimensions() * 0.5f));
			gl::vertex(boids->getBoidAtIndex(i-1)->pos - (boids->dimensions() * 0.5f));
		}
	}
	
	glEnd();
	
	glPopMatrix();
	
	boidShader.unbind();
	
	mMaps[boidPatternLib[5].mapIndex].unbind();
	
}
/*
void GraphicsRenderer::drawBoids06() {
    for (int i = 0; i < boids->numBoids(); i++) {
        mEmitter.addParticles( 1 );
        mEmitter.exist( boids->getBoidAtIndex( i )->pos - (boids->dimensions() * 0.5f) );
        gl::enable( GL_TEXTURE_2D );
        pImg.bind();
        
        for( list<Particle>::iterator it = mEmitter.particles.begin(); it != mEmitter.particles.end(); ) {
            if( ! it->ISDEAD ) {
                it->exist(counter);
                renderImage(it->loc[0], it->radius * it->agePer, it->color, 1.0f);
                it->setAge();
                ++it;
            }
            else {
                it = mEmitter.particles.erase( it );
            }
        }
        eImg.bind();
        renderImage( mEmitter.loc, 150, mEmitter.myColor, 1.0 );
        
        gl::disable( GL_TEXTURE_2D );
        if( bTrails ) {
            for( list<Particle>::iterator it = mEmitter.particles.begin(); it != mEmitter.particles.end(); ++it ) {
                renderTrails(it->len, it->radius, it->agePer, it->loc);
            }
        }
    }
}
 */

void GraphicsRenderer::renderImage( Vec3f _loc, float _diam, Color _col, float _alpha )
{
    gl::pushMatrices();
    gl::translate( _loc.x, _loc.y, _loc.z );
    gl::scale( _diam, _diam, _diam );
    gl::color( _col.r, _col.g, _col.b, _alpha );
    gl::begin( GL_QUADS );
    gl::texCoord(0, 0);    gl::vertex(-.5, -.5);
    gl::texCoord(1, 0);    gl::vertex( .5, -.5);
    gl::texCoord(1, 1);    gl::vertex( .5,  .5);
    gl::texCoord(0, 1);    gl::vertex(-.5,  .5);
    gl::end();
    gl::popMatrices();
}

void GraphicsRenderer::renderTrails(int len, float radius, float agePer, std::vector<ci::Vec3f> loc)
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

void GraphicsRenderer::drawBoidWorldBorders() {
	
	Cell* bmu;
	float basecol, basealpha, basemix;
	float devx, devy, devz;
	
	bmu = ptrWorld->currentBMU();
	
	Vec3f m1, m2, m3, m4;
	
	if (bmu) {
		
		devx = linlin(clipf(abs(0.25 - bmu->weights[0]), 0.0, 1.0), 0.0, 1.0, 0.95, 1.05);
		devy = linlin(clipf(abs(0.25 - bmu->weights[1]), 0.0, 1.0), 0.0, 1.0, 0.95, 1.05);
		devz = linlin(clipf(abs(0.25 - bmu->weights[2]), 0.0, 1.0), 0.0, 1.0, 0.95, 1.05);

		basecol = mapf(clipf(bmu->weights[0], 0.0, 1.0), 0.3, 0.7);
		basealpha = mapf(clipf(bmu->weights[1], 0.0, 1.0), 0.1, 0.4);
		basemix = mapf(clipf(bmu->weights[2], 0.0, 1.0), 0.3, 0.7 );		
		
		m1 = Vec3f(devx, devy, devz);
		//		m2 = Vec3f(mapf(clipf(ptrWorld->currentBMU()->weights[1], 0.0, 1.0), 0.9, 1.1), mapf(clipf(ptrWorld->currentBMU()->weights[2], 0.0, 1.0), 0.9, 1.1), mapf(clipf(ptrWorld->currentBMU()->weights[0], 0.0, 1.0), 0.9, 1.1));
		//		m3 = Vec3f(mapf(clipf(ptrWorld->currentBMU()->weights[2], 0.0, 1.0), 0.9, 1.1), mapf(clipf(ptrWorld->currentBMU()->weights[0], 0.0, 1.0), 0.9, 1.1), mapf(clipf(ptrWorld->currentBMU()->weights[1], 0.0, 1.0), 0.9, 1.1));
		//		m4 = Vec3f(mapf(clipf(ptrWorld->currentBMU()->weights[0], 0.0, 1.0), 0.9, 1.1), mapf(clipf(ptrWorld->currentBMU()->weights[2], 0.0, 1.0), 0.9, 1.1), mapf(clipf(ptrWorld->currentBMU()->weights[1], 0.0, 1.0), 0.9, 1.1));
	}
	else 
	{
		basecol = 0.3;
		basealpha = 0.5;
		basemix = 0.5;
		
		m1 = Vec3f(1, 1, 1);	
		//		m2 = Vec3f(1, 1, 1);	
		//		m3 = Vec3f(1, 1, 1);	
		//		m4 = Vec3f(1, 1, 1);	
	}
		
	mMaps[0].bindMulti(4);
	
	boidShader.bind();
	
	boidShader.uniform( "LightPos", Vec3f( getWindowWidth()/2 + 350.0f, getWindowHeight()/2 - 150.0f, 150.0f ) );
	boidShader.uniform( "EnvMap", 4 );
	
	
	boidShader.uniform( "BaseColor", Vec4f(basecol , basecol, basecol, basealpha ));
	boidShader.uniform( "MixRatio", basemix);
	glPushMatrix();	
	
	gl::drawSphere( boids->dimensions() * Vec3f(0.5, 0.5, 0.5) * m1, boids->dimensions().x + 100.0f, 48 );
//	gl::drawSphere( boids->dimensions() * Vec3f(0.33, 0.66, 0.5) * m2, boids->dimensions().x + 100.0f, 48 );
//	gl::drawSphere( boids->dimensions() * Vec3f(0.66, 0.33, 0.5) * m3, boids->dimensions().x + 100.0f, 48 );
//	gl::drawSphere( boids->dimensions() * Vec3f(0.66, 0.66, 0.5) * m4, boids->dimensions().x + 100.0f, 48 );
	
	glPopMatrix();

	mMaps[0].unbind();
	
}

void GraphicsRenderer::drawBoidWorldFrame() {
	
	float csize;
	
	csize = 4.0f;
	
	boidShader01.bind();
	
	boidShader01.uniform( "LightPosition", Vec3f( getWindowWidth()/2 + 350.0f, getWindowHeight()/2 - 150.0f, 150.0f ) );
	
	boidShader01.uniform( "GlassColor", Vec4f(0.4f, 0.4f, 0.4f, 0.3f));
	boidShader01.uniform( "SpecularColor1", Vec4f( 0.4f, 0.4f, 0.4f, 0.8f) );
	boidShader01.uniform( "SpecularColor2", Vec4f( 1.0f, 1.0f, 1.0f, 0.7f) );
	boidShader01.uniform( "SpecularFactor1", 0.2f );
	boidShader01.uniform( "SpecularFactor2", 0.5f );

	glPushMatrix();	
	
	gl::drawCube(Vec3f(0.0, boids->dimensions().y * 0.5, 0.0), Vec3f(csize, boids->dimensions().y, csize));
	gl::drawCube(Vec3f(boids->dimensions().x, boids->dimensions().y * 0.5, 0.0), Vec3f(csize, boids->dimensions().y, csize));
	gl::drawCube(Vec3f(0.0, boids->dimensions().y * 0.5, boids->dimensions().z), Vec3f(csize, boids->dimensions().y, csize));
	gl::drawCube(Vec3f(boids->dimensions().x, boids->dimensions().y * 0.5, boids->dimensions().z), Vec3f(csize, boids->dimensions().y, csize));

	gl::drawCube(Vec3f(boids->dimensions().x * 0.5, 0.0, 0.0), Vec3f(boids->dimensions().y, csize, csize));
	gl::drawCube(Vec3f(boids->dimensions().x * 0.5, 0.0, boids->dimensions().z), Vec3f(boids->dimensions().y, csize, csize));
	gl::drawCube(Vec3f(boids->dimensions().x * 0.5, boids->dimensions().y, 0.0), Vec3f(boids->dimensions().y, csize, csize));
	gl::drawCube(Vec3f(boids->dimensions().x * 0.5, boids->dimensions().y, boids->dimensions().z), Vec3f(boids->dimensions().y, csize, csize));

	gl::drawCube(Vec3f(0.0, 0.0, boids->dimensions().z * 0.5), Vec3f(csize, csize, boids->dimensions().z));
	gl::drawCube(Vec3f(boids->dimensions().x, 0.0, boids->dimensions().z * 0.5), Vec3f(csize, csize, boids->dimensions().z));
	gl::drawCube(Vec3f(0.0, boids->dimensions().y, boids->dimensions().z * 0.5), Vec3f(csize, csize, boids->dimensions().z));
	gl::drawCube(Vec3f(boids->dimensions().x, boids->dimensions().y, boids->dimensions().z * 0.5), Vec3f(csize, csize, boids->dimensions().z));
	
	glPopMatrix();

}

void GraphicsRenderer::strokeRectArray() {
	
	GLfloat vertices[] = {
		xL, yB, zF,				xL + xW, yB, zF,
		xL + xW, yB, zF,		xL + xW, yB + yH, zF,
		xL + xW, yB + yH, zF,	xL, yB + yH, zF,
		xL, yB + yH, zF,		xL, yB, zF
	};
	
	GLfloat normals[] = {
		0, 0, 1,				0, 0, 1,
		0, 0, 1,				0, 0, 1,
		0, 0, 1,				0, 0, 1,
		0, 0, 1,				0, 0, 1
	};
	
	GLfloat colors[] = {
		red, green, blue, alpha,	red, green, blue, alpha,
		red, green, blue, alpha,	red, green, blue, alpha,
		red, green, blue, alpha,	red, green, blue, alpha,
		red, green, blue, alpha,	red, green, blue, alpha
	};
	
	glEnableClientState(GL_NORMAL_ARRAY);
	glEnableClientState(GL_COLOR_ARRAY);
	glEnableClientState(GL_VERTEX_ARRAY);
	
	glNormalPointer(GL_FLOAT, 0, normals);
	glColorPointer(4, GL_FLOAT, 0, colors);
	glVertexPointer(3, GL_FLOAT, 0, vertices);
	
	glEnable(GL_LINE_SMOOTH);
	
	glDrawArrays(GL_LINES, 0, 8);
	
	glDisable(GL_LINE_SMOOTH);
		
	glDisableClientState(GL_VERTEX_ARRAY);
	glDisableClientState(GL_COLOR_ARRAY);
	glDisableClientState(GL_NORMAL_ARRAY);
	
}

void GraphicsRenderer::fillRect (int plane) {
	glColor4f(red, green, blue, alpha);
	glEnable(GL_POLYGON_SMOOTH);
	glBegin(GL_POLYGON);
	
	switch (plane)
	{
		case 0:
			glVertex3f (xL, yB, zF);
			glVertex3f (xL + xW, yB, zF);
            
            red *= mapf(randFloat(), 0.9, 1.1);
            green *= mapf(randFloat(), 0.9, 1.1);
            blue *= mapf(randFloat(), 0.9, 1.1);
            glColor4f(red, green, blue, alpha);
            
			glVertex3f (xL + xW, yB, zF);
			glVertex3f (xL + xW, yB + yH, zF);

            red *= mapf(randFloat(), 0.9, 1.1);
            green *= mapf(randFloat(), 0.9, 1.1);
            blue *= mapf(randFloat(), 0.9, 1.1);
            glColor4f(red, green, blue, alpha);
            
			glVertex3f (xL + xW, yB + yH, zF);
			glVertex3f (xL, yB + yH, zF);

            red *= mapf(randFloat(), 0.9, 1.1);
            green *= mapf(randFloat(), 0.9, 1.1);
            blue *= mapf(randFloat(), 0.9, 1.1);
            glColor4f(red, green, blue, alpha);
			
			glVertex3f (xL, yB + yH, zF);
			glVertex3f (xL, yB, zF);
			
			break;
			
		case 1:
			glVertex3f (xL, yB, zF);
			glVertex3f (xL, yB, zF + zD);

            red *= mapf(randFloat(), 0.9, 1.1);
            green *= mapf(randFloat(), 0.9, 1.1);
            blue *= mapf(randFloat(), 0.9, 1.1);
            glColor4f(red, green, blue, alpha);

			glVertex3f (xL, yB, zF + zD);
			glVertex3f (xL, yB + yH, zF + zD);
            
            red *= mapf(randFloat(), 0.9, 1.1);
            green *= mapf(randFloat(), 0.9, 1.1);
            blue *= mapf(randFloat(), 0.9, 1.1);
            glColor4f(red, green, blue, alpha);
			
			glVertex3f (xL, yB + yH, zF + zD);
			glVertex3f (xL, yB + yH, zF);

            red *= mapf(randFloat(), 0.9, 1.1);
            green *= mapf(randFloat(), 0.9, 1.1);
            blue *= mapf(randFloat(), 0.9, 1.1);
            glColor4f(red, green, blue, alpha);

			glVertex3f (xL, yB + yH, zF);
			glVertex3f (xL, yB, zF);
			
			break;
			
		case 2:
			glVertex3f (xL, yB, zF);
			glVertex3f (xL + xW, yB, zF);

            red *= mapf(randFloat(), 0.9, 1.1);
            green *= mapf(randFloat(), 0.9, 1.1);
            blue *= mapf(randFloat(), 0.9, 1.1);
            glColor4f(red, green, blue, alpha);

			glVertex3f (xL + xW, yB, zF);
			glVertex3f (xL + xW, yB, zF + zD);

            red *= mapf(randFloat(), 0.9, 1.1);
            green *= mapf(randFloat(), 0.9, 1.1);
            blue *= mapf(randFloat(), 0.9, 1.1);
            glColor4f(red, green, blue, alpha);

			glVertex3f (xL + xW, yB, zF + zD);
			glVertex3f (xL, yB, zF + zD);
            
            red *= mapf(randFloat(), 0.9, 1.1);
            green *= mapf(randFloat(), 0.9, 1.1);
            blue *= mapf(randFloat(), 0.9, 1.1);
            glColor4f(red, green, blue, alpha);
			
			glVertex3f (xL, yB, zF + zD);
			glVertex3f (xL, yB, zF);

			break;
			
	}
	
	glEnd();
	glDisable(GL_POLYGON_SMOOTH);
	
}

void GraphicsRenderer::strokeRect (int plane, float lineWidth) {
	glColor4f(red, green, blue, alpha);
	glEnable(GL_LINE_SMOOTH);
	glLineWidth(lineWidth);
	glBegin(GL_LINES);
	
	switch (plane)
	{
		case 0:
			glVertex3f (xL, yB, zF);
			glVertex3f (xL + xW, yB, zF);
			
			glVertex3f (xL + xW, yB, zF);
			glVertex3f (xL + xW, yB + yH, zF);
			
			glVertex3f (xL + xW, yB + yH, zF);
			glVertex3f (xL, yB + yH, zF);
			
			glVertex3f (xL, yB + yH, zF);
			glVertex3f (xL, yB, zF);
			
			break;
			
		case 1:
			glVertex3f (xL, yB, zF);
			glVertex3f (xL, yB, zF + zD);
			
			glVertex3f (xL, yB, zF + zD);
			glVertex3f (xL, yB + yH, zF + zD);
			
			glVertex3f (xL, yB + yH, zF + zD);
			glVertex3f (xL, yB + yH, zF);
			
			glVertex3f (xL, yB + yH, zF);
			glVertex3f (xL, yB, zF);
			
			break;
			
		case 2:
			glVertex3f (xL, yB, zF);
			glVertex3f (xL + xW, yB, zF);
			
			glVertex3f (xL + xW, yB, zF);
			glVertex3f (xL + xW, yB, zF + zD);
			
			glVertex3f (xL + xW, yB, zF + zD);
			glVertex3f (xL, yB, zF + zD);
			
			glVertex3f (xL, yB, zF + zD);
			glVertex3f (xL, yB, zF);
			
			break;
			
	}
	
	
	glEnd();
	glDisable(GL_LINE_SMOOTH);
}

void GraphicsRenderer::drawPoint (float x, float y, float z, float sz) {
	glColor4f(red, green, blue, alpha);
	glEnable(GL_POINT_SMOOTH);
	glPointSize(sz);
	glBegin(GL_POINTS);
	glVertex3f(x, y, z);
	glEnd();
	glDisable(GL_POINT_SMOOTH);
}


void GraphicsRenderer::drawLine (float startx, float starty, float startz, float endx, float endy, float endz, float lineWidth) {
	glColor4f(red, green, blue, alpha);
	glEnable(GL_LINE_SMOOTH);
	glLineWidth(lineWidth);
	glBegin(GL_LINES);
	
	glVertex3f(startx, starty, startz);
	glVertex3f(endx, endy, endz);
	
	glEnd();
	glDisable(GL_LINE_SMOOTH);
}

void GraphicsRenderer::drawCircle (int plane, float r, int num_segments, bool fill) { 
	int i;
	float theta, tangetial_factor, radial_factor, x, y;
	theta = 2 * PI / num_segments;
	tangetial_factor = tanf(theta);
	radial_factor = cosf(theta);
	x = r;
	y = 0;
	
	if (fill) {
		glBegin(GL_POLYGON);	
	}
	{
		glBegin(GL_LINE_LOOP);
	}
	glColor4f(red, green, blue, alpha);
	for(i = 0; i < num_segments; i++) 
	{ 
		switch (plane) {
			case 0:
				glVertex3f(x + xL, y + yB, zF);
				break;
			case 1: 
				glVertex3f(xL, x + yB, y + zF);
				break;
			case 2:
				glVertex3f(y + xL, yB, x + zF);
				break;
		}
		
        
		float tx = -y; 
		float ty = x; 
		x += tx * tangetial_factor; 
		y += ty * tangetial_factor; 
		x *= radial_factor; 
		y *= radial_factor; 
	} 
	glEnd(); 
}

