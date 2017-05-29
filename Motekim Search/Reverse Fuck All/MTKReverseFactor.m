//
//  MTKReverseFactor.m
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//

#import "MTKReverseFactor.h"
#import "includeme.h"
#import "util.h"
@implementation MTKReverseFactor

#define XSIZE   20
#define ASIZE   256

void buildSuffixAutomaton(char *x, int m, Graph aut) {
    int i, art, init, last, p, q, r;
    char c;
    
    init = getInitial(aut);
    art = newVertex(aut);
    setSuffixLink(aut, init, art);
    last = init;
    for (i = 0; i < m; ++i) {
        c = x[i];
        p = last;
        q = newVertex(aut);
        setLength(aut, q, getLength(aut, p) + 1);
        setPosition(aut, q, getPosition(aut, p) + 1);
        while (p != init &&
               getTarget(aut, p, c) == UNDEFINED) {
            setTarget(aut, p, c, q);
            setShift(aut, p, c, getPosition(aut, q) -
                     getPosition(aut, p) - 1);
            p = getSuffixLink(aut, p);
        }
        if (getTarget(aut, p, c) == UNDEFINED) {
            setTarget(aut, init, c, q);
            setShift(aut, init, c,
                     getPosition(aut, q) -
                     getPosition(aut, init) - 1);
            setSuffixLink(aut, q, init);
        }
        else
            if (getLength(aut, p) + 1 ==
                getLength(aut, getTarget(aut, p, c)))
                setSuffixLink(aut, q, getTarget(aut, p, c));
            else {
                r = newVertex(aut);
                copyVertex(aut, r, getTarget(aut, p, c));
                setLength(aut, r, getLength(aut, p) + 1);
                setSuffixLink(aut, getTarget(aut, p, c), r);
                setSuffixLink(aut, q, r);
                while (p != art &&
                       getLength(aut, getTarget(aut, p, c)) >=
                       getLength(aut, r)) {
                    setShift(aut, p, c,
                             getPosition(aut,
                                         getTarget(aut, p, c)) -
                             getPosition(aut, p) - 1);
                    setTarget(aut, p, c, r);
                    p = getSuffixLink(aut, p);
                }
            }
        last = q;
    }
    setTerminal(aut, last);
    while (last != init) {
        last = getSuffixLink(aut, last);
        setTerminal(aut, last);
    }
}


char *reverse(char *x, int m) {
    char *xR;
    int i;
    
    xR = (char *)malloc((m + 1)*sizeof(char));
    for (i = 0; i < m; ++i)
        xR[i] = x[m - 1 - i];
    xR[m] = '\0';
    return(xR);
}
void preMps(char *x, int m, int mpNext[]) {
    int i, j;
    
    i = 0;
    j = mpNext[0] = -1;
    while (i < m) {
        while (j > -1 && x[i] != x[j])
            j = mpNext[j];
        mpNext[++i] = ++j;
    }
}


void RF(char *x, int m, char *y, int n, int*output) {
    int period, i, j, shift, u, periodOfU, disp, init,
    state, mu, mpNext[XSIZE + 1];
    char *xR;
    Graph aut;
    int p = 0;
    /* Preprocessing */
    aut = newSuffixAutomaton(2*(m + 2), 2*(m + 2)*ASIZE);
    xR = reverse(x, m);
    buildSuffixAutomaton(xR, m, aut);
    init = getInitial(aut);
    preMps(x, m, mpNext);
    period = m - mpNext[m];
    i = 0;
    shift = m;
    
    /* Searching */
    j = 0;
    while (j <= n - m) {
        i = m - 1;
        state = init;
        u = m - 1 - shift;
        periodOfU = (shift != m ?
                     m - shift - mpNext[m - shift] : 0);
        shift = m;
        disp = 0;
        while (i > u &&
               getTarget(aut, state, y[i + j]) !=
               UNDEFINED) {
            disp += getShift(aut, state, y[i + j]);
            state = getTarget(aut, state, y[i + j]);
            if (isTerminal(aut, state))
                shift = i;
            --i;
        }
        if (i <= u)
            if (disp == 0) {
                output[p] = j;
                p++;
                shift = period;
            }
            else {
                mu = (u + 1)/2;
                if (periodOfU <= mu) {
                    u -= periodOfU;
                    while (i > u &&
                           getTarget(aut, state, y[i + j]) !=
                           UNDEFINED) {
                        disp += getShift(aut, state, y[i + j]);
                        state = getTarget(aut, state, y[i + j]);
                        if (isTerminal(aut, state))
                            shift = i;
                        --i;
                    }
                    if (i <= u)
                        shift = disp;
                }
                else {
                    u = u - mu - 1;
                    while (i > u &&
                           getTarget(aut, state, y[i + j]) !=
                           UNDEFINED) {
                        disp += getShift(aut, state, y[i + j]);
                        state = getTarget(aut, state, y[i + j]);
                        if (isTerminal(aut, state))
                            shift = i;
                        --i;
                    }
                }
            }
        j += shift;
    }
}

//void RF(char *x, int m, char *y, int n, int* output) {
//    int p =0;
//    int i, j, shift, period, init, state;
//    Graph aut;
//    char *xR;
//    
//    /* Preprocessing */
//    aut = newSuffixAutomaton(2*(m + 2), 2*(m + 2)*ASIZE);
//    xR = reverse(x, m);
//    buildSuffixAutomaton(xR, m, aut);
//    init = getInitial(aut);
//    period = m;
//    
//    /* Searching */
//    j = 0;
//    while (j <= n - m) {
//        i = m - 1;
//        state = init;
//        shift = m;
//        while (i + j >= 0 &&
//               getTarget(aut, state, y[i + j]) !=
//               UNDEFINED) {
//            state = getTarget(aut, state, y[i + j]);
//            if (isTerminal(aut, state)) {
//                period = shift;
//                shift = i;
//            }
//            --i;
//        }
//        if (i < 0) {
//            output[p] = (j);
//            p++;
//            shift = period;
//        }
//        j += shift;
//    }
//}



@end
