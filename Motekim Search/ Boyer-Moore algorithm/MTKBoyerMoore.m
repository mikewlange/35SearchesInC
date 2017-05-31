//
//  MTKBoyerMoore.m
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//

#import "MTKBoyerMoore.h"
#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdbool.h>

/////////////////////////////
//+++++++++++++++++++++++++++
// Boyer-Moore algorithm
//+++++++++++++++++++++++++++
/////////////////////////////

//+++++++++++++++++++++++++++
// MAIN FEATURES
//+++++++++++++++++++++++++++
//performs the comparisons from right to left;
//preprocessing phase in O(m+sigma) time and space complexity;
//searching phase in O(mn) time complexity;
//3n text character comparisons in the worst case when searching for a non periodic pattern;
//O(n / m) best performance.e.

// Description
// The Boyer-Moore algorithm is considered as the most efficient string-matching algorithm in usual applications. A simplified version of it or the entire algorithm is often implemented in text editors for the «search» and «substitute» commands.
// http://www-igm.univ-mlv.fr/~lecroq/string/node10.html#SECTION00100 for more


@implementation MTKBoyerMoore



#define ALPHABET_LEN 256
#define NOT_FOUND patlen


#define XSIZE   20
#define ASIZE   256



int chars_compared;

// delta1 table: delta1[c] contains the distance between the last
// character of pat and the rightmost occurrence of c in pat.
// If c does not occur in pat, then delta1[c] = patlen.
// If c is at string[i] and c != pat[patlen-1], we can
// safely shift i over by delta1[c], which is the minimum distance
// needed to shift pat forward to get string[i] lined up
// with some character in pat.
// this algorithm runs in alphabet_len+patlen time.
void make_delta1(int *delta1, uint8_t *pat, int32_t patlen) {
    int i;
#ifdef DEBUG
    int j;
    int delta1_chars[patlen];
    int max_chars = 0;
    bool is_matched = false;
#endif
    
    for (i=0; i < ALPHABET_LEN; i++) {
        delta1[i] = NOT_FOUND;
    }
    for (i=0; i < patlen-1; i++) {
        delta1[pat[i]] = patlen-1 - i;
#ifdef DEBUG
        is_matched = false;
        for (j=0; j <= max_chars; j++) {
            if (delta1_chars[j] == pat[i]) {
                is_matched = true;
            }
        }
        if (is_matched == false) {
            delta1_chars[max_chars] = pat[i];
            max_chars++;
        }
#endif
    }
#ifdef DEBUG
    int t;
    printf ("\n");
    for (t=0; t < max_chars; t++)
        printf("delta1[%c] = %d\n", delta1_chars[t], delta1[delta1_chars[t]]);
    printf("delta1[other] = %d\n", NOT_FOUND);
#endif
}

// true if the suffix of word starting from word[pos] is a prefix
// of word
int is_prefix(uint8_t *word, int wordlen, int pos) {
    int i;
    int suffixlen = wordlen - pos;
    
    for (i=0; i < suffixlen; i++) {
        if (word[i] != word[pos+i]) {
            return 0;
        }
    }
    return 1;
}

// length of the longest suffix of word ending on word[pos].
// suffix_length("dddbcabc", 8, 4) = 2
int suffix_length(uint8_t *word, int wordlen, int pos) {
    int i;
    // increment suffix length i to the first mismatch or beginning
    // of the word
    for (i = 0; (word[pos-i] == word[wordlen-1-i]) && (i < pos); i++);
    return i;
}

// delta2 table: given a mismatch at pat[pos], we want to align
// with the next possible full match could be based on what we
// know about pat[pos+1] to pat[patlen-1].
//
// In case 1:
// pat[pos+1] to pat[patlen-1] does not occur elsewhere in pat,
// the next plausible match starts at or after the mismatch.
// If, within the substring pat[pos+1 .. patlen-1], lies a prefix
// of pat, the next plausible match is here (if there are multiple
// prefixes in the substring, pick the longest). Otherwise, the
// next plausible match starts past the character aligned with
// pat[patlen-1].
//
// In case 2:
// pat[pos+1] to pat[patlen-1] does occur elsewhere in pat. The
// mismatch tells us that we are not looking at the end of a match.
// We may, however, be looking at the middle of a match.
//
// The first loop, which takes care of case 1, is analogous to
// the KMP table, adapted for a 'backwards' scan order with the
// additional restriction that the substrings it considers as
// potential prefixes are all suffixes. In the worst case scenario
// pat consists of the same letter repeated, so every suffix is
// a prefix. This loop alone is not sufficient, however:
// Suppose that pat is "ABYXCDEYX", and text is ".....ABYXCDEYX".
// We will match X, Y, and find B != E. There is no prefix of pat
// in the suffix "YX", so the first loop tells us to skip forward
// by 9 characters.
// Although superficially similar to the KMP table, the KMP table
// relies on information about the beginning of the partial match
// that the BM algorithm does not have.
//
// The second loop addresses case 2. Since suffix_length may not be
// unique, we want to take the minimum value, which will tell us
// how far away the closest potential match is.
void make_delta2(int *delta2, uint8_t *pat, int32_t patlen) {
    int p;
    int last_prefix_index = 1;
    
    // first loop, prefix pattern
    for (p=patlen-1; p>=0; p--) {
        if (is_prefix(pat, patlen, p+1)) {
            last_prefix_index = p+1;
        }
        delta2[p] = (patlen-1 - p) + last_prefix_index;
    }
    
    // this is overly cautious, but will not produce anything wrong
    // second loop, suffix pattern
    for (p=0; p < patlen-1; p++) {
        int slen = suffix_length(pat, patlen, p);
        if (pat[p - slen] != pat[patlen-1 - slen]) {
            delta2[patlen-1 - slen] = patlen-1 - p + slen;
        }
    }
#ifdef DEBUG
    int t;
    printf ("\n");
    for (t=0; t < patlen; t++) {
        printf("delta2[%c]: %d\n", pat[t], delta2[t]);
    }
#endif
}

uint32_t boyer_moore (uint8_t *string, uint32_t stringlen, uint8_t *pat, uint32_t patlen) {
    int i;
    int delta1[ALPHABET_LEN];
    int *delta2 = malloc(patlen * sizeof(int));
    make_delta1(delta1, pat, patlen);
    make_delta2(delta2, pat, patlen);
    int n_shifts = 0;
    chars_compared = 0;
#ifdef DEBUG
    printf ("\n");
#endif
    i = patlen-1;
    while (i < stringlen) {
        int j = patlen-1;
        while (j >= 0 && (string[i] == pat[j])) {
            --i;
            --j;
            chars_compared++;
        }
        if (j < 0) {
            free(delta2);
            return (uint32_t) i+1;
        }
        chars_compared++;
#ifdef DEBUG
        n_shifts++;
        if (delta1[string[i]] > delta2[j]) {
            printf("shift #%d, using delta1, shifting by %d\n", n_shifts, delta1[string[i]]);
        } else {
            printf("shift #%d, using delta2, shifting by %d\n", n_shifts, delta2[j]);
        }
#endif
        
        i += max(delta1[string[i]], delta2[j]);
    }
    free(delta2);
    return 0;
}

//void test(uint8_t *string, uint8_t *pat) {
//    printf("-------------------------------------------------------\n");
//    printf("Looking for '%s' in '%s':\n", pat, string);
//    
//    uint32_t pos = boyer_moore(string, strlen(string), pat, strlen(pat));
//#ifdef DEBUG
//    printf("\n");
//#endif
//    if (pos == 0 && chars_compared != strlen(pat))
//        printf("Not Found - ");
//    else
//        printf("Found at position %u - ", pos);
//    printf("%d chars compared.\n", chars_compared);
//}
//
//int main(int argc, char const *argv[]) {
//    test(".....ABYXCDEYX", "ABYXCDEYX");
//    test("WHICH-FINALLY-HALTT-THAT", "TT-THAT");
//    test("....ccbc.zbc", "ccbc.zbc");
//    test("...........................", "ABYXCDEYX");
//    test("..cbcabcabc", "bcabcabc");
//    test("..adbdadbda", "adbda");
//    test("test is good", "test");
//    
//    return 0;
//}

// This is a popular one - I'll find a few versions
// ONE
void preBmBc(char *x, int m, int bmBc[]) {
    int i;
    for (i = 0; i < ASIZE; ++i)
        bmBc[i] = m;
    for (i = 0; i < m - 1; ++i)
        bmBc[x[i]] = m - i - 1;
}


void suffixes(char *x, int m, int *suff) {
    int f = 0, g, i;
    
    suff[m - 1] = m;
    g = m - 1;
    for (i = m - 2; i >= 0; --i) {
        if (i > g && suff[i + m - 1 - f] < i - g)
            suff[i] = suff[i + m - 1 - f];
        else {
            if (i < g)
                g = i;
            f = i;
            while (g >= 0 && x[g] == x[g + m - 1 - f])
                --g;
            suff[i] = f - g;
        }
    }
}

void preBmGs(char *x, int m, int bmGs[]) {


    int i, j, suff[XSIZE];
    
    suffixes(x, m, suff);
    
    for (i = 0; i < m; ++i)
        bmGs[i] = m;
    j = 0;
    for (i = m - 1; i >= 0; --i)
        if (suff[i] == i + 1)
            for (; j < m - 1 - i; ++j)
                if (bmGs[j] == m)
                    bmGs[j] = m - 1 - i;
    for (i = 0; i <= m - 2; ++i)
        bmGs[m - 1 - suff[i]] = m - 1 - i;
}


void MTKBM(char *x, char *y, int* output) {
    
    int m = (int)strlen(x);
    int n = (int)strlen(y);
    int p = 0;
    int i, j, bmGs[XSIZE], bmBc[ASIZE];
    
    /* Preprocessing */
    preBmGs(x, m, bmGs);
    preBmBc(x, m, bmBc);
    
    /* Searching */
    j = 0;
    while (j <= n - m) {
        for (i = m - 1; i >= 0 && x[i] == y[i + j]; --i);
        if (i < 0) {
            output[p]=j;
                   printf ("\n Boyer-MoorePattern found at index %d", j);
            p++;
         //   OUTPUT(j);
            j += bmGs[0];
        }
        else
            j += MAX(bmGs[i], bmBc[y[i + j]] - m + 1 + i);
    }
}


# define NO_OF_CHARS 256
// A utility function to get maximum of two integers
int max(int a, int b)
{
    return (a > b) ? a : b;
}

// The preprocessing function for Boyer Moore's bad character heuristic
void badCharHeuristic(char *str, int size, int badchar[NO_OF_CHARS])
{
    int i;
    
    // Initialize all occurrences as -1
    for (i = 0; i < NO_OF_CHARS; i++)
        badchar[i] = -1;
    
    // Fill the actual value of last occurrence of a character
    for (i = 0; i < size; i++)
        badchar[(int) str[i]] = i;
}

void MTKBoyerMoore2(char *txt, char *pat, int * output)
{
    int m = (int)strlen(pat);
    int n = (int)strlen(txt);
    int p = 0;
    int badchar[NO_OF_CHARS];
    
    badCharHeuristic(pat, m, badchar);
    
    int s = 0; // s is shift of the pattern with respect to text
    while (s <= (n - m))
        {
        int j = m - 1;
        
        while (j >= 0 && pat[j] == txt[s + j])
            j--;
        
        if (j < 0)
            {
            printf("\n pattern occurs at shift = %d", s);
            output[p] = s;
            p++;
            s += (s + m < n) ? m - badchar[txt[s + m]] : 1;
            
            }
        
        else
            s += max(1, j - badchar[txt[s + j]]);
        }
}
//
//
//
/////* Driver program to test above funtion */
////int main()
////{
////    char txt[] = "ABAAABCD";
////    char pat[] = "ABC";
////    bsearch(txt, pat);
////    return 0;
////}


@end
