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
	this->initVars();	
}

World::World (int sizeX, int sizeY, int sizeZ, int vectorSize) {
	this->initVars();
    this->init(sizeX, sizeY, sizeZ, vectorSize);
}

World::~World() {
	this->clear();
}

void World::initVars() {
	_index = 0;
	_alive = 0;
	cells = NULL;
	_rule = NULL;
	_updateStates = false;
	_interpType = NONE;
	_interpPhase = 0;
	_interpCount = 1;
	_bQueryStates = false;
    _bQueryCoords = false;
	_cellHistorySize = 8;
	_trainDur = 1000;
	_trainCount = 0;
	_learningRate = _initLearningRate = 0.1;
	_inputVectorUpdated = false;
	_newBMUFound = false;
	_bmu = NULL;
	_bestMatchCoords.x = 0;
	_bestMatchCoords.y = 0;
	_bestMatchCoords.z = 0;
	_bestMatchHistorySize = 30;
	
	cellsInitialized = false;
	ruleInitialized = false;
	somActivated = false;
	
	symmetry = ZERO;
}

void World::init(int sizeX, int sizeY, int sizeZ, int vectorSize) {
	int x, y, z, i;
	double state;

	_trainCount = 0;
	_inputVectorUpdated = false;
	_newBMUFound = false;
	cellsInitialized = false;
	ruleInitialized = false;
	somActivated = false;	

	_sizeX = sizeX; _sizeY = sizeY; _sizeZ = sizeZ; _vectorSize = vectorSize;

	this->clear();

	_mapRadius = (double)max(max(_sizeX, _sizeY), _sizeZ) / 2.0;
	_timeConst = ((double)_trainDur / logf(_mapRadius));

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
				for (i = 0; i < _cellHistorySize; i++) {
					cells[x][y][z].history.push_back(state);
				}
				if (_vectorSize > 1) {
					for (i = 0; i < _vectorSize; i++) {
						cells[x][y][z].weights.push_back(randd());
					}
				}
			}						
		}
	}
	
	_bmu = &cells[_sizeX/2][_sizeY/2][_sizeZ/2];
	
	cellsInitialized = true;
	
			
}



void World::clear (void) {
	int x, y;
	
	cellsInitialized = false;

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

int World::interpPhase() { return _interpPhase; }

int World::interpCount() { return _interpCount; }

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
	
	_ruleType = r;
	
	_rule->world = cells;
	
	ruleInitialized = true;
}

void::World::prepareNext() {
	
	if (_interpPhase == _interpCount) {
		incrementIndex();
		_updateStates = true;
	}
	else {
		_interpPhase++;
	}
	
	if (_inputVectorUpdated) {
		_bestMatch = 10.0;
	}
		
	_currentQueryIndex = 0;
	
	if (somActivated) {
		if (_trainCount < _trainDur) {
			_tRadius = _mapRadius * exp(_trainCount / (_timeConst*-1.0));
		}
	}
    if (_bQueryCoords) {
        _queryFaderStates.clear();
    }
}

void World::next(int x, int y, int z) { 
		
	if (_updateStates) {
		_rule->next(&cells[x][y][z], _index);		
	}
	else {
		double previousState;
		vector<double>::iterator it;
		previousState = cells[x][y][z].phase;
		
		interpolate(x, y, z);
		
		if (cells[x][y][z].history.size() >= _cellHistorySize) {
			cells[x][y][z].history.pop_back();			
		}
		
		it = cells[x][y][z].history.begin();
		cells[x][y][z].history.insert(it, previousState);		
		
	}
	
		
	if (_bQueryStates) {
        
        if (_queryStates[_currentQueryIndex].include(x, y, z)) {
            if (ruleType() == CONT)
                _queryStates[_currentQueryIndex].value = cells[x][y][z].states[_index];
            else
                _queryStates[_currentQueryIndex].intvalue = cells[x][y][z].states[_index];
            _currentQueryIndex++;
        }
	}
    
    if (_bQueryCoords) {
        if ((int)cells[x][y][z].states[_index] >= _queryMinState && (int)cells[x][y][z].states[_index] <= _queryMaxState) {
            _queryFaderStates.push_back( (int)((x*_sizeX+y)*_sizeY+z) );
            _queryFaderStates.push_back( (int)cells[x][y][z].states[_index] );
        }
    }
	
}

void World::finalizeNext() {
	_updateStates = false;
	if (_newBMUFound) {
		_newBMUFound = false;
		if (_trainCount < _trainDur) {
			_learningRate = _initLearningRate * exp(_trainCount / (_trainDur * -1.0));
			_trainCount++;
		}
	}
	
	if (_inputVectorUpdated) {
		_inputVectorUpdated = false;
		if (_bmu) {
			Index3D previousBestMatch;
			vector<Index3D>::iterator it;
			previousBestMatch.x = _bmu->x;
			previousBestMatch.y = _bmu->y;
			previousBestMatch.z = _bmu->z;			
			
			if (_bestMatchHistory.size() >= _bestMatchHistorySize) {
				_bestMatchHistory.pop_back();
			}
			
			it = _bestMatchHistory.begin();
			_bestMatchHistory.insert(it, previousBestMatch);
			
		}
		
		_bmu = &(cells[_bestMatchCoords.x][_bestMatchCoords.y][_bestMatchCoords.z]);
		setCells(_bmu->x, _bmu->y, _bmu->z);
		_newBMUFound = true;
	}
    
    if (_bQueryCoords) {
        _queryStatesSize = _queryFaderStates.size();
    }

}

void World::interpolate(int x, int y, int z) {
	Cell * cell;
	cell = &cells[x][y][z];
	
	if (_interpCount < 1) _interpCount = 1;
	
	switch (_interpType) {
		case LINEAR:
			cell->phase = linInterp(cell->states[wrapi(_index - 1, 0, 2)], cell->states[_index], (double)_interpPhase / (double)_interpCount);
			break;
		case COSINE:
			cell->phase = cosInterp(cell->states[wrapi(_index - 1, 0, 2)], cell->states[_index], (double)_interpPhase / (double)_interpCount);
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
	int i, x, y, z, enc;
	_queryStates.clear();
	_queryStatesSize = size;
	for (i=0; i<size; i++) {
		enc = indices[i];
		x = (int)floor((double)enc/pow((double)_sizeX, 2));
		y = (int)floor((double)enc/(double)_sizeY)%_sizeY;
		z = enc%_sizeZ;
		_queryStates.push_back( State(x, y, z, i ) );
	}
	_bQueryStates = true;
	
}

void World::setQueryStates(int minState, int maxState) {
    _queryMinState = minState;
    _queryMaxState = maxState;
    _bQueryCoords = true;
}

void World::setInputVector(vector<double> inputVector) {
	_inputVector = inputVector;
	_inputVectorUpdated = true;
	
	somActivated = true;
}

void World::compareBMU(int x, int y, int z) {
	double diff;
	
	diff = cells[x][y][z].difference(_inputVector);
	if (diff < _bestMatch) {
		_bestMatch = diff;
		_bestMatchCoords.x = x;
		_bestMatchCoords.y = y;
		_bestMatchCoords.z = z;
	}
}


void World::trainSOM (int x, int y, int z) { 
	double influence, dist;
	Vec3f xpos, ypos;
	
	if (_trainCount < _trainDur) {
		
		xpos = Vec3f((float)x, (float)y, (float)z);
		ypos = Vec3f((float)_bmu->x, (float)_bmu->y, (float)_bmu->z);
		
		dist = xpos.distance(ypos);
		
		if (dist < _tRadius) {
			influence = exp(dist / (_tRadius * -2.0f));
			cells[x][y][z].update(_inputVector, _learningRate, influence);
		}
				
	}
	
}

void World::nextSOM(int x, int y, int z) {
	
	if (_inputVectorUpdated)
		compareBMU(x, y, z);

	if (_newBMUFound)
		trainSOM(x, y, z);
		

}

Vec3f World::bmuVec3f(Vec3f dims) {
	if (_bmu) {
		return Vec3f((float)_bmu->x * dims.x / _sizeX, (float)_bmu->y * dims.y / _sizeY, (float)_bmu->z * dims.z / _sizeZ);
	}
	else {
		return Vec3f::zero();
	}
}

void World::setCells(int x, int y, int z) {
	int i, xx, yy, zz, hlfx, hlfy, hlfz;
	
	hlfx = _sizeX / 2 - 1;
	hlfy = _sizeY / 2 - 1;
	hlfz = _sizeZ / 2 - 1;
	
	for (i = 0; i < 3; i++) {
		cells[x][y][z].states[i] = 1.0;
	}
	
	if (symmetry > 0) {
		
		if (x > hlfx) 
		{ 
			xx = hlfx - wrapi(x, 0, hlfx); 
		}
		else
		{	
			xx = (_sizeX - 1) - x;
		}
		
		if (y > hlfy)
		{	
			yy = hlfy - wrapi(y, 0, hlfy); 
		}
		else
		{	
			yy = (_sizeY - 1) - y; 
		}

		if (z > hlfz)
		{	
			zz = hlfz - wrapi(z, 0, hlfz); 
		}
		else
		{	
			zz = (_sizeZ - 1) - z; 
		}
		
		if (X || QX || TOTAL) {
				for (i = 0; i < 3; i++) {
					cells[xx][y][z].states[i] = 1.0;
				}				
		}
		if (Y || QY || TOTAL) {
				for (i = 0; i < 3; i++) {
					cells[x][yy][z].states[i] = 1.0;
				}
		}
		if (Z || QZ || TOTAL) {
			for (i = 0; i < 3; i++) {
				cells[x][y][zz].states[i] = 1.0;
			}
		}
		if (XY || QX || QY || TOTAL) {
			for (i = 0; i < 3; i++) {
				cells[xx][yy][z].states[i] = 1.0;
			}
		}
		if (YZ || QY || QZ || TOTAL) {
			for (i = 0; i < 3; i++) {
				cells[x][yy][zz].states[i] = 1.0;
			}
		}
		if (ZX || QZ || QX || TOTAL) {
			for (i = 0; i < 3; i++) {
				cells[xx][y][zz].states[i] = 1.0;
			}
		}
		if (XYZ || TOTAL) {
			for (i = 0; i < 3; i++) {
				cells[xx][yy][zz].states[i] = 1.0;
			}
		}
	}
	
	
}
