//
//  MTKGalilSeiferas.m
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Coppyright © 2017 motekim. All rights reserved.
//

#import "MTKGalilSeiferas.h"
#import "includeme.h"

// http://www-igm.univ-mlv.fr/~lecroq/string/node25.html
@implementation MTKGalilSeiferas

char *x, *y;
int k, m, n, p, p1, p2, q, q1, q2, s;
#define ASIZE   256
int rcBack[256];
int rcCount = 0;
void outppp( int pos ) {
    static int matches = 0;
    printf( "match %d found at position %d\n", ++matches, pos );
}


void search() {
    while (p <= n - m) {
        while (p + s + q < n && x[s + q] == y[p + s + q])
            ++q;
        if (q == m - s && memcmp(x, y + p, s + 1) == 0){
            outppp(p);
        rcBack[rcCount] = p;
        rcCount++;
        }
        if (q == p1 + q1) {
            p += p1;
            q -= p1;
        }
        else {
            p += (q/k + 1);
            q = 0;
        }
    }
}


void parse() {
    while (1) {
        while (x[s + q1] == x[s + p1 + q1])
            ++q1;
        while (p1 + q1 >= k*p1) {
            s += p1;
            q1 -= p1;
        }
        p1 += (q1/k + 1);
        q1 = 0;
        if (p1 >= p2)
            break;
    }
    newP1();
}


void newP2() {
    while (x[s + q2] == x[s + p2 + q2] && p2 + q2 < k*p2)
        ++q2;
    if (p2 + q2 == k*p2)
        parse();
    else
        if (s + p2 + q2 == m)
            search();
        else {
            if (q2 == p1 + q1) {
                p2 += p1;
                q2 -= p1;
            }
            else {
                p2 += (q2/k + 1);
                q2 = 0;
            }
            newP2();
        }
}


void newP1() {
    while (x[s + q1] == x[s + p1 + q1])
        ++q1;
    if (p1 + q1 >= k*p1) {
        p2 = q1;
        q2 = 0;
        newP2();
    }
    else {
        if (s + p1 + q1 == m)
            search();
        else {
            p1 += (q1/k + 1);
            q1 = 0;
            newP1();
        }
    }
}


void GSGSSearch(char *argX, int argM, char *argY, int argN, int* rcQ) {
  rcQ = rcBack;
    x = argX;
    m = argM;
    y = argY;
    n = argN;
    k = 4;
    p = q = s = q1 = p2 = q2 = 0;
    p1 = 1;
    newP1();
}

@end


