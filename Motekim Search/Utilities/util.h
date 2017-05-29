//
//  util.h
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//

// References/Credits
// http://www-igm.univ-mlv.fr/~lecroq/string/index.html GREAT info
// http://www.geeksforgeeks.org/ Search stuff = got some algos from there. good stuff.
// sanmayce.com for the Railgun monsters
// The internet for the rest. 


#include "includeme.h"

@interface util : NSObject

struct _cell {
    int element;
    struct _cell *next;
};

typedef struct _cell *List;
struct _graph {
    int vertexNumber, edgeNumber, vertexCounter, initial, *terminal, *target,
    *suffixLink, *length, *position, *shift; 
};

typedef struct _graph *Graph;
typedef int boolean;

#define UNDEFINED -1

/**
 <#Description#>

 @param v <#v description#>
 @param e <#e description#>
 @return <#return value description#>
 */
Graph newGraph(int v, int e);
Graph newTrie(int v, int e) ;

/**
 <#Description#>

 @param v <#v description#>
 @param e <#e description#>
 @return <#return value description#>
 */
Graph newAutomaton(int v, int e);
Graph newSuffixAutomaton(int v, int e);
int newVertex(Graph g);
int getInitial(Graph g);
boolean isTerminal(Graph g, int v);
void setTerminal(Graph g, int v);
int getTarget(Graph g, int v, unsigned char c);
void setTarget(Graph g, int v, unsigned char c, int t);
int getSuffixLink(Graph g, int v);
void setSuffixLink(Graph g, int v, int s);
int getLength(Graph g, int v);
void setLength(Graph g, int v, int ell);
int getPosition(Graph g, int v);
void setPosition(Graph g, int v, int p);
int getShift(Graph g, int v, unsigned char c);
void setShift(Graph g, int v, unsigned char c, int s);
void copyVertex(Graph g, int target, int source);

@end
