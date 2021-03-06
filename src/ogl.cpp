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
	img04 = loadImage( loadResource("fx_parallels.jpg") );
	img05 = loadImage( loadResource("sp_00.png") );

/*
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

*/

	mEye = Vec3f(0.0f, 0.0f, -30.0f);
	mCenter = Vec3f::zero();
	mUp = Vec3f::yAxis();

	mCam.lookAt(mEye, mCenter, mUp);
	mRotation.setToIdentity();

	//glEnable( GL_TEXTURE_2D );
	//codePanel.createTexture();
	//glDisable( GL_TEXTURE_2D );

	gl::enableDepthRead();
	gl::enableDepthWrite();
	gl::enableAlphaBlending();
	gl::enable(GL_LINE_SMOOTH);

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

	gl::clear( Color( _bgr, _bgg, _bgb ) );

	glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );

	glEnable( GL_MULTISAMPLE_ARB );
	glHint (GL_MULTISAMPLE_FILTER_HINT_NV, GL_NICEST);

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

	xW = mapf(fragSizeX * cstate, 0.5, 2.0);
	yH = mapf(fragSizeX * cstate, 0.5, 2.0);
	zD = mapf(fragSizeX * cstate, 0.5, 2.0);

	red = patternLib[2].color.r * abs(patternLib[2].colormap - cstate);
	green = patternLib[2].color.g * abs(patternLib[2].colormap - cstate);
	blue = patternLib[2].color.b * abs(patternLib[2].colormap - cstate);
	alpha = patternLib[2].alpha * abs(patternLib[2].alphamap - cstate);

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
		xL += (xW * cstate);
		fillRect(1);
	}
	if (y == ptrWorld->sizeY()-1 && z < ptrWorld->sizeZ()-1 && x < ptrWorld->sizeX()-1) {
		yB += (yH * cstate);
		fillRect(2);
	}
	if (z == ptrWorld->sizeZ()-1 && x < ptrWorld->sizeX()-1 && y < ptrWorld->sizeY()-1) {
		zF += (zD * cstate);
		fillRect(0);
	}

}

void GraphicsRenderer::pattern03(int x, int y, int z) {

	float ex, ey, ez, lineWidth, scale;

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

		if ( x%5==0 && y%6==0 && z%7==0 ) {

			lineWidth = mapf(cstate, 1.0, 4.0);

			scale = 2.0;

			hx = fragSizeX * ptrWorld->sizeX() * 0.5;

			xL = (float)x * fragSizeX + (fragSizeX * 0.5);
			yB = (float)y * fragSizeX + (fragSizeX * 0.5);
			zF = (float)z * fragSizeX + (fragSizeX * 0.5);

			xL -= hx;
			yB -= hx;
			zF -= hx;

			xW = fragSizeX * cstate * 2.0;
			yH = fragSizeX * cstate;
			zD = fragSizeX * cstate;

			ex = fragSizeX * 4.0 * sinf( (cstate * 2.0 * PI) );
			ey = fragSizeX * 2.0 * cosf( (cstate * 2.0 * PI) );
			ez = fragSizeX * 2.0 * sinf( (cstate * 2.0 * PI) );

			red = patternLib[3].color.r * abs(patternLib[3].colormap - cstate);
			green = patternLib[3].color.g * abs(patternLib[3].colormap - cstate);
			blue = patternLib[3].color.b * abs(patternLib[3].colormap - cstate);
			alpha = patternLib[3].alpha * abs(patternLib[3].alphamap - cstate);

			gl::color(red, green, blue, alpha);

			gl::drawCube( Vec3f(xL, yB, zF), Vec3f( ex, ey, ez ) );

		}

		if ( (x-2)%6==0 && (z-2)%7==0 && (y-2)%5==0 ) {

			lineWidth = mapf(state, 1.0, 4.0);

			scale = 2.0;

			hx = fragSizeX * ptrWorld->sizeX() * 0.5;

			xL = (float)x * fragSizeX + (fragSizeX * 0.5);
			yB = (float)y * fragSizeX + (fragSizeX * 0.5);
			zF = (float)z * fragSizeX + (fragSizeX * 0.5);

			xL -= hx;
			yB -= hx;
			zF -= hx;

			xW = fragSizeX * cstate;
			yH = fragSizeX * cstate * 2.0;
			zD = fragSizeX * cstate;

			ex = fragSizeX * 2.0 * sinf( (cstate * 2.0 * PI) );
			ey = fragSizeX * 4.0 * sinf( (cstate * 2.0 * PI) );
			ez = fragSizeX * 2.0 * cosf( (cstate * 2.0 * PI) );

			red = patternLib[3].color.r * abs(patternLib[3].colormap - cstate);
			green = patternLib[3].color.g * abs(patternLib[3].colormap - cstate);
			blue = patternLib[3].color.b * abs(patternLib[3].colormap - cstate);
			alpha = patternLib[3].alpha * abs(patternLib[3].alphamap - cstate);

			gl::color(red, green, blue, alpha);

			gl::drawCube( Vec3f(xL, yB, zF), Vec3f( ex, ey, ez ) );

		}

		if ( y%7==0 && z%5==0 && z%6==0 ) {

			lineWidth = mapf(state, 1.0, 4.0);

			scale = 2.0;

			hx = fragSizeX * ptrWorld->sizeX() * 0.5;

			xL = (float)x * fragSizeX + (fragSizeX * 0.5);
			yB = (float)y * fragSizeX + (fragSizeX * 0.5);
			zF = (float)z * fragSizeX + (fragSizeX * 0.5);

			xL -= hx;
			yB -= hx;
			zF -= hx;

			xW = fragSizeX * cstate;
			yH = fragSizeX * cstate;
			zD = fragSizeX * cstate * 2.0;

			ex = fragSizeX * 2.0 * cosf( (cstate * 2.0 * PI) );
			ey = fragSizeX * 2.0 * sinf( (cstate * 2.0 * PI) );
			ez = fragSizeX * 4.0 * sinf( (cstate * 2.0 * PI) );

			red = patternLib[3].color.r * abs(patternLib[3].colormap - cstate);
			green = patternLib[3].color.g * abs(patternLib[3].colormap - cstate);
			blue = patternLib[3].color.b * abs(patternLib[3].colormap - cstate);
			alpha = patternLib[3].alpha * abs(patternLib[3].alphamap - cstate);

			gl::color(red, green, blue, alpha);

			gl::drawCube( Vec3f(xL, yB, zF), Vec3f( ex, ey, ez ) );

		}
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

	if (ptrWorld->ruleType() == CONT || cstate != 0.0f) {

		if (x%7==0 && y%5==0 && z%7==0) {

			xL = (float)x * fragSizeX + (fragSizeX * 2.0 * sinf(cstate * 4.0 * PI));
			yB = (float)y * fragSizeX + (fragSizeX * 2.0 * cosf(cstate * 4.0 * PI));
			zF = (float)z * fragSizeX + (fragSizeX * 0.5);

			xL -= hx;
			yB -= hx;
			zF -= hx;

			red = patternLib[4].color.r * abs(patternLib[4].colormap - cstate);
			green = patternLib[4].color.g * abs(patternLib[4].colormap - cstate);
			blue = patternLib[4].color.b * abs(patternLib[4].colormap - cstate);
			alpha = patternLib[4].alpha * abs(patternLib[4].alphamap - cstate);

			drawPoint(xL, yB, zF, 5.0);

			for (int i=0; i < currentCell->history.size(); i++) {
				double oldState;
				if (ptrWorld->ruleType() == CONT) {
					oldState = currentCell->history[i];
				}
				else {
					if (currentCell->history[i] != 0.0)
					{
						oldState = 1.0 / currentCell->history[i];
					}
					else {
						oldState = 0.0f;
					}
				}

				red *= 0.8;
				green *= 0.9;
				blue *= 0.9;
				alpha *= 0.95;

				xL = (float)x * fragSizeX + (fragSizeX * 2.0 * sinf(oldState * 4.0 * PI));
				yB = (float)y * fragSizeX + (fragSizeX * 2.0 * cosf(oldState * 4.0 * PI));
				zF = (float)z * fragSizeX + (fragSizeX * 0.5);

				xL -= hx;
				yB -= hx;
				zF -= hx;

				drawPoint(xL, yB, zF, 2.0);

			}
		}

		if (x%5==0 && y%7==0 && z%7==0) {

			xL = (float)x * fragSizeX + (fragSizeX * 0.5);
			yB = (float)y * fragSizeX + (fragSizeX * 2.0 * sinf(state * 4.0 * PI));
			zF = (float)z * fragSizeX + (fragSizeX * 2.0 * cosf(state * 4.0 * PI));

			xL -= hx;
			yB -= hx;
			zF -= hx;

			red = patternLib[4].color.r * abs(patternLib[4].colormap - state);
			green = patternLib[4].color.g * abs(patternLib[4].colormap - state);
			blue = patternLib[4].color.b * abs(patternLib[4].colormap - state);
			alpha = patternLib[4].alpha * abs(patternLib[4].alphamap - state);

			drawPoint(xL, yB, zF, 5.0);

			for (int i=0; i < currentCell->history.size(); i++) {
				double oldState;
				if (ptrWorld->ruleType() == CONT) {
					oldState = currentCell->history[i];
				}
				else {
					if (currentCell->history[i] != 0.0)
					{
						oldState = 1.0 / currentCell->history[i];
					}
					else {
						oldState = 0.0f;
					}
				}
				red *= 0.8;
				green *= 0.9;
				blue *= 0.9;
				alpha *= 0.95;

				xL = (float)x * fragSizeX + (fragSizeX * 0.5);
				yB = (float)y * fragSizeX + (fragSizeX * 2.0 * sinf(oldState * 4.0 * PI));
				zF = (float)z * fragSizeX + (fragSizeX * 2.0 * cosf(oldState * 4.0 * PI));

				xL -= hx;
				yB -= hx;
				zF -= hx;

				drawPoint(xL, yB, zF, 2.0);

			}
		}

		if (x%7==0 && y%7==0 && z%5==0) {

			xL = (float)x * fragSizeX + (fragSizeX * 2.0 * cosf(state * 4.0 * PI));
			yB = (float)y * fragSizeX + (fragSizeX * 0.5);
			zF = (float)z * fragSizeX + (fragSizeX * 2.0 * sinf(state * 4.0 * PI));

			xL -= hx;
			yB -= hx;
			zF -= hx;

			red = patternLib[4].color.r * abs(patternLib[4].colormap - state);
			green = patternLib[4].color.g * abs(patternLib[4].colormap - state);
			blue = patternLib[4].color.b * abs(patternLib[4].colormap - state);
			alpha = patternLib[4].alpha * abs(patternLib[4].alphamap - state);

			drawPoint(xL, yB, zF, 5.0);

			for (int i=0; i < currentCell->history.size(); i++) {
				double oldState;
				if (ptrWorld->ruleType() == CONT) {
					oldState = currentCell->history[i];
				}
				else {
					if (currentCell->history[i] != 0.0)
					{
						oldState = 1.0 / currentCell->history[i];
					}
					else {
						oldState = 0.0f;
					}
				}
				red *= 0.8;
				green *= 0.9;
				blue *= 0.9;
				alpha *= 0.95;

				xL = (float)x * fragSizeX + (fragSizeX * 2.0 * cosf(oldState * 4.0 * PI));
				yB = (float)y * fragSizeX + (fragSizeX * 0.5);
				zF = (float)z * fragSizeX + (fragSizeX * 2.0 * sinf(oldState * 4.0 * PI));

				xL -= hx;
				yB -= hx;
				zF -= hx;

				drawPoint(xL, yB, zF, 2.0);

			}
		}
	}

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

		float lenX, lenY, unmap;

		unmap = unmapf(state, 0, ptrWorld->rule()->numStates()-1);

		hx = fragSizeX * ptrWorld->sizeX() * 0.5;
		xL = x * fragSizeX + (fragSizeX * 0.5f);
		yB = y * fragSizeY + (fragSizeY * 0.5f);

		xL -= hx;
		yB -= hx;
		zF = 0.0;

		lenX = fragSizeX * unmap * 8.0;
		lenY = fragSizeY * unmap * 8.0;

		red = patternLib[7].color.r * abs(patternLib[7].colormap - unmap);
		green = patternLib[7].color.g * abs(patternLib[7].colormap - unmap);
		blue = patternLib[7].color.b * abs(patternLib[7].colormap - unmap);
		alpha = patternLib[7].alpha * abs(patternLib[7].alphamap - unmap);

		gl::color(red, green, blue, alpha);

		glLineWidth(2.0f);

		if (z == ptrWorld->sizeZ() / 2 || z == ptrWorld->sizeZ() / 2 + 1) {

			gl::drawLine( Vec3f(xL-lenX, yB, zF), Vec3f(xL+lenX, yB, zF) );

			lenX *= currentCell->weights[2];

			glBegin(GL_LINES);

			gl::color(red * wrapf(currentCell->weights[0], 0.0, 1.0), green * wrapf(currentCell->weights[1], 0.0, 1.0), blue * wrapf(currentCell->weights[2], 0.0, 1.0), alpha);

			gl::vertex( Vec3f(xL - lenX, yB - (fragSizeY * 0.25), zF) );

			gl::color(red * wrapf(currentCell->weights[2], 0.0, 1.0), green * wrapf(currentCell->weights[1], 0.0, 1.0), blue * wrapf(currentCell->weights[0], 0.0, 1.0), alpha);

			gl::vertex( Vec3f(xL + lenX, yB - (fragSizeY * 0.25), zF) );

			lenX *= currentCell->weights[3];

			gl::color(red * currentCell->weights[0], green * currentCell->weights[1], blue * currentCell->weights[2], alpha);

			gl::vertex( Vec3f(xL - lenX, yB + (fragSizeY * 0.25), zF) );

			gl::color(red * currentCell->weights[2], green * currentCell->weights[1], blue * currentCell->weights[0], alpha);

			gl::vertex( Vec3f(xL + lenX, yB + (fragSizeY * 0.25), zF) );

			glEnd();

		}

		lenX = fragSizeX * unmap * 8.0;
		lenY = fragSizeY * unmap * 8.0;

		if (x == ptrWorld->sizeX() / 2 || x == ptrWorld->sizeX() / 2 + 1) {

			gl::drawLine( Vec3f(xL, yB, zF-lenX), Vec3f(xL, yB, zF+lenX) );

			//lenX *= currentCell->weights[2];

			/*
			glBegin(GL_LINES);

			gl::color(red * wrapf(currentCell->weights[0], 0.0, 1.0), green * wrapf(currentCell->weights[1], 0.0, 1.0), blue * wrapf(currentCell->weights[2], 0.0, 1.0), alpha);

			gl::vertex( Vec3f(xL - lenX, yB - (fragSizeY * 0.25), zF) );

			gl::color(red * wrapf(currentCell->weights[2], 0.0, 1.0), green * wrapf(currentCell->weights[1], 0.0, 1.0), blue * wrapf(currentCell->weights[0], 0.0, 1.0), alpha);

			gl::vertex( Vec3f(xL + lenX, yB - (fragSizeY * 0.25), zF) );

			lenX *= currentCell->weights[3];

			gl::color(red * currentCell->weights[0], green * currentCell->weights[1], blue * currentCell->weights[2], alpha);

			gl::vertex( Vec3f(xL - lenX, yB + (fragSizeY * 0.25), zF) );

			gl::color(red * currentCell->weights[2], green * currentCell->weights[1], blue * currentCell->weights[0], alpha);

			gl::vertex( Vec3f(xL + lenX, yB + (fragSizeY * 0.25), zF) );

			glEnd();

			 */

		}

		if (y == ptrWorld->sizeY() / 2 || y == ptrWorld->sizeY() / 2 + 1) {

			gl::drawLine( Vec3f(xL, yB-lenY, zF), Vec3f(xL, yB+lenY, zF) );

			lenX *= currentCell->weights[2];

		}

		glLineWidth(1.0f);

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

		thetaA = ((2 * pi)/ptrWorld->sizeX() * x) + (2 * pi / maxphase * (wrapi(counter, 0, maxphase) / maxphase));
		phiA = ((2 * pi)/ptrWorld->sizeY() * y) + (2 * pi / maxphase * (wrapi(counter, 0, maxphase) / maxphase));
		rhoA = z * (fragSizeX * 0.5) + (fragSizeX * unmap);

		thetaB = ((2 * pi)/ptrWorld->sizeX() * othercell->x) + (2 * pi / maxphase * (wrapi(counter, 0, maxphase) / maxphase));
		phiB = ((2 * pi)/ptrWorld->sizeY() * othercell->y) + (2 * pi / maxphase * (wrapi(counter, 0, maxphase) / maxphase));
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

	if (state > 0.0 && (z == 0 || z == ptrWorld->sizeZ() / 2 || z == ptrWorld->sizeZ() / 2 - 1 || z == ptrWorld->sizeZ()-1))
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
		if (state > 0.0 && (x % 5 == 0 || y % 5 == 0 || z % 5 == 0)) {

			int i;
			float ex, ey, ez, mapState, maxState;
			Cell *neighbor;

			maxState = ptrWorld->rule()->numStates() - 1;
			mapState = (maxState - state) * (1 / maxState);

			xL = (float)x * fragSizeX + (fragSizeX * 0.5 + (fragSizeX * sin((1.0-mapState) * 2 * pi)));
			yB = (float)y * fragSizeX + (fragSizeX * 0.5 + (fragSizeX * sin((1.0-mapState) * 2 * pi)));
			zF = (float)z * fragSizeX + (fragSizeX * 0.5 + (fragSizeX * sin((1.0-mapState) * 2 * pi)));

			xL -= hx;
			yB -= hx;
			zF -= hx;

			if (state == 1.0)
				gl::drawSphere(Vec3f(xL, yB, zF), fragSizeX*0.1, 8);
			else
				gl::drawSphere(Vec3f(xL, yB, zF), mapState*fragSizeX*0.1, 8);

			for (i = 0; i < 26; i++) {
				neighbor = ptrWorld->rule()->getNeighbor(currentCell, i);
				if (neighbor->phase > 0.0 && neighbor->phase < 10.0)
				{
					ex = neighbor->x * fragSizeX + (fragSizeX * 0.5 + (fragSizeX * sin((1.0-mapState) * 2 * pi)));
					ey = neighbor->y * fragSizeX + (fragSizeX * 0.5 + (fragSizeX * sin((1.0-mapState) * 2 * pi)));
					ez = neighbor->z * fragSizeX + (fragSizeX * 0.5 + (fragSizeX * sin((1.0-mapState) * 2 * pi)));

					ex -= hx;
					ey -= hx;
					ez -= hx;

					red = patternLib[13].color.r * abs(patternLib[13].colormap - mapState);
					green = patternLib[13].color.g * abs(patternLib[13].colormap - mapState);
					blue = patternLib[13].color.b * abs(patternLib[13].colormap - mapState) * (1.0 - linlin(neighbor->phase, 1, 12, 0.0, 0.7));
					alpha = patternLib[13].alpha * abs(patternLib[13].alphamap - mapState) * (1.0 - linlin(neighbor->phase, 1, 12, 0.2, 0.8));

					gl::color(red, green, blue, alpha);
					gl::drawLine( Vec3f(xL, yB, zF), Vec3f(ex, ey, ez) );
				}
			}
		}
	}

}

void GraphicsRenderer::pattern14(int x, int y, int z) {
	if (state > 0.0) {
		if (x == (int)(ptrWorld->sizeX() / 4) || y == (int)(ptrWorld->sizeY() / 4) || z == (int)(ptrWorld->sizeZ() / 4))
		{

			float mapState, maxState;

			maxState = ptrWorld->rule()->numStates() - 1;
			mapState = (maxState - currentCell->states[ptrWorld->index()]) * (1 / maxState);

			xL = (float)x * fragSizeX + (fragSizeX * 0.5 + (fragSizeX * sin((1.0-mapState) * 2 * pi)));
			yB = (float)y * fragSizeX + (fragSizeX * 0.5 + (fragSizeX * sin((1.0-mapState) * 2 * pi)));
			zF = (float)z * fragSizeX + (fragSizeX * 0.5 + (fragSizeX * sin((1.0-mapState) * 2 * pi)));

			xL -= hx;
			yB -= hx;
			zF -= hx;

			xW = yH = zD = fragSizeX * (1.0 / currentCell->states[ptrWorld->index()]) * 2.0;

			red = patternLib[14].color.r * abs(patternLib[14].colormap - mapState);
			green = patternLib[14].color.g * abs(patternLib[14].colormap - mapState);
			blue = patternLib[14].color.b * abs(patternLib[14].colormap - mapState);
			alpha = patternLib[14].alpha * abs(patternLib[14].alphamap - mapState);

			glDisable( GL_LIGHTING );
			glEnable( GL_TEXTURE_2D );
			img02.bind();
			gl::pushMatrices();

			gl::color(red, green, blue, alpha);
			gl::drawCube( Vec3f(xL, yB, zF), Vec3f(xW, yH, zD) );

			gl::popMatrices();
			img02.unbind();
			glDisable( GL_TEXTURE_2D );

		}

		if (x == (int)(ptrWorld->sizeX() * 3 / 4) || y == (int)(ptrWorld->sizeY() * 3 / 4) || z == (int)(ptrWorld->sizeZ() * 3 / 4))
		{

			float mapState, maxState;

			maxState = ptrWorld->rule()->numStates() - 1;
			mapState = (maxState - currentCell->states[ptrWorld->index()]) * (1 / maxState);

			xL = (float)x * fragSizeX + (fragSizeX * 0.5 + (fragSizeX * sin((mapState) * 2 * pi)));
			yB = (float)y * fragSizeX + (fragSizeX * 0.5 + (fragSizeX * sin((mapState) * 2 * pi)));
			zF = (float)z * fragSizeX + (fragSizeX * 0.5 + (fragSizeX * sin((mapState) * 2 * pi)));

			xL -= hx;
			yB -= hx;
			zF -= hx;

			xW = yH = zD = fragSizeX * (1.0 / currentCell->states[ptrWorld->index()]) * 2.0;

			red = patternLib[14].color.r * abs(patternLib[14].colormap - mapState);
			green = patternLib[14].color.g * abs(patternLib[14].colormap - mapState);
			blue = patternLib[14].color.b * abs(patternLib[14].colormap - mapState);
			alpha = patternLib[14].alpha * abs(patternLib[14].alphamap - mapState);

			glDisable( GL_LIGHTING );
			glEnable( GL_TEXTURE_2D );
			img02.bind();
			gl::pushMatrices();

			gl::color(red, green, blue, alpha);
			gl::drawCube( Vec3f(xL, yB, zF), Vec3f(xW, yH, zD) );

			gl::popMatrices();
			img02.unbind();
			glDisable( GL_TEXTURE_2D );


		}

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
	float ctr, yval;
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

		if (z%4==0 || x%4==0 || y%4==0) {

			ctr = ptrWorld->sizeY()*fragSizeY*0.5;

			yval = ctr - (y * fragSizeY);
			xL = x * fragSizeX + fragSizeX - (fragSizeX * 4.0 * cstate);
			//	yB = (_winHeight * 0.5f) + (((_winHeight * 0.5f) - (y * fragSizeY)) * 0.5f);
			yB = sin((yval / ctr) * (PI * 0.5)) * abs(yval);
			zF = z * fragSizeX + (fragSizeX * 0.5);

			xL -= hx;
			zF -= hx;

			zD = zF;

			xW = fragSizeX * cstate * 8.0;
			yH = fragSizeY * cstate * (sin((yval / ctr) * (PI * 0.5)) * 0.3);

			red = patternLib[16].color.r * abs(patternLib[16].colormap - cstate);
			green = patternLib[16].color.g * abs(patternLib[16].colormap - cstate);
			blue = patternLib[16].color.b * abs(patternLib[16].colormap - cstate);
			alpha = patternLib[16].alpha * abs(patternLib[16].alphamap - cstate);

			gl::color(red, green, blue, alpha);
			strokeRect(0, 1.0);
		}
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

		if (z%4==0 || x%4==0 || y%4==0) {

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
			strokeRect(0, 1.0);

		}
	}
}

void GraphicsRenderer::pattern18(int x, int y, int z) {

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

		xL = x * fragSizeX + ((0.5f*fragSizeX) - mapf(cstate, fragSizeX*0.5f, fragSizeX*2.0f));
		yB = y * fragSizeX + ((0.5f*fragSizeX) - mapf(cstate, fragSizeX*0.5f, fragSizeX*2.0f));
		zF = z * fragSizeX + ((0.5f*fragSizeX) - mapf(cstate, fragSizeX*0.5f, fragSizeX*2.0f));

		xL -= hx;
		yB -= hx;
		zF -= hx;

		xW = fragSizeX;
		yH = fragSizeX;
		zD = fragSizeX;

		red = patternLib[18].color.r * abs(patternLib[18].colormap - cstate);
		green = patternLib[18].color.g * abs(patternLib[18].colormap - cstate);
		blue = patternLib[18].color.b * abs(patternLib[18].colormap - cstate);
		alpha = patternLib[18].alpha * abs(patternLib[18].alphamap - cstate);

		if (ptrWorld->currentBMU()) {
			if (ptrBMU->x == x || ptrBMU->y == y || ptrBMU->z == z)
			{

				alpha = clipf(alpha+0.33f, 0.0f, 1.0f);
				gl::color(red, green, blue, alpha);

				if (ptrBMU->x == x) {
					xL += (fragSizeX * 0.45f);
					zF += (fragSizeX * 0.45f);

					xW = fragSizeX * 0.1f;
					yH = mapf(cstate, fragSizeX, fragSizeX*2.0f);
					zD = fragSizeX * 0.1f;

					fillRect(1);

				}

				if (ptrBMU->y == y) {
					yB += (fragSizeX * 0.45f);
					xL += (fragSizeX * 0.45f);

					xW = fragSizeX * 0.1f;
					yH = fragSizeX * 0.1f;
					zD = mapf(cstate, fragSizeX, fragSizeX*2.0f);

					fillRect(2);
				}

				if (ptrBMU->z == z) {
					zF += (fragSizeX * 0.45f);
					yB += (fragSizeX * 0.45f);

					xW = mapf(cstate, fragSizeX, fragSizeX*2.0f);
					yH = fragSizeX * 0.1f;
					zD = fragSizeX * 0.1f;

					fillRect(0);
				}

			}
		}


		Vec3f bmu, curr, wrld;
		float dist, max;

		curr = Vec3f((float)x, (float)y, (float)z);
		bmu = Vec3f((float)ptrBMU->x, (float)ptrBMU->y, (float)ptrBMU->z);
		wrld = Vec3f((float)ptrWorld->sizeX(), (float)ptrWorld->sizeY(), (float)ptrWorld->sizeZ());

		dist = curr.distance(bmu);
		max = Vec3f::zero().distance(wrld);

		if (dist > 0.33f) {

			alpha = linexp(1.0 - (dist/max), 0.0, 1.0, 0.01, 1.0);

			gl::color(red, green, blue, alpha);

			xL = x * fragSizeX + (fragSizeX*0.5-(fragSizeX*alpha*cstate));
			yB = y * fragSizeX + (fragSizeX*0.5-(fragSizeX*alpha*cstate));
			zF = z * fragSizeX + (fragSizeX*0.5-(fragSizeX*alpha*cstate));

			xL -= hx;
			yB -= hx;
			zF -= hx;

			xW = fragSizeX * alpha * cstate;
			yH = fragSizeX * alpha * cstate;
			zD = fragSizeX * alpha * cstate;

			if (x%3 == 0) {
				strokeRect(1, 1.0);
			}

			if (y%3 == 0) {
				strokeRect(2, 1.0);
			}

			if (z%3 == 0) {
				strokeRect(0, 1.0);
			}
		}

	}
}

void GraphicsRenderer::pattern19(int x, int y, int z) {

	float cstate;
	bool draw;

	draw = true;

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
			draw = false;
		}
	}

	if (draw)
	{

		if (x > 0 && y > 0 && z > 0 && z < ptrWorld->sizeZ() - 1 && x < ptrWorld->sizeX() - 1 && y < ptrWorld->sizeY() - 1
			&& x % 2 == 0 && y % 2 == 0 && z % 2 == 0
			) {

			float unmap;
			int i;

			unmap = cstate;

			xL = x * fragSizeX + (fragSizeX * 0.5);
			yB = y * fragSizeX + (fragSizeX * 0.5);
			zF = z * fragSizeX + (fragSizeX * 0.5);

			xL -= hx;
			yB -= hx;
			zF -= hx;

			red = patternLib[19].color.r * abs(patternLib[19].colormap - unmap);
			green = patternLib[19].color.g * abs(patternLib[19].colormap - unmap);
			blue = patternLib[19].color.b * abs(patternLib[19].colormap - unmap);
			alpha = patternLib[19].alpha * abs(patternLib[19].alphamap - unmap);

			glDisable( GL_LIGHTING );
			glEnable( GL_TEXTURE_2D );
			img04.bind();
			gl::pushMatrices();

			glEnable(GL_POLYGON_SMOOTH);
			glBegin(GL_POLYGON);

			gl::color(red, green, blue, alpha);

			gl::vertex( Vec3f(xL, yB, zF) );

			for (i = 0; i < 26; i++) {

				xL = ptrWorld->rule()->getNeighbor(currentCell, i)->x * fragSizeX + (fragSizeX * 0.5);
				yB = ptrWorld->rule()->getNeighbor(currentCell, i)->y * fragSizeX + (fragSizeX * 0.5);
				zF = ptrWorld->rule()->getNeighbor(currentCell, i)->z * fragSizeX + (fragSizeX * 0.5);

				xL -= hx;
				yB -= hx;
				zF -= hx;

				unmap = ptrWorld->rule()->getNeighbor(currentCell, i)->states[currentIndex];

				draw = true;

				if (ptrWorld->ruleType() == CONT) {
					cstate = unmap;
				}
				else {
					if (unmap != 0)
					{
						cstate = 1.0 / unmap;
					}
					else {
						cstate = 0.0f;
						draw = false;
					}
				}

				if (draw)
				{
					red = patternLib[19].color.r * abs(patternLib[19].colormap - cstate);
					green = patternLib[19].color.g * abs(patternLib[19].colormap - cstate);
					blue = patternLib[19].color.b * abs(patternLib[19].colormap - cstate);
					alpha = patternLib[19].alpha * abs(patternLib[19].alphamap - cstate);

					gl::color(red, green, blue, alpha);

					gl::vertex( Vec3f(xL, yB, zF) );
				}

			}

			xL = x * fragSizeX + (fragSizeX * 0.5);
			yB = y * fragSizeX + (fragSizeX * 0.5);
			zF = z * fragSizeX + (fragSizeX * 0.5);

			xL -= hx;
			yB -= hx;
			zF -= hx;

			gl::color(red, green, blue, alpha);
			gl::vertex( Vec3f(xL, yB, zF) );

			glEnd();
			glDisable(GL_POLYGON_SMOOTH);

			gl::popMatrices();
			img04.unbind();
			glDisable( GL_TEXTURE_2D );

		}
	}
}

void GraphicsRenderer::pattern20(int x, int y, int z) {

	float xx, yy;
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

			xx = fragSizeX * cos((cstate + (x + 1 / ptrWorld->sizeX())) * (2 * PI));
			yy = fragSizeY * sin((cstate * 2.0f + (y + 1 / ptrWorld->sizeY())) * (2 * PI));

			xL = x * fragSizeX + xx;
			yB = (ptrWorld->sizeY() * fragSizeY * 0.5f) + (((ptrWorld->sizeY() * fragSizeY * 0.5f) - (y * fragSizeY)) * 0.5f) + yy;
			zF = z * fragSizeX + (fragSizeX * 0.5);

			xL -= hx;
			yB -= hy;
			zF -= hx;

			zD = zF;

			red = patternLib[20].color.r * abs(patternLib[20].colormap - cstate);
			green = patternLib[20].color.g * abs(patternLib[20].colormap - cstate);
			blue = patternLib[20].color.b * abs(patternLib[20].colormap - cstate);
			alpha = patternLib[20].alpha * abs(patternLib[20].alphamap - cstate);

			gl::color(red, green, blue, alpha);

			glLineWidth(mapf(cstate, 1.0f, 2.0f));

			gl::drawLine(Vec3f(xL, yB, zF), Vec3f(xL+1.0,yB+1.0, zD));

			glLineWidth(1.0f);

			xx = fragSizeX * sin((cstate + (x + 1 / 40)) * (2 * PI));
			yy = fragSizeY * cos((cstate + (y + 1 / 40)) * (2 * PI));

			xL = x * fragSizeX + xx;
			yB = (ptrWorld->sizeY() * fragSizeY * 0.5f) + (((ptrWorld->sizeY() * fragSizeY * 0.5f) - (y * fragSizeY)) * 0.5f) + yy;

			xL -= hx;
			yB -= hy;

			glLineWidth(mapf(1.0 - cstate, 1.0f, 2.0f));

			gl::drawLine(Vec3f(xL, yB, zF), Vec3f(xL+1.0,yB+1.0, zD));

			glLineWidth(1.0f);
		}
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

	xL = x * fragSizeX + fragSizeX - (fragSizeX * mapf(cstate, 0.3, 0.9));
	xW = fragSizeX * mapf(cstate, 0.3, 0.9);

	yB = y * fragSizeY + fragSizeY - (fragSizeY * mapf(cstate, 0.9, 0.3));
	yH = fragSizeY * mapf(cstate, 0.9, 0.3);

	zF = z * fragSizeX + fragSizeX - (fragSizeX * mapf(cstate, 0.3, 0.9));
	zD = fragSizeX * mapf(cstate, 0.9, 0.3);

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

		if (x%5==0) {

			int i, pts;
			float xx, yy, zz;

			pts = 3;

			for (i = 0; i < pts; i++) {

				ostate = currentCell->states[i];

				if (ptrWorld->ruleType() != CONT && ostate != 0.0)
				{
					ostate = 1.0/ostate;
				}

				xx = fragSizeX * cos( ostate * (4 * PI));
				yy = fragSizeY * sin( ostate * (4 * PI));
				zz = fragSizeZ * sin( ostate * (4 * PI));

				xL = x * fragSizeX + xx;
				yB = y * fragSizeY + yy;
				zF = z * fragSizeZ + zz;

				xL -= hx;
				yB -= hy;
				zF -= hx;

				red = patternLib[22].color.r * abs(patternLib[22].colormap - cstate);
				green = patternLib[22].color.g * abs(patternLib[22].colormap - cstate);
				blue = patternLib[22].color.b * abs(patternLib[22].colormap - cstate);
				alpha = patternLib[22].alpha * abs(patternLib[22].alphamap - cstate);

				drawPoint(xL, yB, zF, 2.0);
			}

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

	if (ptrWorld->ruleType() == CONT || cstate != 0.0f) {
		if (y%5==0) {

			int i, count;
			float xx, yy;

			if ( (isEven(x) && isEven(z)) || ( !isEven(x) && !isEven(z) ) )
			{
				xL = (x * fragSizeX + (fragSizeX * cosf(cstate * 2.0 * PI))) - (fragSizeX * 2.0 * cosf(cstate * 2.0 * PI));
				yB = (y * fragSizeY + (fragSizeY * sinf(cstate * 2.0 * PI))) - (fragSizeY * 2.0 * sinf(cstate * 2.0 * PI));
			}
			else
			{
				xL = (x * fragSizeX + (fragSizeX * sinf(cstate * 2.0 * PI))) - (fragSizeX * 2.0 * sinf(cstate * 2.0 * PI));
				yB = (y * fragSizeY + (fragSizeY * cosf(cstate * 2.0 * PI))) - (fragSizeX * 2.0 * cosf(cstate * 2.0 * PI));
			}

			zF = z * fragSizeX + (fragSizeX * 0.5);

			xL -= hx;
			yB -= hy;
			zF -= hx;

			red = patternLib[23].color.r * abs(patternLib[23].colormap - cstate);
			green = patternLib[23].color.g * abs(patternLib[23].colormap - cstate);
			blue = patternLib[23].color.b * abs(patternLib[23].colormap - cstate);
			alpha = patternLib[23].alpha * abs(patternLib[23].alphamap - cstate);

			gl::color( red, green, blue, alpha );

			xW = fragSizeX * 2.0;
			yH = fragSizeY * 2.0;
			zD = zF;

			count = 8;

			for (i = 0; i < count; i++) {

				xx = xL + (xW * cosf( (PI*cstate) * (((float)i/(float)count) * (2.0*PI)) ) );
				yy = yB + (yH * sinf( (PI*cstate) * (((float)i/(float)count) * (2.0*PI)) ) );

				drawLine(xL, yB, zF,  xx, yy, zD, 1.0f);

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

			yB += (fragSizeY * 4.0 * sin(cstate * 2 * pi)) - (fragSizeY * 8.0 * sin(cstate * 2 * PI));

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
		float otherstate1, otherstate2, otherstate3, otherstate4;
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

		thetaA = ((2 * pi)/ptrWorld->sizeX() * othercell1->x) + (2 * pi / maxphase * (wrapi(counter, 0, maxphase) / maxphase));
		phiA = ((2 * pi)/ptrWorld->sizeY() * othercell1->y) + (2 * pi / maxphase * (wrapi(counter, 0, maxphase) / maxphase));
		rhoA = othercell1->z * (fragSizeX * 0.5) + (fragSizeX * otherstate1 * 0.5);

		thetaB = ((2 * pi)/ptrWorld->sizeX() * othercell2->x) + (2 * pi / maxphase * (wrapi(counter, 0, maxphase) / maxphase));
		phiB = ((2 * pi)/ptrWorld->sizeY() * othercell2->y) + (2 * pi / maxphase * (wrapi(counter, 0, maxphase) / maxphase));
		rhoB = othercell2->z * (fragSizeX * 0.5) + (fragSizeX * otherstate2* 0.5);

		thetaC = ((2 * pi)/ptrWorld->sizeX() * othercell3->x) + (2 * pi / maxphase * (wrapi(counter, 0, maxphase) / maxphase));
		phiC = ((2 * pi)/ptrWorld->sizeY() * othercell3->y) + (2 * pi / maxphase * (wrapi(counter, 0, maxphase) / maxphase));
		rhoC = othercell3->z * (fragSizeX * 0.5) + (fragSizeX * otherstate3 * 0.5);

		thetaD = ((2 * pi)/ptrWorld->sizeX() * othercell4->x) + (2 * pi / maxphase * (wrapi(counter, 0, maxphase) / maxphase));
		phiD = ((2 * pi)/ptrWorld->sizeY() * othercell4->y) + (2 * pi / maxphase * (wrapi(counter, 0, maxphase) / maxphase));
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

		xL = rhoB * cos( thetaB ) * cos( phiB );
		yB = rhoB * sin( thetaB ) * cos( phiB );
		zF = rhoB * sin( phiB );

		glVertex3f(xL, yB, zF);

		xL = rhoC * cos( thetaC ) * cos( phiC );
		yB = rhoC * sin( thetaC ) * cos( phiC );
		zF = rhoC * sin( phiC );

		glVertex3f(xL, yB, zF);

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
		float otherstate1, otherstate2, otherstate3, otherstate4;
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

		thetaA = ((2 * pi)/ptrWorld->sizeX() * othercell1->x) + (2 * pi / maxphase * (wrapi(counter, 0, maxphase) / maxphase));
		phiA = ((2 * pi)/ptrWorld->sizeY() * othercell1->y) + (2 * pi / maxphase * (wrapi(counter, 0, maxphase) / maxphase));
		rhoA = othercell1->z * (fragSizeX * 0.5) + (fragSizeX * otherstate1 * 0.5);

		thetaB = ((2 * pi)/ptrWorld->sizeX() * othercell2->x) + (2 * pi / maxphase * (wrapi(counter, 0, maxphase) / maxphase));
		phiB = ((2 * pi)/ptrWorld->sizeY() * othercell2->y) + (2 * pi / maxphase * (wrapi(counter, 0, maxphase) / maxphase));
		rhoB = othercell2->z * (fragSizeX * 0.5) + (fragSizeX * otherstate2* 0.5);

		thetaC = ((2 * pi)/ptrWorld->sizeX() * othercell3->x) + (2 * pi / maxphase * (wrapi(counter, 0, maxphase) / maxphase));
		phiC = ((2 * pi)/ptrWorld->sizeY() * othercell3->y) + (2 * pi / maxphase * (wrapi(counter, 0, maxphase) / maxphase));
		rhoC = othercell3->z * (fragSizeX * 0.5) + (fragSizeX * otherstate3 * 0.5);

		thetaD = ((2 * pi)/ptrWorld->sizeX() * othercell4->x) + (2 * pi / maxphase * (wrapi(counter, 0, maxphase) / maxphase));
		phiD = ((2 * pi)/ptrWorld->sizeY() * othercell4->y) + (2 * pi / maxphase * (wrapi(counter, 0, maxphase) / maxphase));
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

		xL = rhoB * cos( thetaB ) * cos( phiB );
		yB = rhoB * sin( thetaB ) * cos( phiB );
		zF = rhoB * sin( phiB );

		glVertex3f(xL, yB, zF);

		xL = rhoC * cos( thetaC ) * cos( phiC );
		yB = rhoC * sin( thetaC ) * cos( phiC );
		zF = rhoC * sin( phiC );

		glVertex3f(xL, yB, zF);

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

		float unmap, cstate, theta, rho, phi;

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

		theta = ((2 * pi)/ptrWorld->sizeX() * x);
		phi = ((2 * pi)/ptrWorld->sizeY() * y);
		rho = z * (fragSizeX * 0.5);

		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

		gl::color(red, green, blue, alpha);
		glEnable(GL_POLYGON_SMOOTH);
		glBegin(GL_POLYGON);

		gl::vertex( Vec3f(xL, yB, zF) );

		theta = ((2 * pi)/ptrWorld->sizeX() * (x - 1));
		phi = ((2 * pi)/ptrWorld->sizeY() * y);

		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

		gl::vertex( Vec3f(xL, yB, zF) );

		theta = ((2 * pi)/ptrWorld->sizeX() * (x - 1));
		phi = ((2 * pi)/ptrWorld->sizeY() * (y - 1));

		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

		gl::vertex( Vec3f(xL, yB, zF) );

		theta = ((2 * pi)/ptrWorld->sizeX() * x);
		phi = ((2 * pi)/ptrWorld->sizeY() * (y - 1));

		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

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

		float unmap, cstate, theta, rho, phi;

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

		theta = ((2 * pi)/ptrWorld->sizeX() * x);
		phi = ((2 * pi)/ptrWorld->sizeY() * y);
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

		theta = ((2 * pi)/ptrWorld->sizeX() * (x - 1));
		phi = ((2 * pi)/ptrWorld->sizeY() * y);

		theta *= mapf(unmap, 0.2, 0.8 );
		phi *= mapf(unmap, 0.2, 0.8 );

		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

		glVertex3f(xL, yB, zF);

		theta = ((2 * pi)/ptrWorld->sizeX() * (x - 1));
		phi = ((2 * pi)/ptrWorld->sizeY() * (y - 1));

		theta *= mapf(unmap, 0.2, 0.8 );
		phi *= mapf(unmap, 0.2, 0.8 );

		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

		glVertex3f(xL, yB, zF);

		theta = ((2 * pi)/ptrWorld->sizeX() * x);
		phi = ((2 * pi)/ptrWorld->sizeY() * (y - 1));

		theta *= mapf(unmap, 0.2, 0.8 );
		phi *= mapf(unmap, 0.2, 0.8 );

		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

		glVertex3f(xL, yB, zF);

		glEnd();
		glDisable(GL_POLYGON_SMOOTH);

	}

}

void GraphicsRenderer::pattern32(int x, int y, int z) {
	if (state > 0.0 && z%4==0) {

		float unmap, cstate, theta, rho, phi;

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

		theta = ((2 * pi)/ptrWorld->sizeX() * x);
		phi = ((2 * pi)/ptrWorld->sizeY() * y);
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

		theta = ((2 * pi)/ptrWorld->sizeX() * (x - 1));
		phi = ((2 * pi)/ptrWorld->sizeY() * y);

		theta *= mapf(unmap, 0.5, 2.0 );
		phi *= mapf(unmap, 0.2, 0.8 );

		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

		glVertex3f(xL, yB, zF);

		theta = ((2 * pi)/ptrWorld->sizeX() * (x - 1));
		phi = ((2 * pi)/ptrWorld->sizeY() * (y - 1));

		theta *= mapf(unmap, 0.5, 2.0 );
		phi *= mapf(unmap, 0.2, 0.8 );

		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

		glVertex3f(xL, yB, zF);

		theta = ((2 * pi)/ptrWorld->sizeX() * x);
		phi = ((2 * pi)/ptrWorld->sizeY() * (y - 1));

		theta *= mapf(unmap, 0.5, 2.0 );
		phi *= mapf(unmap, 0.2, 0.8 );

		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

		glVertex3f(xL, yB, zF);

		theta = ((2 * pi)/ptrWorld->sizeX() * x + 1);
		phi = ((2 * pi)/ptrWorld->sizeY() * y);
		rho += mapf(unmap, fragSizeX*0.5, fragSizeX*2.0);

		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

		glVertex3f(xL, yB, zF);

		phi = ((2 * pi)/ptrWorld->sizeY() * y + 1);

		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

		glVertex3f(xL, yB, zF);

		phi = ((2 * pi)/ptrWorld->sizeY() * x);

		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

		glVertex3f(xL, yB, zF);

		phi = ((2 * pi)/ptrWorld->sizeY() * y);

		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

		glVertex3f(xL, yB, zF);

		glEnd();
		glDisable(GL_POLYGON_SMOOTH);

	}

}

void GraphicsRenderer::pattern33(int x, int y, int z) {
	if (state > 0.0 && x%3==0 && y%3==0 && z%4==0) {

		float unmap, cstate, theta, rho, phi, nunmap;
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

		theta = ((2 * pi)/ptrWorld->sizeX() * x);
		phi = ((2 * pi)/ptrWorld->sizeY() * y);
		rho = z * fragSizeX;

		theta *= mapf(unmap, 0.3, 1.0 );
		phi *= mapf(unmap, 0.3, 1.0 );

		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

		glVertex3f(xL, yB, zF);

		theta = ((2 * pi)/ptrWorld->sizeX() * (x - 1));
		phi = ((2 * pi)/ptrWorld->sizeY() * y);

		theta *= mapf(unmap, 0.3, 1.0 );
		phi *= mapf(unmap, 0.3, 1.0 );

		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

		glVertex3f(xL, yB, zF);

		theta = ((2 * pi)/ptrWorld->sizeX() * (x - 1));
		phi = ((2 * pi)/ptrWorld->sizeY() * (y - 1));

		theta *= mapf(unmap, 0.3, 1.0 );
		phi *= mapf(unmap, 0.3, 1.0 );

		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

		glVertex3f(xL, yB, zF);

		theta = ((2 * pi)/ptrWorld->sizeX() * x);
		phi = ((2 * pi)/ptrWorld->sizeY() * (y - 1));

		theta *= mapf(unmap, 0.3, 1.0 );
		phi *= mapf(unmap, 0.3, 1.0 );

		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

		glVertex3f(xL, yB, zF);

		glEnd();

		glBegin(GL_POLYGON);

		// second structure

		theta = ((2 * pi)/ptrWorld->sizeX() * x);
		phi = ((2 * pi)/ptrWorld->sizeY() * y);
		rho = z * fragSizeX - fragSizeX;

		theta *= mapf(nunmap, 0.3, 1.0 );
		phi *= mapf(nunmap, 0.3, 1.0 );

		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

		glVertex3f(xL, yB, zF);

		theta = ((2 * pi)/ptrWorld->sizeX() * (x - 1));
		phi = ((2 * pi)/ptrWorld->sizeY() * y);

		theta *= mapf(nunmap, 0.3, 1.0 );
		phi *= mapf(nunmap, 0.3, 1.0 );

		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

		glVertex3f(xL, yB, zF);

		theta = ((2 * pi)/ptrWorld->sizeX() * (x - 1));
		phi = ((2 * pi)/ptrWorld->sizeY() * (y - 1));

		theta *= mapf(nunmap, 0.3, 1.0 );
		phi *= mapf(nunmap, 0.3, 1.0 );

		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

		glVertex3f(xL, yB, zF);

		theta = ((2 * pi)/ptrWorld->sizeX() * x);
		phi = ((2 * pi)/ptrWorld->sizeY() * (y - 1));

		theta *= mapf(nunmap, 0.3, 1.0 );
		phi *= mapf(nunmap, 0.3, 1.0 );

		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

		glVertex3f(xL, yB, zF);

		theta = ((2 * pi)/ptrWorld->sizeX() * x);
		phi = ((2 * pi)/ptrWorld->sizeY() * y);
		rho = z * fragSizeX;

		theta *= mapf(unmap, 0.3, 1.0 );
		phi *= mapf(unmap, 0.3, 1.0 );

		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

		glVertex3f(xL, yB, zF);

		theta *= mapf(nunmap, 0.3, 1.0 );
		phi *= mapf(nunmap, 0.3, 1.0 );
		rho = z * fragSizeX - fragSizeX;

		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

		glVertex3f(xL, yB, zF);

		theta = ((2 * pi)/ptrWorld->sizeX() * (x - 1));
		phi = ((2 * pi)/ptrWorld->sizeY() * y);

		theta *= mapf(nunmap, 0.3, 1.0 );
		phi *= mapf(nunmap, 0.3, 1.0 );

		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

		glVertex3f(xL, yB, zF);

		theta = ((2 * pi)/ptrWorld->sizeX() * (x - 1));
		phi = ((2 * pi)/ptrWorld->sizeY() * y);
		rho = z * fragSizeX;

		theta *= mapf(unmap, 0.3, 1.0 );
		phi *= mapf(unmap, 0.3, 1.0 );

		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

		glVertex3f(xL, yB, zF);

		theta = ((2 * pi)/ptrWorld->sizeX() * (x - 1));
		phi = ((2 * pi)/ptrWorld->sizeY() * (y - 1));

		theta *= mapf(nunmap, 0.3, 1.0 );
		phi *= mapf(nunmap, 0.3, 1.0 );

		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

		glVertex3f(xL, yB, zF);

		rho = z * fragSizeX - fragSizeX;

		theta *= mapf(nunmap, 0.3, 1.0 );
		phi *= mapf(nunmap, 0.3, 1.0 );

		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

		glVertex3f(xL, yB, zF);

		theta = ((2 * pi)/ptrWorld->sizeX() * x);
		phi = ((2 * pi)/ptrWorld->sizeY() * (y - 1));

		theta *= mapf(nunmap, 0.3, 1.0 );
		phi *= mapf(nunmap, 0.3, 1.0 );

		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

		glVertex3f(xL, yB, zF);

		rho = z * fragSizeX;

		theta *= mapf(unmap, 0.3, 1.0 );
		phi *= mapf(unmap, 0.3, 1.0 );

		xL = rho * cos( theta ) * cos( phi );
		yB = rho * sin( theta ) * cos( phi );
		zF = rho * sin( phi );

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
			xW = fragSizeX * 0.1;
			yH = fragSizeX * 0.1;
			zD = fragSizeX + mapf(fragSizeX * unmap, 1.0, 4.0);

			gl::drawCube(Vec3f(xL, yB, zF), Vec3f(xW, yH, zD) );

		}

		if (y%5==0)
		{
			xW = fragSizeX + mapf(fragSizeX * unmap, 1.0, 4.0);
			yH = fragSizeX * 0.1;
			zD = fragSizeX * 0.1;

			gl::drawCube(Vec3f(xL, yB, zF), Vec3f(xW, yH, zD) );

		}

		if (z%5==0)
		{
			xW = fragSizeX * 0.1;
			yH = fragSizeX + mapf(fragSizeX * unmap, 1.0, 4.0);
			zD = fragSizeX * 0.1;

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
	float cstate;

	cstate = linexp(state, 0.0, 1.0, 0.1, 1.0);

	xL = ((ptrWorld->sizeX()*fragSizeX/2) - ((float)x * fragSizeX)) * cstate;
	yB = ((ptrWorld->sizeY()*fragSizeY/2) - ((float)y * fragSizeY)) * cstate;
	zF = ((ptrWorld->sizeZ()*fragSizeZ/2) - ((float)z * fragSizeZ)) * cstate;

	xL += ((fragSizeX * 0.5) - (fragSizeX * 2.0 * state));
	yH += ((fragSizeY * 0.5) - (fragSizeY * 2.0 * state));
	zF += ((fragSizeZ * 0.5) - (fragSizeZ * 2.0 * state));

	xW = fragSizeX * state * 4.0;
	yH = fragSizeX * state * 4.0;
	zD = fragSizeZ * state * 4.0;

	//	xL -= hx;
	//	yB -= hx;
	//	zF -= hx;

	red = patternLib[36].color.r * abs(patternLib[36].colormap - cstate);
	green = patternLib[36].color.g * abs(patternLib[36].colormap - cstate);
	blue = patternLib[36].color.b * abs(patternLib[36].colormap - cstate);
	alpha = patternLib[36].alpha * abs(patternLib[36].alphamap - cstate);

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
		xL += (xW * state);
		strokeRect(1, 1.0);
	}
	if (y == ptrWorld->sizeY()-1 && z < ptrWorld->sizeZ()-1 && x < ptrWorld->sizeX()-1) {
		yB += (yH * state);
		strokeRect(2, 1.0);
	}
	if (z == ptrWorld->sizeZ()-1 && x < ptrWorld->sizeX()-1 && y < ptrWorld->sizeY()-1) {
		zF += (zD * state);
		strokeRect(0, 1.0);
	}

}

void GraphicsRenderer::pattern37(int x, int y, int z) {
	float ex, ey, ez, lineWidth, scale;

	if ( x%5==0 && y%6==0 && z%7==0 ) {

		lineWidth = mapf(state, 1.0, 4.0);

		scale = 2.0;

		hx = fragSizeX * ptrWorld->sizeX() * 0.5;

		xL = ((ptrWorld->sizeX()*fragSizeX/2) - ((float)x * fragSizeX)) * state * 2.0 + (fragSizeX * 0.5);
		yB = ((ptrWorld->sizeY()*fragSizeY/2) - ((float)y * fragSizeY)) * state * 2.0 + (fragSizeY * 0.5);
		zF = ((ptrWorld->sizeZ()*fragSizeZ/2) - ((float)z * fragSizeZ)) * state * 2.0 + (fragSizeZ * 0.5);

		xW = fragSizeX * state * 2.0;
		yH = fragSizeX * state;
		zD = fragSizeX * state;

		ex = fragSizeX * 4.0 * sinf( (state * 2.0 * PI) );
		ey = fragSizeX * 2.0 * cosf( (state * 2.0 * PI) );
		ez = fragSizeX * 2.0 * sinf( (state * 2.0 * PI) );

		red = patternLib[33].color.r * abs(patternLib[33].colormap - state);
		green = patternLib[33].color.g * abs(patternLib[33].colormap - state);
		blue = patternLib[33].color.b * abs(patternLib[33].colormap - state);
		alpha = patternLib[33].alpha * abs(patternLib[33].alphamap - state);

		gl::color(red, green, blue, alpha);

		gl::drawCube( Vec3f(xL, yB, zF), Vec3f( ex, ey, ez ) );

	}

	if ( (x-2)%6==0 && (z-2)%7==0 && (y-2)%5==0 ) {

		lineWidth = mapf(state, 1.0, 4.0);

		scale = 2.0;

		hx = fragSizeX * ptrWorld->sizeX() * 0.5;

		xL = ((ptrWorld->sizeX()*fragSizeX/2) - ((float)x * fragSizeX)) * state * 2.0 + (fragSizeX * 0.5);
		yB = ((ptrWorld->sizeY()*fragSizeY/2) - ((float)y * fragSizeY)) * state * 2.0 + (fragSizeY * 0.5);
		zF = ((ptrWorld->sizeZ()*fragSizeZ/2) - ((float)z * fragSizeZ)) * state * 2.0 + (fragSizeZ * 0.5);

		xW = fragSizeX * state;
		yH = fragSizeX * state * 2.0;
		zD = fragSizeX * state;

		ex = fragSizeX * 2.0 * sinf( (state * 2.0 * PI) );
		ey = fragSizeX * 4.0 * sinf( (state * 2.0 * PI) );
		ez = fragSizeX * 2.0 * cosf( (state * 2.0 * PI) );

		red = patternLib[33].color.r * abs(patternLib[33].colormap - state);
		green = patternLib[33].color.g * abs(patternLib[33].colormap - state);
		blue = patternLib[33].color.b * abs(patternLib[33].colormap - state);
		alpha = patternLib[33].alpha * abs(patternLib[33].alphamap - state);

		gl::color(red, green, blue, alpha);

		gl::drawCube( Vec3f(xL, yB, zF), Vec3f( ex, ey, ez ) );

	}

	if ( y%7==0 && z%5==0 && z%6==0 ) {

		lineWidth = mapf(state, 1.0, 4.0);

		scale = 2.0;

		hx = fragSizeX * ptrWorld->sizeX() * 0.5;

		xL = ((ptrWorld->sizeX()*fragSizeX/2) - ((float)x * fragSizeX)) * state * 2.0 + (fragSizeX * 0.5);
		yB = ((ptrWorld->sizeY()*fragSizeY/2) - ((float)y * fragSizeY)) * state * 2.0 + (fragSizeY * 0.5);
		zF = ((ptrWorld->sizeZ()*fragSizeZ/2) - ((float)z * fragSizeZ)) * state * 2.0 + (fragSizeZ * 0.5);

		xW = fragSizeX * state;
		yH = fragSizeX * state;
		zD = fragSizeX * state * 2.0;

		ex = fragSizeX * 2.0 * cosf( (state * 2.0 * PI) );
		ey = fragSizeX * 2.0 * sinf( (state * 2.0 * PI) );
		ez = fragSizeX * 4.0 * sinf( (state * 2.0 * PI) );

		red = patternLib[33].color.r * abs(patternLib[33].colormap - state);
		green = patternLib[33].color.g * abs(patternLib[33].colormap - state);
		blue = patternLib[33].color.b * abs(patternLib[33].colormap - state);
		alpha = patternLib[33].alpha * abs(patternLib[33].alphamap - state);

		gl::color(red, green, blue, alpha);

		gl::drawCube( Vec3f(xL, yB, zF), Vec3f( ex, ey, ez ) );

	}

}

void GraphicsRenderer::pattern38(int x, int y, int z) {
	if (x%7==0 && y%5==0 && z%7==0) {

		xL = ((ptrWorld->sizeX()*fragSizeX/2) - ((float)x * fragSizeX)) * state + (fragSizeX * 2.0 * sinf(state * 4.0 * PI));
		yB = ((ptrWorld->sizeY()*fragSizeY/2) - ((float)y * fragSizeY)) * state + (fragSizeX * 2.0 * cosf(state * 4.0 * PI));
		zF = ((ptrWorld->sizeZ()*fragSizeZ/2) - ((float)z * fragSizeZ)) * state + (fragSizeX * 0.5);

		red = patternLib[34].color.r * abs(patternLib[34].colormap - state);
		green = patternLib[34].color.g * abs(patternLib[34].colormap - state);
		blue = patternLib[34].color.b * abs(patternLib[34].colormap - state);
		alpha = patternLib[34].alpha * abs(patternLib[34].alphamap - state);

		drawPoint(xL, yB, zF, 5.0);

		for (int i=0; i < currentCell->history.size(); i++) {
			double oldState;
			oldState = currentCell->history[i];
			red *= 0.8;
			green *= 0.9;
			blue *= 0.9;
			alpha *= 0.95;

			xL = ((ptrWorld->sizeX()*fragSizeX/2) - ((float)x * fragSizeX)) * state + (fragSizeX * 2.0 * sinf(oldState * 4.0 * PI));
			yB = ((ptrWorld->sizeY()*fragSizeY/2) - ((float)y * fragSizeY)) * state + (fragSizeX * 2.0 * cosf(oldState * 4.0 * PI));
			zF = ((ptrWorld->sizeZ()*fragSizeZ/2) - ((float)z * fragSizeZ)) * state + (fragSizeX * 0.5);

			drawPoint(xL, yB, zF, 2.0);

		}
	}

	if (x%5==0 && y%7==0 && z%7==0) {

		xL = ((ptrWorld->sizeX()*fragSizeX/2) - ((float)x * fragSizeX)) * state + (fragSizeX * 0.5);
		yB = ((ptrWorld->sizeY()*fragSizeY/2) - ((float)y * fragSizeY)) * state + (fragSizeX * 2.0 * sinf(state * 4.0 * PI));
		zF = ((ptrWorld->sizeZ()*fragSizeZ/2) - ((float)z * fragSizeZ)) * state + (fragSizeX * 2.0 * cosf(state * 4.0 * PI));

		red = patternLib[34].color.r * abs(patternLib[34].colormap - state);
		green = patternLib[34].color.g * abs(patternLib[34].colormap - state);
		blue = patternLib[34].color.b * abs(patternLib[34].colormap - state);
		alpha = patternLib[34].alpha * abs(patternLib[34].alphamap - state);

		drawPoint(xL, yB, zF, 5.0);

		for (int i=0; i < currentCell->history.size(); i++) {
			double oldState;
			oldState = currentCell->history[i];
			red *= 0.8;
			green *= 0.9;
			blue *= 0.9;
			alpha *= 0.95;

			xL = ((ptrWorld->sizeX()*fragSizeX/2) - ((float)x * fragSizeX)) * state + (fragSizeX * 0.5);
			yB = ((ptrWorld->sizeY()*fragSizeY/2) - ((float)y * fragSizeY)) * state + (fragSizeX * 2.0 * sinf(oldState * 4.0 * PI));
			zF = ((ptrWorld->sizeZ()*fragSizeZ/2) - ((float)z * fragSizeZ)) * state + (fragSizeX * 2.0 * cosf(oldState * 4.0 * PI));

			drawPoint(xL, yB, zF, 2.0);

		}
	}

	if (x%7==0 && y%7==0 && z%5==0) {

		xL = ((ptrWorld->sizeX()*fragSizeX/2) - ((float)x * fragSizeX)) * state + (fragSizeX * 2.0 * cosf(state * 4.0 * PI));
		yB = ((ptrWorld->sizeY()*fragSizeY/2) - ((float)y * fragSizeY)) * state + (fragSizeX * 0.5);
		zF = ((ptrWorld->sizeZ()*fragSizeZ/2) - ((float)z * fragSizeZ)) * state + (fragSizeX * 2.0 * sinf(state * 4.0 * PI));

		red = patternLib[34].color.r * abs(patternLib[34].colormap - state);
		green = patternLib[34].color.g * abs(patternLib[34].colormap - state);
		blue = patternLib[34].color.b * abs(patternLib[34].colormap - state);
		alpha = patternLib[34].alpha * abs(patternLib[34].alphamap - state);

		drawPoint(xL, yB, zF, 5.0);

		for (int i=0; i < currentCell->history.size(); i++) {
			double oldState;
			oldState = currentCell->history[i];
			red *= 0.8;
			green *= 0.9;
			blue *= 0.9;
			alpha *= 0.95;

			xL = ((ptrWorld->sizeX()*fragSizeX/2) - ((float)x * fragSizeX)) * state + (fragSizeX * 2.0 * cosf(oldState * 4.0 * PI));
			yB = ((ptrWorld->sizeY()*fragSizeY/2) - ((float)y * fragSizeY)) * state + (fragSizeX * 0.5);
			zF = ((ptrWorld->sizeZ()*fragSizeZ/2) - ((float)z * fragSizeZ)) * state + (fragSizeX * 2.0 * sinf(oldState * 4.0 * PI));

			drawPoint(xL, yB, zF, 2.0);

		}
	}

}

void GraphicsRenderer::pattern39(int x, int y, int z) {
	xL = ((ptrWorld->sizeX()*fragSizeX/2) - ((float)x * fragSizeX)) * state + (fragSizeX * 0.5) - (fragSizeX * 2.0 * state);
	yB = ((ptrWorld->sizeY()*fragSizeX/2) - ((float)y * fragSizeY)) * state + (fragSizeY * 0.5) - (fragSizeY * 2.0 * state);
	zF = ((ptrWorld->sizeZ()*fragSizeX/2) - ((float)z * fragSizeZ)) * state + (fragSizeZ * 0.5) - (fragSizeZ * 2.0 * state);

	xW = mapf(fragSizeX * state, 0.5, 2.0);
	yH = mapf(fragSizeX * state, 0.5, 2.0);
	zD = mapf(fragSizeX * state, 0.5, 2.0);

	red = patternLib[35].color.r * abs(patternLib[35].colormap - state);
	green = patternLib[35].color.g * abs(patternLib[35].colormap - state);
	blue = patternLib[35].color.b * abs(patternLib[35].colormap - state);
	alpha = patternLib[35].alpha * abs(patternLib[35].alphamap - state);

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
	theta = 2 * pi / num_segments;
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

