//
//  dfaa.m
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//

#import "MTKdfaa.h"
#import "includeme.h"

@implementation MTKdfaa   // Deterministic Finite Automaton algorithm


/////////////////////////////
//+++++++++++++++++++++++++++

// Deterministic Finite Automaton algorithm

//+++++++++++++++++++++++++++
/////////////////////////////

// Deterministic Finite Automaton algorithm
//
//Main features
//builds the minimal deterministic automaton recognizing the language Sigma*x;
//extra space in O(msigma) if the automaton is stored in a direct access table;
//preprocessing phase in O(msigma) time complexity;
//searching phase in O(n) time complexity if the automaton is stored in a direct access table, O(nlog(sigma)) otherwise.
//
//Description
//Searching a word x with an automaton consists first in building the minimal Deterministic Finite Automaton (DFA)  A(x) recognizing the language Sigma*x.
//
//The DFA  A(x) =(Q, q0, T, E) recognizing the language Sigma*x is defined as follows:
//  Q is the set of all the prefixes of x: Q={epsilon, x[0], x[0 .. 1], ... , x[0 .. m-2], x};
//  q0=epsilon;
//  T={x};
//  for q in Q (q is a prefix of x) and a in Sigma, (q, a, qa) is in E if and only if qa is also a prefix of x, otherwise (q, a, p) is in E such that p is the longest suffix of qa which is a prefix of x.
//
//The DFA  A(x) can be constructed in O(m+sigma) time and O(msigma) space.
//
//Once the DFA  A(x) is build, searching for a word x in a text y consists in parsing the text y with the DFA  A(x) beginning with the initial state q0. Each time the terminal state is encountered an occurrence of x is reported.
//
//The searching phase can be performed in O(n) time if the automaton is stored in a direct access table, in O(nlog(sigma)) otherwise.

// v2 - 1 looks busted

#define NO_OF_CHARS 256
int getNextState(char *pat, int M, int state, int x)
{
    // If the character c is same as next character in pattern,
    // then simply increment state
    if (state < M && x == pat[state])
    return state+1;
    
    int ns, i; // ns stores the result which is next state
    
    // ns finally contains the longest prefix which is also suffix
    // in "pat[0..state-1]c"
    
    // Start from the largest possible value and stop when you find
    // a prefix which is also suffix
    for (ns = state; ns > 0; ns--)
    {
    if(pat[ns-1] == x)
        {
        for(i = 0; i < ns-1; i++)
            {
            if (pat[i] != pat[state-ns+1+i])
            break;
            }
        if (i == ns-1)
        return ns;
        }
    }
    
    return 0;
}

/* This function builds the TF table which represents Finite Automata for a
 given pattern */
void computeTF(char *pat, int M, int TF[][NO_OF_CHARS])
{
    int state, x;
    for (state = 0; state <= M; ++state)
    for (x = 0; x < NO_OF_CHARS; ++x)
    TF[state][x] = getNextState(pat, M, state, x);
}

/* Prints all occurrences of pat in txt */
void MTKDFAAsearch(char *pat, int M, char *txt,int N, int *output)
{

    
    int loop=0;
    int TF[M+1][NO_OF_CHARS];
    
    computeTF(pat, M, TF);
    
    // Process txt over FA.
    int i, state=0;
    for (i = 0; i < N; i++)
    {
    state = TF[state][txt[i]];
    if (state == M)
        {
        output[loop]=i-M+1;loop++;
        outp(i-M+1);
        }
    }
}
//
//test
//// Driver program to test above function
//int main()
//{
//    char *txt = "AABAACAADAABAAABAA";
//    char *pat = "AABA";
//    MLfia(pat, txt);
//    return 0;
//}

@end
