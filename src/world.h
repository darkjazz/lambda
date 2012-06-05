/*
 *  world.h
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

#ifndef WORLD_H
#define WORLD_H

#include <vector>
#include <iostream>
#include <typeinfo>
#include <math.h>

#include "util.h"
#include "rule.h"

using namespace std;

class Rule;
class Life;
class Faders;
class Continuous;
struct N;

enum R { CONT, LIFE, GEN };
enum Interpolation { NONE, LINEAR, COSINE };

struct State { 
	int x, y, z, index;
	double value;
	State() {};
	State(int ax, int ay, int az, int aindex) { 
		x = ax; y = ay; z = az; index = aindex;
	};
	bool include(int argX, int argY, int argZ) {
		return (argX == x && argY == y && argZ == z);
	}
};

//	**** CELL **** 

class Cell {
public:
	Cell() : x(0), y(0), z(0) {};
	~Cell() {};
	int x, y, z; 
	double states[3];
	double phase;
	vector<double> weights;	
	
};

//	**** WORLD ****

class World {
	
public:
	World();
	World(int, int, int);
	~World();
	
	Cell*** cells;
	
	void init(int, int, int);
	
	int index() { return _index; };
	int sizeX() { return _sizeX; };
	int sizeY() { return _sizeY; };
	int sizeZ() { return _sizeZ; };
	int alive() { return _alive; };
	Rule* rule() { return _rule; }
	double cellState(int, int, int);
	
	void incrementIndex();
	void incrementAlive();
	void resetAlive();
	int vectorSize();
	
	void initRandInArea(int, int, int, int, int, int, int, float, bool);
	void initWireCube(int, int, int, int, int, int);
	void next(int, int, int);
	void interpolate(int, int, int);
	
	void initRule(R);
	
	void prepareNext();
	void finalizeNext();
	
	bool initialized() { return (cells != NULL && _rule != NULL); };
	bool bQueryStates() { return _bQueryStates; }
	
	void setInterpolation(Interpolation, int);
	void setQueryIndices(int*, int);
	int getQueryStatesSize() { return _queryStatesSize; }
	double getQueryStateAtIndex(int index) { return _queryStates[index].value; }
	void stopQuery() { _bQueryStates = false; };
	void mapStates();
	
private:
	void clear();
	int _sizeX, _sizeY, _sizeZ, _index, _alive;
	int _vectorSize, _nSize;
	
	Interpolation _interpType;
	int _interpCount, _interpPhase;
	
	bool _updateStates; 
	bool _bQueryStates;
	vector<State> _queryStates;
	
	int _queryStatesSize, _currentQueryIndex;
	
	Rule* _rule;
};


#endif