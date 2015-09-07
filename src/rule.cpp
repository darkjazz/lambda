/*
 *  rule.cpp
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

#include "rule.h"

Rule::Rule(N dim) {
	_numStates = 2;
	_dimensions = dim;
	setDimensions(dim);
	_init = false;
}

Rule::~Rule() {
	delete [] _nhood;
}

void Rule::setStates(int numStates) {
	_numStates = numStates;
}

void Rule::setDimensions(N dim) {
	if (dim.z == 1)
		_nSize = 8;
	else
		_nSize = 26;

	setN();
}

bool Rule::cellAlive(Cell* cell, int index) {
	return (cell->states[index] > 0);
}

void Rule::setN() {
	int x, y, z, i;
	i = 0;
	if (_init) {
        delete [] _nhood;
	}
	if (_nSize == 26)
	{
		_nhood = new N[_nSize];
		for(x = -1; x <= 1; x++) {
			for(y = -1; y <= 1; y++) {
				for (z = -1; z <= 1; z++) {
					if (!(x==0 && y==0 && z==0)) {
						_nhood[i].x = x;
						_nhood[i].y = y;
						_nhood[i].z = z;
						i++;
					}
				}
			}
		}
	}
	else
	{
		_nhood = new N[_nSize];
		for(x = -1; x <= 1; x++) {
			for(y = -1; y <= 1; y++) {
				if (!(x==0 && y==0)) {
					_nhood[i].x = x;
					_nhood[i].y = y;
					_nhood[i].z = 0;
					i++;
				}
			}

		}
	}
	_init = true;
}

int Rule::countAliveNeighbors(Cell* cell, int index) {
	int count, i;
	Cell* n;
	count = 0;
	for (i = 0; i < _nSize; i++) {
		n = getNeighbor(cell, i);
		if (n->states[index] == 1) {
			count++;
		}
	}
	return count;
}

Cell* Rule::getNeighbor(Cell* current, int index) {
	int x, y, z;
	x = wrapi(current->x+nAtX(index),0,_dimensions.x-1);
	y = wrapi(current->y+nAtY(index),0,_dimensions.y-1);
	z = wrapi(current->z+nAtZ(index),0,_dimensions.z-1);
	return &world[x][y][z];
}

Faders::Faders(N dim) : Rule(dim) {
	_births = NULL;
	setBirths(NULL);
	_survivals = NULL;
	setSurvivals(NULL);
}

Faders::Faders(int *births, int *survivals, int states, N dim) : Rule(dim) {
	_births = NULL;
	setBirths(births);
	_survivals = NULL;
	setSurvivals(survivals);
	setStates(states);
}

void Faders::setBirths(int *births) {
	int i, size;
	if (!_births)
		_births = new int[nSize()];

	for (i = 0; i < nSize(); i++) {
		_births[i] = 0;
	}
	if (births)
	{
		size = sizeof(births) / sizeof(int);
		for (i = 0; i < size; i++) {
			_births[births[i]] = 1;
		}
	}
}

void Faders::setSurvivals(int *survivals) {
	int i, size;
	if (!_survivals)
		_survivals = new int[nSize()];

	for (i = 0; i < nSize(); i++) {
		_survivals[i] = 0;
	}
	if (survivals)
	{
		size = sizeof(survivals) / sizeof(int);
		for (i = 0; i < size; i++) {
			_survivals[survivals[i]] = 1;
		}
	}
}

void Faders::next(Cell* current, int index) {
	int alive, state, nextIndex;

	nextIndex = wrapi(index + 1, 0, 2);

	alive = countAliveNeighbors(current, index);
	state = current->states[index];
	if (state > 1.0) {
		if (state < numStates()) {
			current->states[nextIndex] = state + 1.0;
		}
		else
		{
			current->states[nextIndex] = 0.0;
		}
	}
	else
	{
		if (state == 0.0)
		{
			current->states[nextIndex] = _births[alive];
		}
		else
		{
			if (_survivals[alive] == 0.0) {
				if (state < numStates()) {
					current->states[nextIndex] = state + 1.0;
				}
				else
				{
					current->states[nextIndex] = 0.0;
				}
			}
			else
			{
				current->states[nextIndex] = 1.0;
			}
		}
	}

}

double Faders::mapState(double state) {
	return (float)((int)mapf(state, 0.0, numStates() - 1));
}

void Life::setBirths(int *births) {
	int i, size;
	if (!_births)
		_births = new int[nSize()];

	for (i = 0; i < nSize(); i++) {
		_births[i] = 0;
	}
	if (births)
	{
		size = sizeof(births) / sizeof(int);
		for (i = 0; i < size; i++) {
			_births[births[i]] = 1;
		}
	}
}

void Life::setSurvivals(int *survivals) {
	int i, size;
	if (!_survivals)
		_survivals = new int[nSize()];

	for (i = 0; i < nSize(); i++) {
		_survivals[i] = 0;
	}
	if (survivals)
	{
		size = sizeof(survivals) / sizeof(int);
		for (i = 0; i < size; i++) {
			_survivals[survivals[i]] = 1;
		}
	}
}

Life::Life(int *births, int *survivals, N dim) : Rule(dim) {
	_births = NULL;
	setBirths(births);
	_survivals = NULL;
	setSurvivals(survivals);
}

void Life::next(Cell* current, int index) {
	int alive, state, nextIndex;

	nextIndex = wrapi(index + 1, 0, 2);

	alive = countAliveNeighbors(current, index);
	state = current->states[index];

	if (state == 1.0) {
		current->states[nextIndex] = _survivals[alive];
	}
	else
	{
		current->states[nextIndex] = _births[alive];
	}

}

double Life::mapState(double state) {
	return (float)((int)mapf(state, 0.0, numStates() - 1));
}

Continuous::Continuous(double add, double* weights, N dim) : Rule(dim) {
	_add = add;
	_weights = weights;
}

void Continuous::next(Cell *current, int index) {
	int nextIndex, state, i;
	double avg, wsum;

	nextIndex = wrapi(index + 1, 0, 2);
	state = current->states[index];

	avg = 0.0;
	wsum = 0.0;

	for (i = 0; i < nSize(); i++ ) {
		avg += (getNeighbor(current, i)->states[index] * _weights[i]);
		wsum += _weights[i];
	}
	avg /= wsum;


	current->states[nextIndex] = wrapd(avg + _add, 0.0, 1.0);

}

void Continuous::setAdd(double add) { _add = add; }

void Continuous::setWeights(double* weights) {
	delete [] _weights;
	_weights = new double[ nSize() ];
	for (int i=0; i < nSize(); i++)
		_weights[i] = weights[i];

}

double Continuous::mapState(double state) {
	return unmapf(state, 0.0, numStates() - 1);
}
