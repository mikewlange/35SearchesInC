//
//  MTKBoyerMooreHorspool.m
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//

#import "MTKBoyerMooreHorspool.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#import "MTKbruteforce.h"
#include "includeme.h"

@implementation MTKBoyerMooreHorspool
#define ASCII_SIZE      256
#define BUFSIZE 	16

int bcs[ASCII_SIZE];
int match[256];
int matchIndex = 0;


// FOR BIG FILE EDITING
void create_bcs_table (const char * needle, int len)
{
    int i;
    int last = len - 1;
    
    for (i = 0; i < ASCII_SIZE; ++ i)
        {
        bcs[i] = len;
        }
    
    for (i = 0; i < last; ++ i)
        {
        bcs[(int)needle[i]] = last - i;
        }
}

/* Boyer-Moore-Horspool algorithm */
void bmh (int offset, const char * haystack, const char * needle, int * edgeL, int * edgeR)
{
    int lenH, lenN, n, m, i, k, shift, cnt = 0;
    
    *edgeL = *edgeR = 0;
    lenH = (int)strlen (haystack);
    lenN = (int)strlen (needle);
    n = lenH;
    m = lenN;
    
    printf ("Haystack: %d Needle: %d\n", n, m);
    
    if (m > n) return;
    
    create_bcs_table (needle, m);
    
    // check Left Edge
    for (k=1; k < lenN; k++) {
        ++cnt;
        for (i=k; i>0 && haystack[i-1] == needle[lenN-k+i-1]; -- i);
        (*edgeL) = (*edgeL) << 1 | !i;
    }
    
    
    k = 0;
    while (n >= m)
        {
        ++ cnt;
        printf ("Haystack: %s\n  Needle: %*s%s\n", haystack, k, "", needle);
        for (i = m - 1; haystack[k + i] == needle[i]; -- i)
            if (i == 0)
                {
                match[matchIndex++] = offset + k;
                printf ("Match: %d (%d)\n", k, offset + k);
                break;
                }
        
        shift = bcs[(int)haystack[k + i]];
        k += shift;
        n -= shift;
        printf ("\n");
        }
    
    // check Right Edge
    for (k=lenN-1; k > 0; k--) {
        ++cnt;
        for (i=k; i>0 && haystack[lenH-k+i-1] == needle[i-1]; -- i);
        (*edgeR) = (*edgeR) << 1 | !i;
    }
    
    printf ("Edges = %d %d\n", *edgeL, *edgeR);
    printf ("Total operations: %d\n", cnt);
}

static int cmpint(const void *p1, const void *p2) {
    return *(int const *)p1 > *(int const *)p2;
}

int run (int argc, char * argv[])
{
    FILE * f;
    int i, fileIndex, pos0, dz;
    
    if (argc < 3) {
        printf("usage: <ex> regexp file");
        return 1;
    }
    
    char buf[BUFSIZE];
    char * needle   = argv[1];//"aba";
    for (fileIndex = 2; fileIndex < argc; fileIndex++) {
        
        f = fopen(argv[fileIndex], "r");
        if (f == NULL) {
            printf("can't open %s:", argv[fileIndex]);
            continue;
        }
        int pEdgeL = 0, pEdgeR = 0;
        int edgeL;
        int edgeR;
        pos0 = 0;
        while (fgets(buf, sizeof buf, f) != NULL) {
            bmh (pos0, buf, needle, &edgeL, &edgeR);
            if (pEdgeR) {
                int matches = pEdgeR & pEdgeL;
            }
            
            // check joint position
            dz = edgeL & pEdgeR;
            printf("In Joints: %d\n", dz);
            
            i=1;
            for (; dz>0; dz>>=1) {
                if (dz & 1) {
                    match[matchIndex++] = pos0 - i;
                }
                i++;
            }
            
            pEdgeL = edgeL;
            pEdgeR = edgeR;
            
            pos0 += BUFSIZE-1;
        }
        
        qsort(match, matchIndex, sizeof(int), cmpint);
        for (i=0; i < matchIndex; i++)
            printf("%d: Match in %d\n", i, match[i]);
        
        fclose(f);
        
    }
    
    return (0);
}



/// Boyer-Moore-Horspool algorithm (for C strings)
const char* searchBoyerMooreHorspoolString(const char* haystack, const char* needle){
    // detect invalid input
    if (!haystack || !needle)
        return NULL;
    
    // call routine for non-text data
    return searchBoyerMooreHorspool(haystack, strlen(haystack), needle, strlen(needle));
}


/// Boyer-Moore-Horspool algorithm (for non-text data)
const char* searchBoyerMooreHorspool(const char* haystack, size_t haystackLength,
                                     const char* needle,   size_t needleLength){
    // detect invalid input
    if (!haystack || !needle || haystackLength < needleLength)
        return NULL;
    
    // empty needle matches everything
    if (needleLength == 0)
        return haystack;
    
    // find right-most position of each character
    // and store its distance to the end of needle
    
    // default value: when a character in haystack isn't in needle, then
    //                we can jump forward needleLength bytes
    const size_t NumChar = 1 << (8 * sizeof(char));
    size_t skip[NumChar];
    size_t i;
    for (i = 0; i < NumChar; i++)
        skip[i] = needleLength;
    
    // figure out for each character of the needle how much we can skip
    // (if a character appears multiple times in needle, later occurrences
    //  overwrite previous ones, i.e. the value of skip[x] decreases)
    const size_t lastPos = needleLength - 1;
    size_t pos;
    for (pos = 0; pos < lastPos; pos++)
        skip[(unsigned char)needle[pos]] = lastPos - pos;
    
    // now walk through the haystack
    while (haystackLength >= needleLength)
        {
        // all characters match ?
        for (i = lastPos; haystack[i] == needle[i]; i--)
            if (i == 0)
                return haystack;
        
        // no match, jump ahead
        unsigned char marker = (unsigned char) haystack[lastPos];
        haystackLength -= skip[marker];
        haystack       += skip[marker];
        }
    
    // needle not found in haystack
    return NULL;
}


@end
