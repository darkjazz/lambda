/*
 *  world.cpp
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

#include "world.h"

/* ****** CELL ****** */

int Cell::countAliveNeighbors(int stateIndex) {
	int count, i;
	count = 0;
	for (i = 0; i < 26; i++) {
		if (neighbors[i]->istates[stateIndex] == 1) {
			count++;
		}
	}
	return count;
}

/* ****** WORLD ****** */

World::World () {

	_index = 0;
	
	_alive = 0;
	
	cells = NULL;
	
}

World::World (int sizeX, int sizeY, int sizeZ) {
	_sizeX = sizeX; _sizeY = sizeY; _sizeZ = sizeZ;
	
	_index = 0;
	
	_alive = 0;
	
	cells = NULL;
	
	this->init(sizeX, sizeY, sizeZ);
}

World::~World() {
	this->clear();
}

void World::init(int sizeX, int sizeY, int sizeZ) {
	int x, y, z, i;
	int xx, yy, zz, ind;
	double state;

	_sizeX = sizeX; _sizeY = sizeY; _sizeZ = sizeZ;

	this->clear();
		
	cells = new Cell**[_sizeX];
	assert(cells);
	for (x = 0; x < _sizeX; x++) {
		cells[x] = new Cell*[_sizeY];
		assert(cells[x]);
		for (y = 0; y < _sizeY; y++) {
			cells[x][y] = new Cell[_sizeZ];
			assert(cells[x][y]);
			
			for (z = 0; z < _sizeZ; z++)
			{
				cells[x][y][z].x = x;
				cells[x][y][z].y = y;
				cells[x][y][z].z = z;			
				state = 0;
				for (i = 0; i < 3; i++) {
					cells[x][y][z].istates[i] = 0;			
				}
			}
						
		}
	}
	
	// set neighborhood

	for (x = 0; x < _sizeX; x++) {
		for (y = 0; y < _sizeY; y++) {
			if (_sizeZ > 1) {
				for (z = 0; z < _sizeZ; z++) {
					delete [] cells[x][y][z].neighbors;
					cells[x][y][z].neighbors = new Cell*[26];
					ind = 0;
					for(xx = -1; xx <= 1; xx++) {
						for(yy = -1; yy <= 1; yy++) {
							for (zz = -1; zz <= 1; zz++) {
								if (!(xx==0 && yy==0 && zz==0)) {
									cells[x][y][z].neighbors[ind] = &(cells[wrapi(x+xx, 0, _sizeX - 1)][wrapi(y+yy, 0, _sizeY - 1)][wrapi(z+zz, 0, _sizeZ - 1)]);
									ind++;
								}
							}
						}
					}
				}
			}
			else
			{
				delete [] cells[x][y][0].neighbors;
				cells[x][y][0].neighbors = new Cell*[8];
				ind = 0;
				for(xx = -1; xx <= 1; xx++) {
					for(yy = -1; yy <= 1; yy++) {
						if (!(xx==0 && yy==0)) {
							cells[x][y][0].neighbors[ind] = &(cells[wrapi(x+xx, 0, _sizeX - 1)][wrapi(y+yy, 0, _sizeY - 1)][0]);
							ind++;
						}
					}
				}

			}
		}
	}
}

void World::clear (void) {
	int x, y;
	if (cells) {
		for (x = 0; x < _sizeX; x++) {
		
			for (y = 0; y < _sizeY; y++) {
				if (cells[x][y]) {
					delete [] cells[x][y];
					cells[x][y] = NULL;
				}
			}
			
			delete [] cells[x];
			cells[x] = NULL;
			
		}
		delete [] cells; 
		cells = NULL;
	}
}

double World::cellState(int x, int y, int z) { return cells[x][y][z].istates[_index]; }

void World::nextIndex() { _index = wrapi(_index + 1, 0, 2); }

void World::initRandInArea(int left, int bottom, int front, int width, int height, int depth, int maxState, float weight, bool includeAllStates) {
	
	int x, y, z, i, state;
	float coin;
	
	for (x = left; x < (left + width); x++) {
		for(y = bottom; y < (bottom + height); y++) {
			for(z = front; z < (front + depth); z++) {
				coin = randf();
				if (coin >= weight) {
					if ( includeAllStates && maxState > 2 )
					{	state = (int)randfloat(1.0, (float)(maxState - 1)); }
					else
					{	state = 1; }
					_alive++;
				}
				else {
					state = 0;
				}
				for (i = 0; i < 3; i++) {
					cells[x][y][z].istates[i] = state;
				}
			}
		}
	}
	
}

void World::initWireCube(int left, int bottom, int front, int width, int height, int depth) {
	
	int x, y, z, i, state;
	
	for (x = left; x <= (left + width); x++) {
		for(y = bottom; y <= (bottom + height); y++) {
			for(z = front; z <= (front + depth); z++) {
				if (x == left || x == (left + width) || y == bottom || y == (bottom + height) || z == front || z == (front + depth)) {
					state = 1;
					_alive++;
				}
				else
				{
					state = 0;
				}
				for (i = 0; i < 3; i++) {
					cells[x][y][z].istates[i] = state;
				}
			}
		}
	}
	
}

void World::incrementAlive() { _alive++; }

void World::resetAlive() { _alive = 0; }

void World::initRule(R r) {
	switch (r) {
		case CONT:
			_rule = new Continuous();
			break;
		case LIFE: 
			_rule = new Life();
			break;
		default:
			_rule = new Faders();
			break;
	}
}
