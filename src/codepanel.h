/*
 *  codepanel.h
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

#pragma once

#include "cinder/Vector.h"
#include "cinder/gl/Texture.h"

#include <vector>

using namespace std;

class CodePanel {
public:
	CodePanel();
	void createTexture();
	void update( ci::Vec2f );
	void render( ci::Vec2f );
	void addLine( string );
	
	ci::Vec2f loc;
	
	float opacity;
	bool show;
	int fadeTime, maxLines, counter;			
	ci::gl::Texture	texture; 
	
	vector<string> lines;
	
private:
	void makeHeader();
	
};