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
#include <math.h>

#include "util.h"

using namespace std;

enum R { CONT, LIFE, GEN };

//	**** CELL **** 

class Cell {
public:
	Cell() : x(0), y(0), z(0) {};
	~Cell() {};
	int x, y, z; 
	int istates[3];
	double dstates[3];
	vector<double> weights;
	Cell **neighbors;
	
	int countAliveNeighbors(int);
};



//	**** RULE ****

class Rule {
public: 
	Rule();
	~Rule();
	
	int* states() { return _states; };
	void setStates(int);
	int numStates() { return _numStates; };
	bool cellAlive(Cell*, int);
	
	virtual void next(Cell*, int) {};
	virtual void setBirths(int*) {};
	virtual void setSurvivals(int*) {};
	virtual void setAdd(double) {};
	virtual void setWeights(vector<double>) {};
	
private:
	int *_states;
	int _numStates;
};

class Faders : public Rule {
public:
	Faders() {};
	Faders(int*, int*, int);
	~Faders() {};
	
	void setBirths(int*);
	void setSurvivals(int*);
	
	void next(Cell*, int);
	
private:
	int _births[26]; 
	int _survivals[26];
};

class Life : public Rule {
public:
	Life() {};
	Life(int*, int*);
	~Life() {};
	
	void setBirths(int*);
	void setSurvivals(int*);
	
	void next(Cell*, int);
	
private:
	int _births[26]; 
	int _survivals[26];	
};

class Continuous : public Rule {
public:
	Continuous() {};
	Continuous(double, vector<double>);
	~Continuous() {};
	
	void next(Cell*, int);
	void setAdd(double);
	void setWeights(vector<double>);
	
private:
	double _add;
	vector<double> _weights;
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
	Rule* rule() { return _rule; };
	double cellState(int, int, int);
	
	void nextIndex();
	void incrementAlive();
	void resetAlive();
	int vectorSize();
	
	void initRandInArea(int, int, int, int, int, int, int, float, bool);
	void initWireCube(int, int, int, int, int, int);
	void initRule(R);
	
private:
	void clear();
	int _sizeX, _sizeY, _sizeZ, _index, _alive;
	int _vectorSize;
	Rule* _rule;	
	
};


#endif