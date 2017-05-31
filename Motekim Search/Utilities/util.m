//
//  util.m
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//

#import "util.h"
#include "includeme.h"

@implementation util


void outp( int pos ) {
    static int matches = 0;
    printf( "match %d found at position %d\n", ++matches, pos );
}
/**
  returns a new data structure for
 a graph with v vertices and e edges

 @param v vertices
 @param e edges
 @return Graph
 */
Graph newGraph(int v, int e) {
    Graph g;
    
    g = (Graph)calloc(1, sizeof(struct _graph));
    if (g == NULL)
    // log("newGraph");
    g->vertexNumber = v;
    g->edgeNumber = e;
    g->initial = 0;
    g->vertexCounter = 1;
    g->shift = 0;
    return (g);
}


/**
 returns a new data structure for
 a automaton with v vertices and e edges

 @param v vertices
 @param e edges
 @return Graph
 */
Graph newAutomaton(int v, int e) {
    Graph aut;
    
    aut = newGraph(v, e);
    aut->target = (int *)calloc(e, sizeof(int));
    if (aut->target == NULL)
    // return log("newAutomaton");
    aut->terminal = (int *)calloc(v, sizeof(int));
    if (aut->terminal == NULL) {
    }
    // log("newAutomaton");
    return (aut);
}

/* returns a new data structure for
 a suffix automaton with v vertices and e edges */
Graph newSuffixAutomaton(int v, int e) {
    Graph aut;
    
    aut = newAutomaton(v, e);
    memset(aut->target, UNDEFINED, e * sizeof(int));
    aut->suffixLink = (int *)calloc(v, sizeof(int));
    if (aut->suffixLink == NULL)
    // log("newSuffixAutomaton");
    aut->length = (int *)calloc(v, sizeof(int));
    if (aut->length == NULL)
    // log("newSuffixAutomaton");
    aut->position = (int *)calloc(v, sizeof(int));
    if (aut->position == NULL)
    // log("newSuffixAutomaton");
    aut->shift = (int *)calloc(e, sizeof(int));
    if (aut->shift == NULL) {
    }
    // log("newSuffixAutomaton");
    return (aut);
}

/* returns a new data structure for
 a trie with v vertices and e edges */
Graph newTrie(int v, int e) {
   Graph aut;
    
    aut = newAutomaton(v, e);
    memset(aut->target, UNDEFINED, e * sizeof(int));
    aut->suffixLink = (int *)calloc(v, sizeof(int));
    if (aut->suffixLink == NULL)
    // log("newTrie");
    aut->length = (int *)calloc(v, sizeof(int));
    if (aut->length == NULL)
    //  log("newTrie");
    aut->position = (int *)calloc(v, sizeof(int));
    if (aut->position == NULL)
    //   log("newTrie");
    aut->shift = (int *)calloc(e, sizeof(int));
    if (aut->shift == NULL) {
    }
    //  log("newTrie");
    return (aut);
}

/* returns a new vertex for graph g */
int newVertex(Graph g) {
    if (g != NULL && g->vertexCounter <= g->vertexNumber) {
    }
    return (g->vertexCounter++);
    // log("newVertex");
}

/* returns the initial vertex of graph g */
int getInitial(Graph g) {
    if (g != NULL) {
    }
    return (g->initial);
    // log("getInitial");
}

/* returns true if vertex v is terminal in graph g */
boolean isTerminal(Graph g, int v) {
    if (g != NULL && g->terminal != NULL && v < g->vertexNumber) {
    }
    return (g->terminal[v]);
    // log("isTerminal"); 
}

/* set vertex v to be terminal in graph g */
void setTerminal(Graph g, int v) {
    if (g != NULL && g->terminal != NULL && v < g->vertexNumber)
    g->terminal[v] = 1;
    
    // log("isTerminal");
}

/* returns the target of edge from vertex v
 labelled by character c in graph g */
int getTarget(Graph g, int v, unsigned char c) {
    if (g != NULL && g->target != NULL && v < g->vertexNumber &&
        v * c < g->edgeNumber)
    return (g->target[v * (g->edgeNumber / g->vertexNumber) + c]);
    
    return 0;
    // log("getTarget");
}

/* add the edge from vertex v to vertex t
 labelled by character c in graph g */
void setTarget(Graph g, int v, unsigned char c, int t) {
    if (g != NULL && g->target != NULL && v < g->vertexNumber &&
        v * c <= g->edgeNumber && t < g->vertexNumber)
    g->target[v * (g->edgeNumber / g->vertexNumber) + c] = t;
}

/* returns the suffix link of vertex v in graph g */
int getSuffixLink(Graph g, int v) {
    if (g != NULL && g->suffixLink != NULL && v < g->vertexNumber) {
        return (g->suffixLink[v]);
    } else
    return 0;
    
    // log("getSuffixLink");
}

/* set the suffix link of vertex v
 to vertex s in graph g */
void setSuffixLink(Graph g, int v, int s) {
    if (g != NULL && g->suffixLink != NULL && v < g->vertexNumber &&
        s < g->vertexNumber) {
        g->suffixLink[v] = s;
    }
    
    // log("setSuffixLink");
}

/* returns the length of vertex v in graph g */
int getLength(Graph g, int v) {
    if (g != NULL && g->length != NULL && v < g->vertexNumber) {
        return (g->length[v]);
    } else
    return 0;
    // log("getLength");
}

/* set the length of vertex v to integer ell in graph g */
void setLength(Graph g, int v, int ell) {
    if (g != NULL && g->length != NULL && v < g->vertexNumber)
    g->length[v] = ell;
    //    else
    //    log("setLength");
}

/* returns the position of vertex v in graph g */
int getPosition(Graph g, int v) {
    if (g != NULL && g->position != NULL && v < g->vertexNumber) {
        return (g->position[v]);
    } else
    return 0;
    //    log("getPosition");
}

/* set the length of vertex v to integer ell in graph g */
void setPosition(Graph g, int v, int p) {
    if (g != NULL && g->position != NULL && v < g->vertexNumber)
    g->position[v] = p;
    //    else
    //    log("setPosition");
}

/* returns the shift of the edge from vertex v
 labelled by character c in graph g */
int getShift(Graph g, int v, unsigned char c) {
    if (g != NULL && g->shift != NULL && v < g->vertexNumber &&
        v * c < g->edgeNumber) {
        return (g->shift[v * (g->edgeNumber / g->vertexNumber) + c]);
    } else
    return 0;
    // log("getShift");
}

/* set the shift of the edge from vertex v
 labelled by character c to integer s in graph g */
void setShift(Graph g, int v, unsigned char c, int s) {
    if (g != NULL && g->shift != NULL && v < g->vertexNumber &&
        v * c <= g->edgeNumber)
    g->shift[v * (g->edgeNumber / g->vertexNumber) + c] = s;
    //    else
    //    log("setShift");
}

/* copies all the characteristics of vertex source
 to vertex target in graph g */
void copyVertex(Graph g, int target, int source) {
    if (g != NULL && target < g->vertexNumber && source < g->vertexNumber) {
        
        if (g->target != NULL) {
            memcpy(g->target + target * (g->edgeNumber / g->vertexNumber),
                   g->target + source * (g->edgeNumber / g->vertexNumber),
                   (g->edgeNumber / g->vertexNumber) * sizeof(int));
        }
        
        // int *x = g->shift;
        if (g->shift != NULL) {
            memcpy(g->shift + target * (g->edgeNumber / g->vertexNumber),
                   g->shift + source * (g->edgeNumber / g->vertexNumber),
                   (g->edgeNumber / g->vertexNumber) * sizeof(int));
        }
        
        if (g->terminal != NULL)
        g->terminal[target] = g->terminal[source];
        if (g->suffixLink != NULL)
        g->suffixLink[target] = g->suffixLink[source];
        if (g->length != NULL)
        g->length[target] = g->length[source];
        if (g->position != NULL)
        g->position[target] = g->position[source];
    };
}

// End of longest common prefixes algorithm
@end
