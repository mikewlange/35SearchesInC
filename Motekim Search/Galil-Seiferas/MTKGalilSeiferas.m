//
//  MTKGalilSeiferas.m
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Coppyright © 2017 motekim. All rights reserved.
//

#import "MTKGalilSeiferas.h"
#import "includeme.h"
@implementation MTKGalilSeiferas

char *x, *y;
int k, m, n, pp, pp1, pp2, q, q1, q2, s;
int* outpput2 = 0;
int localcount = 0;
#define XSIZE   20
#define ASIZE   256
void search() {
    while (pp <= n - m) {
        while (pp + s + q < n && x[s + q] == y[pp + s + q])
            ++q;
        if (q == m - s && memcmp(x, y + pp, s + 1) == 0)
            outpput2[localcount]=pp;localcount++;
            if (q == pp1 + q1) {
                pp += pp1;
                q -= pp1;
            }
            else {
                pp += (q/k + 1);
                q = 0;
            }
    }
}


void pparse() {
    while (1) {
        while (x[s + q1] == x[s + pp1 + q1])
            ++q1;
        while (pp1 + q1 >= k*pp1) {
            s += pp1;
            q1 -= pp1;
        }
        pp1 += (q1/k + 1);
        q1 = 0;
        if (pp1 >= pp2)
            break;
    }
    aanewpp1();
}


void aanewpp2() {
    while (x[s + q2] == x[s + pp2 + q2] && pp2 + q2 < k*pp2)
        ++q2;
    if (pp2 + q2 == k*pp2)
        pparse();
    else
        if (s + pp2 + q2 == m)
            search();
        else {
            if (q2 == pp1 + q1) {
                pp2 += pp1;
                q2 -= pp1;
            }
            else {
                pp2 += (q2/k + 1);
                q2 = 0;
            }
            aanewpp2();
        }
}


void aanewpp1() {
    while (x[s + q1] == x[s + pp1 + q1])
        ++q1;
    if (pp1 + q1 >= k*pp1) {
        pp2 = q1;
        q2 = 0;
        aanewpp2();
    }
    else {
        if (s + pp1 + q1 == m)
            search();
        else {
            pp1 += (q1/k + 1);
            q1 = 0;
            aanewpp1();
        }
    }
}


void GS(char *argX, int argM, char *argY, int argN, int* outpput) {
    x = argX;
    m = argM;
    y = argY;
    n = argN;
    k = 4;
    pp = q = s = q1 = pp2 = q2 = 0;
    pp1 = 1;
    outpput = outpput2;
    aanewpp1();
}
@end


