//
//  MTKShiftOr.m
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//

#import "MTKShiftOr.h"
#include "includeme.h"

/////////////////////////////
//+++++++++++++++++++++++++++

// Deterministic Finite Automaton algorithm

//+++++++++++++++++++++++++++
/////////////////////////////

/////////////////////////////
//+++++++++++++++++++++++++++

// Main features

//uses bitwise techniques;
//efficient if the pattern length is no longer than the memory-word size of the machine;
//preprocessing phase in O(m + sigma) time and space complexity;
//searching phase in O(n) time complexity (independent from the alphabet size and the pattern length);
//adapts easily to approximate string matching.

//+++++++++++++++++++++++++++
/////////////////////////////

/////////////////////////////
//+++++++++++++++++++++++++++

// Description

//http://www-igm.univ-mlv.fr/~lecroq/string/node6.html#SECTION0060
//https://en.wikipedia.org/wiki/Bitap_algorithm
//+++++++++++++++++++++++++++
/////////////////////////////



@implementation MTKShiftOr
#define XSIZE   20
#define ASIZE   256
#if defined(__linux__)
int preSo(char *x, int m, unsigned int S[]) {
    unsigned int j, lim;
    int i;
    for (i = 0; i < ASIZE; ++i)
    S[i] = ~0;
    for (lim = i = 0, j = 1; i < m; ++i, j <<= 1) {
        S[x[i]] &= ~j;
        lim |= j;
    }
    lim = ~(lim>>1);
    return(lim);
}

void SO(char *x, int m, char *y, int n) {
    unsigned int lim, state;
    unsigned int S = [ASIZE];
    int j;
    int ss = (int)strlen(y);
    if (m > ss){
        return; //printf("SO: Use pattern size <= word size");
    }
    /* Preprocessing */
    lim = preSo(x, m, S);
    
    /* Searching */
    for (state = ~0, j = 0; j < n; ++j) {
        state = (state<<1) | S[y[j]];
        if (state < lim)
        OUTPUT(j - m + 1);
    }
}
#endif

// Don't lke the separate funtions, let's go with

//ShiftOr
const char *ShiftOr(const char *text, const char *pattern)
{
    int m = (int)strlen(pattern);
    unsigned long R;
    unsigned long pattern_mask[CHAR_MAX+1];
    int i;
    
    if (pattern[0] == '\0') return text;
    if (m > 31) return "The pattern is too long!";
    
    /* Initialize the bit array R */
    R = ~1;
    
    /* Initialize the pattern bitmasks */
    for (i=0; i <= CHAR_MAX; ++i)
    pattern_mask[i] = ~0;
    for (i=0; i < m; ++i)
    pattern_mask[pattern[i]] &= ~(1UL << i);
    
    for (i=0; text[i] != '\0'; ++i) {
        /* Update the bit array */
        R |= pattern_mask[text[i]];
        R <<= 1;
        
        if (0 == (R & (1UL << m)))
        return (text + i - m) + 1;
    }
    
    return NULL;
}
// Hairy ShiftOr
// k = Hamming distance - https://en.wikipedia.org/wiki/Bitap_algorithm
//
const char *ShiftOrFuzzy(const char *text, const char *pattern)
{
    int k = hamming_distance64((unsigned long long)(strlen(text)),(unsigned long long)(strlen(pattern)));
    const char *result = NULL;
    int m = (int)strlen(pattern);
    unsigned long *R;
    unsigned long pattern_mask[CHAR_MAX+1];
    int i, dude;
    
    if (pattern[0] == '\0') return text;
    if (m > 31) return "The pattern is too long!";
    
    /* Initialize the bit array R */
    R = malloc((k+1) * sizeof *R);
    for (i=0; i <= k; ++i)
    R[i] = ~1;
    
    /* Initialize the pattern bitmasks */
    for (i=0; i <= CHAR_MAX; ++i)
    pattern_mask[i] = ~0;
    for (i=0; i < m; ++i)
    pattern_mask[pattern[i]] &= ~(1UL << i);
    
    for (i=0; text[i] != '\0'; ++i) {
        /* Update the bit arrays */
        unsigned long old_Rd1 = R[0];
        
        R[0] |= pattern_mask[text[i]];
        R[0] <<= 1;
        
        for (dude=1; dude <= k; ++dude) {
            unsigned long tmp = R[dude];
            /* Substitution is all we care about */
            R[dude] = (old_Rd1 & (R[dude] | pattern_mask[text[i]])) << 1;
            old_Rd1 = tmp;
        }
        
        if (0 == (R[k] & (1UL << m))) {
            result = (text+i - m) + 1;
            break;
        }
    }
    
    free(R);
    return result;
}
int hamming_distance(unsigned x, unsigned y)
{
    return __builtin_popcount(x ^ y);
}
//if your compiler supports 64-bit integers
int hamming_distance64(unsigned long long x, unsigned long long y)
{
    return __builtin_popcountll(x ^ y);
}



@end
