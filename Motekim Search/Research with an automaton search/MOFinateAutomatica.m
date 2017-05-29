//
//  MOFinateAutomatica.m
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//

//Research with an automaton search

// WHAT?
//builds the minimal deterministic automaton recognizing the language Sigma*x;
//extra space in O(msigma) if the automaton is stored in a direct access table;
//preprocessing phase in O(msigma) time complexity;
//searching phase in O(n) time complexity if the automaton is stored in a direct access table, O(nlog(sigma)) otherwise.


// Go on ...
//Searching a word x with an automaton consists first in building the minimal Deterministic Finite Automaton (DFA)  A(x) recognizing the language Sigma*x.
//The DFA  A(x) =(Q, q0, T, E) recognizing the language Sigma*x is defined as follows:
//Q is the set of all the prefixes of x: Q={epsilon, x[0], x[0 .. 1], ... , x[0 .. m-2], x};
//q0=epsilon;
//T={x};
//for q in Q (q is a prefix of x) and a in Sigma, (q, a, qa) is in E if and only if qa is also a prefix of x, otherwise (q, a, p) is in E such that p is the longest suffix of qa which is a prefix of x.
//The DFA  A(x) can be constructed in O(m+sigma) time and O(msigma) space.
//Once the DFA  A(x) is build, searching for a word x in a text y consists in parsing the text y with the DFA  A(x) beginning with the initial state q0. Each time the terminal state is encountered an occurrence of x is reported.
//The searching phase can be performed in O(n) time if the automaton is stored in a direct access table, in O(nlog(sigma)) otherwise.


// Go on... http://www-igm.univ-mlv.fr/~lecroq/string/node4.html#SECTION0040

// Go on ..
#import "MOFinateAutomatica.h"
#include<stdio.h>
#include<string.h>
#define NO_OF_CHARS 256


@implementation MOFinateAutomatica 


/* This function builds the TF table which represents Finite Automata for a
 given pattern  */
void computeTransFun(char *pat, int M, int TF[][NO_OF_CHARS])
{
    int i, lps = 0, x;
    
    // Fill entries in first row
    for (x =0; x < NO_OF_CHARS; x++)
    TF[0][x] = 0;
    TF[0][pat[0]] = 1;
    
    // Fill entries in other rows
    for (i = 1; i<= M; i++)
    {
    // Copy values from row at index lps
    for (x = 0; x < NO_OF_CHARS; x++)
    TF[i][x] = TF[lps][x];
    
    // Update the entry corresponding to this character
    TF[i][pat[i]] = i + 1;
    
    // Update lps for next row to be filled
    if (i < M)
    lps = TF[lps][pat[i]];
    }
}

/* Prints all occurrences of pat in txt */
void FAsearch(char *pat, char *txt,int *x)
{
    int M = (int)strlen(pat);
    int N = (int)strlen(txt);
    int y = 0;
    int TF[M+1][NO_OF_CHARS];
    
    computeTransFun(pat, M, TF);
    
    // process text over FA.
    int i, j=0;
    for (i = 0; i < N; i++)
    {
    j = TF[j][txt[i]];
    if (j == M)
        {
        x[y] = i-M+1;
        y++;
        printf ("\n pattern found at index %d", i-M+1);
        }
    }
}

/* Driver program to test above function */
//int main()
//{
//    char *txt = "GEEKS FOR GEEKS";
//    char *pat = "GEEKS";
//    FAsearch(pat, txt);
//    getchar();
//    return 0;
//}
@end
