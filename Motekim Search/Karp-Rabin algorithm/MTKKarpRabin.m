//
//  MOTKarpRabin.m
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//

#import "MTKKarpRabin.h"
#import "MTKdfaa.h"
#import "util.h"
#include <string.h> // strlen
#include <stdlib.h> // malloc / free
#include <stdint.h>
#include <stdio.h>
#include <math.h>
#include <limits.h>
@implementation MTKKarpRabin

/////////////////////////////
//+++++++++++++++++++++++++++

//Karp-Rabin algorithm

//+++++++++++++++++++++++++++
/////////////////////////////

//+++++++++++++++++++++++++++
//Main features
//+++++++++++++++++++++++++++
//-uses an hashing function;
//-preprocessing phase in O(m) time complexity and constant space;
//-searching phase in O(mn) time complexity;
//-O(n+m) expected running time.

////+++++++++++++++++++++++++++
//Description
////+++++++++++++++++++++++++++
//-Hashing provides a simple method to avoid a quadratic number of character comparisons in most practical situations. Instead of checking at each position of the text if the pattern occurs, it seems to be more efficient to check only if the contents of the window “looks like” the pattern. In order to check the resemblance between these two words an hashing function is used.
//
//-To be helpful for the string matching problem an hashing function hash should have the following properties:
//efficiently computable;
//highly discriminating for strings;
//hash(y[j+1 .. j+m]) must be easily computable from hash(y[j .. j+m-1]) and y[j+m]:
//hash(y[j+1 .. j+m])= rehash(y[j], y[j+m], hash(y[j .. j+m-1]).
//-For a word w of length m let hash(w) be defined as follows:
// hash(w[0 .. m-1])=(w[0]*2m-1+ w[1]*2m-2+···+ w[m-1]*20) mod q
// where q is a large number.
// Then, rehash(a,b,h)= ((h-a*2m-1)*2+b) mod q
//
//- The preprocessing phase of the Karp-Rabin algorithm consists in computing hash(x). It can be done in constant space and O(m) time.
//- During searching phase, it is enough to compare hash(x) with hash(y[j .. j+m-1]) for 0 leq j < n-m. If an equality is found, it is still necessary to check the equality x=y[j .. j+m-1] character by character.
//- The time complexity of the searching phase of the Karp-Rabin algorithm is O(mn) (when searching for am in an for instance). Its expected number of text character comparisons is O(n+m).

//In the following function KR all the multiplications by 2 are implemented by shifts. Furthermore, the computation of the modulus function is avoided by using the implicit modular arithmetic given by the hardware that forgets carries in integer operations. So, q is chosen as the maximum value for an integer.
// There are many inplimnetations of this here is the one whre i got the descriptions from

// Another implimentation
// d is the number of characters in input alphabet
#define d 256
/* pat -> pattern
 txt -> text
 q -> A prime number
 */
int outloop;
void KRsearch(char pat[], char txt[], int q, int *outLst)
{
    int M = (int)strlen(pat);
    int N = (int)strlen(txt);
    int i, j;
    int p = 0; // hash value for pattern
    int t = 0; // hash value for txt
    int h = 1;
    outloop=0;
    // The value of h would be "pow(d, M-1)%q"
    for (i = 0; i < M-1; i++)
    h = (h*d)%q;
    
    // Calculate the hash value of pattern and first
    // window of text
    for (i = 0; i < M; i++)
    {
    p = (d*p + pat[i])%q;
    t = (d*t + txt[i])%q;
    }
    
    // Slide the pattern over text one by one
    for (i = 0; i <= N - M; i++)
    {
    
    // Check the hash values of current window of text
    // and pattern. If the hash values match then only
    // check for characters on by oif)
    if ( p == t )
        {
        /* Check for characters one by one */
        for (j = 0; j < M; j++)
            {
            if (txt[i+j] != pat[j])
            break;
            }
        
        // if p == t and pat[0...M-1] = txt[i, i+1, ...i+M-1]
        if (j == M){
                      printf("KRsearch Found pattern at index %d \n",i);
            outLst[outloop]= i;
            outloop++;
            
        }
        }
    
    // Calculate hash value for next window of text: Remove
    // leading digit, add trailing digit
    if ( i < N-M )
        {
        t = (d*(t - txt[i]*h) + txt[i+M])%q;
        
        // We might get negative value of t, converting it
        // to positive
        if (t < 0)
        t = (t + q);
        }
    }
}
/* Driver program to test above function */
//int main()
//{
//    char txt[] = "GEEKS FOR GEEKS";
//    char pat[] = "GEEK";
//    int q = 101; // A prime number
//    search(pat, txt, q);
//    return 0;
//}

//#define REHASH(a, b, h) ((((h) - (a)*d) << 1) + (b))
//int krinLoop;
//// BUST!!!
//void KR(char *x, char *y, int *outLst) {
//    int d, hx, hy, i, j;
//
//    int M = (int)strlen(x);
//    int N = (int)strlen(y);
//    /* Preprocessing */
//    /* computes d = 2^(m-1) with
//     the left-shift operator */
//    for (d = i = 1; i < M; ++i)
//    d = (d<<1);
//
//    for (hy = hx = i = 0; i < M; ++i) {
//        hx = ((hx<<1) + x[i]);
//        hy = ((hy<<1) + y[i]);
//    }
//
//    /* Searching */
//    j = 0;krinLoop=0;
//    while (j <=  N-M) {
//        if (hx == hy && memcmp(x, y + j, M) == 0){
//                printf("KR Found pattern at index %d \n",j);
//            outLst[krinLoop]=j;
//            krinLoop++;
//            hy = REHASH(y[j], y[j + M], hy);
//            ++j;
//
//        }
//    }
//
//}

@end
