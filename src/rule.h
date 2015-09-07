/*
 *  rule.h
 *  decay
 *
 *  Created by alo on 11/07/2011.
 *
 *	This file is part of decay.
 *
 *	decay is free software: you can redistribute it and/or modify
 *	it under the terms of the GNU General Public License as published by
 *	the Free Software Foundation, either version 3 of the License, or
 *	(at your option) any later version.

 *	decay is distributed in the hope that it will be useful,
 *	but WITHOUT ANY WARRANTY; without even the implied warranty of
 *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *	GNU General Public License for more details.

 *	You should have received a copy of the GNU General Public License
 *	along with decay.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

#ifndef RULE_H
#define RULE_H

#include <vector>
#include <iostream>
#include <math.h>

#include "world.h"

class Cell;

struct N { int x, y, z; N() : x(0), y(0), z(0) {} };

//	**** RULE ****

class Rule {
public:
	Rule(N);
	~Rule();

	Cell*** world;

	void setStates(int);
	void setDimensions(N);
	int nSize() { return _nSize; };
	int nAtX(int index) { return _nhood[index].x; };
	int nAtY(int index) { return _nhood[index].y; };
	int nAtZ(int index) { return _nhood[index].z; };
	int numStates() { return _numStates; };
	bool cellAlive(Cell*, int);
	int countAliveNeighbors(Cell*, int);
	Cell* getNeighbor(Cell*, int);

	virtual void next(Cell*, int) {};
	virtual void setBirths(int*) {};
	virtual void setSurvivals(int*) {};
	virtual void setAdd(double) {};
	virtual void setWeights(double*) {};
	virtual double mapState(double) { return 0; };

private:
	int _numStates, _nSize;
	N* _nhood;
	N _dimensions;
	bool _init;

	void setN();
};

class Faders : public Rule {
public:
	Faders(N);
	Faders(int*, int*, int, N);
	~Faders() {};

	void setBirths(int*);
	void setSurvivals(int*);

	void next(Cell*, int);
	double mapState(double);

private:
	int* _births;
	int* _survivals;
};

class Life : public Rule {
public:
	Life(N dim) : Rule(dim) {};
	Life(int*, int*, N);
	~Life() {};

	void setBirths(int*);
	void setSurvivals(int*);

	void next(Cell*, int);
	double mapState(double);

private:
	int* _births;
	int* _survivals;
};

class Continuous : public Rule {
public:
	Continuous(N dim) : Rule(dim) {
		_add = 0.005;
		_weights = new double[ nSize() ];
		for (int i=0; i < nSize(); i++)
			_weights[i] = 1.0;

	};
	Continuous(double, double*, N);
	~Continuous() { delete [] _weights; };

	void next(Cell*, int);
	void setAdd(double);
	void setWeights(double*);
	double mapState(double);


private:
	double _add;
	double* _weights;
};

#endif
