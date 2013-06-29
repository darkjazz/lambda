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
#include "util.h"

using namespace ci;

CodePanel::CodePanel()
{
	show = false;
	opacity	= 0.0f;
	fadeTime = 300;
	maxLines = 32;
	counter = 0;
	title = "sc.code";
}

void CodePanel::createTexture()
{
	TextLayout layout;
	layout.setFont( Font("Arial Black", 14) );
	layout.setColor( Color(0.5f, 0.5f, 0.5f) );
	layout.addLine( title );
	
	layout.setFont(Font("Inconsolata", 14));
	layout.setColor(Color(0.8f, 0.8f, 0.8f));
	layout.addLine("------------------------------------------------------------------------------------------");	
		
	for (int i = lines.size() - 1; i >= 0; i--) {
		layout.addLine(lines[i]);
	}
			
	texture = gl::Texture( layout.render( true ) );
}

void CodePanel::update( Vec2f dim )
{
	if( show ){
		if( counter == fadeTime ){
			show = false;
		}
		else {
			opacity = clipf(opacity+0.2f, 0.0f, 1.0f);
			counter++;
		}
	} else {
		opacity = clipf(opacity-0.05f, 0.0f, 1.0f);
	}
	
	if( opacity > 0.05f ){
		render( dim );
	}

}

void CodePanel::render( Vec2f dim )
{
	createTexture();
	float x = dim.x - texture.getWidth() - 40.0f;
	float y = dim.y - texture.getHeight() - 25.0f;
	glColor4f( 1, 1, 1, opacity );
	gl::draw( texture, Vec2f( x, y ) );
}

void CodePanel::bind() 
{
	if( show ){
		if( counter == fadeTime ){
			show = false;
		}
		else {
			opacity = clipf(opacity+0.2f, 0.0f, 1.0f);
			counter++;
		}
	} else {
		opacity = clipf(opacity-0.05f, 0.0f, 1.0f);
	}
	
	createTexture();
	
	texture.bind();
}

void CodePanel::unbind() 
{
	texture.unbind();
}

void CodePanel::addLine(string line) {
	
	show = true;
	counter = 0;
	
	vector<string>::iterator it;

	if (lines.size() >= maxLines) {
		lines.pop_back();
	}
	
	it = lines.begin();
	lines.insert(it, line);
	
}