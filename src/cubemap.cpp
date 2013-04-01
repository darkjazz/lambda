/*
 *  cubemap.cpp
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

#include "cubemap.h"

#ifndef	CUBEMAP_H
#define CUBEMAP_H

using ci::Surface8u;
using boost::shared_ptr;

CubeMap::CubeMap( GLsizei texWidth, GLsizei texHeight, const Surface8u &pos_x, const Surface8u &pos_y, const Surface8u &pos_z, const Surface8u &neg_x, const Surface8u &neg_y, const Surface8u &neg_z, GLenum format )
{	
	glGenTextures(1, &textureObject);
	glBindTexture(GL_TEXTURE_CUBE_MAP_ARB, textureObject);

	glTexImage2D(GL_TEXTURE_CUBE_MAP_POSITIVE_X_ARB, 0, GL_RGBA, texWidth, texHeight, 0, format, GL_UNSIGNED_BYTE, pos_x.getData());
	glTexImage2D(GL_TEXTURE_CUBE_MAP_NEGATIVE_X_ARB, 0, GL_RGBA, texWidth, texHeight, 0, format, GL_UNSIGNED_BYTE, neg_x.getData());
	glTexImage2D(GL_TEXTURE_CUBE_MAP_POSITIVE_Y_ARB, 0, GL_RGBA, texWidth, texHeight, 0, format, GL_UNSIGNED_BYTE, pos_y.getData());
	glTexImage2D(GL_TEXTURE_CUBE_MAP_NEGATIVE_Y_ARB, 0, GL_RGBA, texWidth, texHeight, 0, format, GL_UNSIGNED_BYTE, neg_y.getData());
	glTexImage2D(GL_TEXTURE_CUBE_MAP_POSITIVE_Z_ARB, 0, GL_RGBA, texWidth, texHeight, 0, format, GL_UNSIGNED_BYTE, pos_z.getData());
	glTexImage2D(GL_TEXTURE_CUBE_MAP_NEGATIVE_Z_ARB, 0, GL_RGBA, texWidth, texHeight, 0, format, GL_UNSIGNED_BYTE, neg_z.getData());

	glTexParameteri(GL_TEXTURE_CUBE_MAP_ARB, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	glTexParameteri(GL_TEXTURE_CUBE_MAP_ARB, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
}

void CubeMap::bindMulti( int pos )
{
	glActiveTexture(GL_TEXTURE0 + pos );
	glBindTexture(GL_TEXTURE_CUBE_MAP_ARB, textureObject);
}

void CubeMap::bind()
{
	glBindTexture(GL_TEXTURE_CUBE_MAP_ARB, textureObject);
}

void CubeMap::unbind()
{
	glBindTexture(GL_TEXTURE_CUBE_MAP_ARB, 0 );
	glActiveTexture(GL_TEXTURE0);
}



#endif
