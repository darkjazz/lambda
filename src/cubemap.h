/*
 *  cubemap.h
 *  lambdaApp
 *
 *  Created by alo on 19/07/2012.
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

#include "cinder/Surface.h"
#include "cinder/gl/gl.h"
#include "cinder/ImageIo.h"
#include "cinder/gl/Texture.h"

class CubeMap
{
	unsigned int textureObject;	
public:
	//this should be overloaded or generalized to allow different types of texture inputs
	CubeMap( GLsizei texWidth, GLsizei texHeight, const ci::Surface8u &pos_x, const ci::Surface8u &pos_y, const ci::Surface8u &pos_z, const ci::Surface8u &neg_x, const ci::Surface8u &neg_y, const ci::Surface8u &neg_z, GLenum format );
	void bind();
	void bindMulti( int loc );
	void unbind();
};