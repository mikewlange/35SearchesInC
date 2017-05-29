//
//  MTKAlphaSkip.m
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//


/////////////////////////////
//+++++++++++++++++++++++++++
// Alpha Skip Search algorithm
//+++++++++++++++++++++++++++
/////////////////////////////

//+++++++++++++++++++++++++++
// MAIN FEATURES
//+++++++++++++++++++++++++++
//improvement of the Skip Search algorithm;
//uses buckets of positions for each factor of length logsigma(m) of the pattern;
//preprocessing phase in O(m) time and space complexity;
//searching phase in O(mn) time complexity;
//O(logsigma(m).(n / (m-logsigma(m)))) expected text character comparisons.
//http://www-igm.univ-mlv.fr/~lecroq/string/node33.html#SECTION00330

#import "MTKAlphaSkip.h"
#import "includeme.h"
#import "util.h"
@implementation MTKAlphaSkip

#define ASIZE   256

List *z;

#define getZ(i) z[(i)]

void assetZ(int node, int i) {
    List cell;
    
    cell = (List)malloc(sizeof(struct _cell));
    if (cell == NULL)
        //error("ALPHASKIP/setZ");
        cell->element = i;
    cell->next = z[node];
    z[node] = cell;
}


/* Create the transition labelled by the
 character c from node node.
 Maintain the suffix links accordingly. */
int asaddNode(Graph trie, int art, int node, char c) {
    int childNode, suffixNode, suffixChildNode;
    
    childNode = newVertex(trie);
    setTarget(trie, node, c, childNode);
    suffixNode = getSuffixLink(trie, node);
    if (suffixNode == art)
        setSuffixLink(trie, childNode, node);
    else {
        suffixChildNode = getTarget(trie, suffixNode, c);
        if (suffixChildNode == UNDEFINED)
            suffixChildNode = asaddNode(trie, art,
                                      suffixNode, c);
        setSuffixLink(trie, childNode, suffixChildNode);
    }
    return(childNode);
}


void ALPHASKIP(char *x, char *y, int* output) {
    int m = (int)strlen(x);
    int n = (int)strlen(y);
    int p = 0;
    int a = 101;
    int b, i, j, k, logM, temp, shift, size, pos;
    int art, childNode, node, root, lastNode;
    List current;
    Graph trie = NULL;
    
    logM = 0;
    temp = m;
    while (temp > a) {
        ++logM;
        temp /= a;
    }
    if (logM == 0) logM = 1;
    
    
    /* Preprocessing */
    size = 2 + (2*m - logM + 1)*logM;
    trie= newTrie(size, size*ASIZE);
    z = (List *)calloc(size, sizeof(List));
    //if (z == NULL)
    // error("ALPHASKIP");
    
    root = getInitial(trie);
    art = newVertex(trie);
    setSuffixLink(trie, root, art);
    node = newVertex(trie);
    setTarget(trie, root, x[0], node);
    setSuffixLink(trie, node, root);
    for (i = 1; i < logM; ++i)
        node = asaddNode(trie, art, node, x[i]);
    pos = 0;
    assetZ(node, pos);
    pos++;
    for (i = logM; i < m - 1; ++i) {
        node = getSuffixLink(trie, node);
        childNode = getTarget(trie, node, x[i]);
        if (childNode == UNDEFINED)
            node = asaddNode(trie, art, node, x[i]);
        else
            node = childNode;
        assetZ(node, pos);
        pos++;
    }
    node = getSuffixLink(trie, node);
    childNode = getTarget(trie, node, x[i]);
    if (childNode == UNDEFINED) {
        lastNode = newVertex(trie);
        setTarget(trie, node, x[m - 1], lastNode);
        node = lastNode;
    }
    else
        node = childNode;
    assetZ(node, pos);
    
    /* Searching */
    shift = m - logM + 1;
    for (j = m + 1 - logM; j < n - logM; j += shift) {
        node = root;
        for (k = 0; node != UNDEFINED && k < logM; ++k)
            node = getTarget(trie, node, y[j + k]);
        if (node != UNDEFINED)
            for (current = getZ(node);
                 current != NULL;
                 current = current->next) {
                b = j - current->element;
                if (x[0] == y[b] &&
                    memcmp(x + 1, y + b + 1, m - 1) == 0){
                    output[p] = b;
                    p++;
                    //OUTPUT(b);
                }
            }
    }
    free(z);
}

@end
