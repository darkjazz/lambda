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

/* ****** WORLD ****** */

World::World () {

	_index = 0;
	
	_alive = 0;
	
	cells = NULL;
	
	_rule = NULL;
	
	_updateStates = false;
	
	_interpType = NONE;
	
	_interpPhase = 0;
	
	_interpCount = 1;
	
	_bQueryStates = false;
	
}

World::World (int sizeX, int sizeY, int sizeZ) {
	
	_index = 0;
	
	_alive = 0;
	
	cells = NULL;
	
	_rule = NULL;

	_updateStates = false;

	_interpType = NONE;
	
	_interpPhase = 0;
	
	_interpCount = 1;

	_bQueryStates = false;

	this->init(sizeX, sizeY, sizeZ);
}

World::~World() {
	this->clear();
}

void World::init(int sizeX, int sizeY, int sizeZ) {
	int x, y, z, i;
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
					cells[x][y][z].states[i] = 0.0;
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

double World::cellState(int x, int y, int z) { return cells[x][y][z].states[_index]; }

void World::incrementIndex() { 
	_index = wrapi(_index + 1, 0, 2); 
	_interpPhase = 0;
}

void World::initRandInArea(int left, int bottom, int front, int width, int height, int depth, int maxState, float weight, bool includeAllStates) {
	
	int x, y, z, i;
	double state;
	float coin;
	
	for (x = left; x < (left + width); x++) {
		for(y = bottom; y < (bottom + height); y++) {
			for(z = front; z < (front + depth); z++) {
				coin = randf();
				if (coin >= weight) {
					if ( includeAllStates && maxState > 2 )
					{	state = (double)randfloat(1.0, (float)(maxState - 1)); }
					else
					{	state = 1.0; }
					_alive++;
				}
				else {
					state = 0.0;
				}
				for (i = 0; i < 3; i++) {
					cells[x][y][z].states[i] = state;
				}
			}
		}
	}
	
}

void World::initWireCube(int left, int bottom, int front, int width, int height, int depth) {
	
	int x, y, z, i;
	double state;
	
	for (x = left; x <= (left + width); x++) {
		for(y = bottom; y <= (bottom + height); y++) {
			for(z = front; z <= (front + depth); z++) {
				if (x == left || x == (left + width) || y == bottom || y == (bottom + height) || z == front || z == (front + depth)) {
					state = 1.0;
					_alive++;
				}
				else
				{
					state = 0.0;
				}
				for (i = 0; i < 3; i++) {
					cells[x][y][z].states[i] = state;
				}
			}
		}
	}
	
}

void World::incrementAlive() { _alive++; }

void World::resetAlive() { _alive = 0; }

void World::initRule(R r) {
	N dim;
	
	dim.x = _sizeX;
	dim.y = _sizeY;
	dim.z = _sizeZ;
	
	switch (r) {
		case CONT:
			_rule = new Continuous(dim);
			break;
		case LIFE: 
			_rule = new Life(dim);
			break;
		default:
			_rule = new Faders(dim);
			break;
	}
	
	_rule->world = cells;
}

void::World::prepareNext() {
	
	if (_interpPhase == _interpCount) {
		incrementIndex();
		_updateStates = true;
	}
	else {
		_updateStates = false;
	}
	
	_interpPhase++;
	
	_currentQueryIndex = 0;
	
}

void World::next(int x, int y, int z) { 
	
	if (_updateStates) {
		_rule->next(&cells[x][y][z], _index);		
	}
	
	interpolate(x, y, z);
	
	if (_bQueryStates) {
		if (_queryStates[_currentQueryIndex].include(x, y, z)) {
			_queryStates[_currentQueryIndex].value = cells[x][y][z].states[_index];
			_currentQueryIndex++;
		}
	}
}

void World::finalizeNext() {}

void World::interpolate(int x, int y, int z) {
	Cell * cell;
	cell = &cells[x][y][z];
	
	if (_interpCount < 1) _interpCount = 1;
	
	switch (_interpType) {
		case LINEAR:
			cell->phase = linInterp(cell->states[wrapi(_index - 1, 0, 2)], cell->states[_index], _interpPhase / _interpCount);
			break;
		case COSINE:
			cell->phase = cosInterp(cell->states[wrapi(_index - 1, 0, 2)], cell->states[_index], _interpPhase / _interpCount);
			break;
		default:
			cell->phase = cell->states[_index];
			break;
	}
	
}

void World::setInterpolation(Interpolation itype, int icount) {
	_interpType = itype; 
	_interpCount = icount; 
	_interpPhase = 0;
}

void World::mapStates() {
	
	int x, y, z;
	double state;
	
	for (x = 0; x < _sizeX; x++) {
		for (y = 0; y < _sizeY; y++) {
			for (z = 0; z < _sizeZ; z++) {
				state = cells[x][y][z].states[_index];
				state = _rule->mapState(state);
				
				cells[x][y][z].states[0] = state;
				cells[x][y][z].states[1] = state;
				cells[x][y][z].states[2] = state;
			}
		}
	}
	
}

void World::setQueryIndices(int * indices, int size) {
	int i;
	_queryStates.clear();
	_queryStatesSize = size / 3;
	for (i=0; i<size; i+=3) {
		_queryStates.push_back( State(indices[i], indices[i+1], indices[i+2], i/3 ) );
	}
	_bQueryStates = true;
	
};

