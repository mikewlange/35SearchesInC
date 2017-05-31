//
//  MTKKnuthMorrisPratt.m
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//

#import "MTKKnuthMorrisPratt.h"
#include "includeme.h"
//#http://www.geeksforgeeks.org/searching-for-patterns-set-2-kmp-algorithm/
//

// MAIN FEATURES http://www-igm.univ-mlv.fr/~lecroq/string/node8.html#SECTION0080
//performs the comparisons from left to right;
//preprocessing phase in O(m) space and time complexity;
//searching phase in O(n+m) time complexity (independent from the alphabet size);
//delay bounded by logPhi(m) where Phi is the golden ratio ( golden ratio ).

@implementation MTKKnuthMorrisPratt

#define NO_OF_CHARS 256


// C++ program for implementation of KMP pattern searching
// algorithm
char *my_strlcpy(char *dst, const char *src, size_t n)
{
    assert(dst != NULL && src != NULL);
    
    if (n > 0)
    {
    char *pd;
    const char *ps;
    
    for (--n, pd = dst, ps = src; n > 0 && *ps != '\0'; --n, ++pd, ++ps)
    *pd = *ps;
    
    *pd = '\0';
    }
    
    return dst;
}

void computeLPSArray(char *pat, int M, int *lps);

// Prints occurrences of txt[] in pat[]
void MTKKMPSearch(char *pat, int m, char *txt, int n, int* outt)
{
    //int *ret[256] ;//= NULL;

    
    int M = (int)strlen(pat);
    int N = (int)strlen(txt);
    int ct = 0;
    // create lps[] that will hold the longest prefix suffix
    // values for pattern
    int lps[M];
    
    // Preprocess the pattern (calculate lps[] array)
    computeLPSArray(pat, M, lps);
    
    int i = 0;  // index for txt[]
    int j  = 0;  // index for pat[]
    while (i < N)
    {
    if (pat[j] == txt[i])
        {
        j++;
        i++;
        }
    
    if (j == M)
        {
        printf("Found pattern at index %d \n", i-j);
        outt[ct]=i-j;
        ct++;
        j = lps[j-1];
        }
    
    // mismatch after j matches
    else if (i < N && pat[j] != txt[i])
        {
        // Do not match lps[0..lps[j-1]] characters,
        // they will match anyway
        if (j != 0)
        j = lps[j-1];
        else
        i = i+1;
        }
    }
}

// Fills lps[] for given patttern pat[0..M-1]
void computeLPSArray(char *pat, int M, int *lps)
{
    // length of the previous longest prefix suffix
    int len = 0;
    
    lps[0] = 0; // lps[0] is always 0
    
    // the loop calculates lps[i] for i = 1 to M-1
    int i = 1;
    while (i < M)
    {
    if (pat[i] == pat[len])
        {
        len++;
        lps[i] = len;
        i++;
        }
    else // (pat[i] != pat[len])
        {
        // This is tricky. Consider the example.
        // AAACAAAA and i = 7. The idea is similar
        // to search step.
        if (len != 0)
            {
            len = lps[len-1];
            
            // Also, note that we do not increment
            // i here
            }
        else // if (len == 0)
            {
            lps[i] = 0;
            i++;
            }
        }
    }
}

// Driver program to test above function
//int main()
//{
//    char *txt = "ABABDABACDABABCABAB";
//    char *pat = "ABABCABAB";
//    MTKKMPSearch(pat, txt);
//
//    return 0;
//}
@end
