/*
 *  codepanel.cpp
 *  lambdaApp
 *
 *  Created by alo on 10/08/2012.
 *  
 *	This file is part of lambdaApp.
 *
 *	lambdaApp is free software: you can redistribute it and/or modify
 *	it under the terms of the GNU General Public License as published by
 *	the Free Software Foundation, either version 3 of the License, or
 *	(at your option) any later version.
 
 *	lambdaApp is distributed in the hope that it will be useful,
 *	but WITHOUT ANY WARRANTY; without even the implied warranty of
 *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *	GNU General Public License for more details.
 
 *	You should have received a copy of the GNU General Public License
 *	along with lambdaApp.  If not, see <http://www.gnu.org/licenses/>. 
 *
 */

#include "codepanel.h"

#include "cinder/Text.h"
#include "cinder/gl/Texture.h"

using namespace ci;

CodePanel::CodePanel()
{
	state = true;
	opacity	= 1.0f;
	fadeTime = 300;
	maxLines = 10;
}

void CodePanel::createTexture()
{
	TextLayout layout;
	layout.setFont( Font("Inconsolata", 14) );
	layout.setColor( Color(0.5f, 0.5f, 0.5f) );
	layout.addLine( "sc.sparsematrix" );
	
	layout.setFont(Font("Inconsolata", 10));
	layout.setColor(Color(0.4f, 0.4f, 0.5f));
	layout.addLine("-------------------------------------------------------------------------------------");	

	lines.push_back("λ ~graphics.initWorld(32, 32, 8, 2000, 0.1)");
	lines.push_back("λ ~graphics.sendPresetRule('faders')");
	lines.push_back("λ ~graphics.changeSetting('rule', 1)");
	lines.push_back("λ ~ctrls01.do({|ctr| ");
	lines.push_back("	ctr.active = [0, 1].wchoose([0.3, 0.7]);");
	lines.push_back("	ctr.amp = rrand(0.7, 1.5); ");
	lines.push_back("	ctr['dur'] = rrand(0.01, 0.3);");
	lines.push_back("});");	
	
	for (int i = 0; i < lines.size(); i++) {
		layout.addLine(lines[i]);
	}
	
//	layout.addLine("λ ~ciapp.setPattern(1, 0, 1.0, 1, 1)");
//	layout.addLine("λ ['kpanilogo', 'yole', 'diansa', 'sorsornet'].do({|name|");
//	layout.addLine("	~combined = ~combined ++ SparsePattern(~allPatterns[name]).makeSparse.patterns;");
//	layout.addLine("});");
//	layout.addLine("λ ~setBPM.(bpm);");
//	layout.addLine("λ Pdef('player', Ppar([ Pdef('rhythm'), Pdef('efx') ]));");
//	layout.addLine("λ ~groups.flat.do({|name|");
//	layout.addLine("	~ctrls[name].active = [0, 1].wchoose([0.2, 0.8]);");
//	layout.addLine("	~ctrls[name].dur = rrand(0.02, 0.3);");
//	layout.addLine("	~ctrls[name].amp = rrand(0.06, 0.7);");		
//	layout.addLine("});");
		
	texture = gl::Texture( layout.render( true ) );
}

void CodePanel::update( Vec2f dim, float counter )
{
	if( state ){
		if( counter == fadeTime ){
			toggleState();
		}
		opacity -= ( opacity - 1.0f ) * 0.1f;
	} else {
		opacity -= ( opacity - 0.0f ) * 0.1f;	
	}
	
	if( opacity > 0.01f ){
		render( dim );
	}
}

void CodePanel::render( Vec2f dim )
{
	float x = dim.x - texture.getWidth() - 40.0f;
	float y = dim.y - texture.getHeight() - 25.0f;
	glColor4f( 1, 1, 1, opacity );
	gl::draw( texture, Vec2f( x, y ) );
}


void CodePanel::toggleState()
{
	state = ! state;
}

