//
//  MTKHASHq.m
//  Motekim Search
//
//  Created by Michael Lange on 5/29/17.
//  Copyright © 2017 motekim. All rights reserved.
//

#import "MTKHASHq.h"
#import "includeme.h"
@implementation MTKHASHq


#define RANK3 3

int searchHash3(unsigned char *x, int m, unsigned char *y, int n, int* rcOut) {
    int count, j, i, sh, sh1, mMinus1, mMinus2, shift[WSIZE];
    unsigned char h;
    if (m<3) return -1;
    count = 0;
    mMinus1 = m-1;
    mMinus2 = m-2;
    int pp = 0;
    /* Preprocessing */
    for (i = 0; i < WSIZE; ++i)
        shift[i] = mMinus2;
    
    h = x[0];
    h = ((h<<1) + x[1]);
    h = ((h<<1) + x[2]);
    shift[h] = m-RANK3;
    for (i=RANK3; i < mMinus1; ++i) {
        h = x[i-2];
        h = ((h<<1) + x[i-1]);
        h = ((h<<1) + x[i]);
        shift[h] = mMinus1-i;
    }
    h = x[i-2];
    h = ((h<<1) + x[i-1]);
    h = ((h<<1) + x[i]);
    sh1 = shift[h];
    shift[h] = 0;
    if (sh1==0) sh1=1;
    
    
    /* Searching */
    i = mMinus1;
    memcpy(y+n, x, m);
    while (1) {
        sh = 1;
        while (sh != 0) {
            h = y[i-2];
            h = ((h<<1) + y[i-1]);
            h = ((h<<1) + y[i]);
            sh = shift[h];
            i+=sh;
        }
        if (i < n) {
            j=0;
            while(j<m && x[j]==y[i-mMinus1+j]) j++;
            if (j>=m) {
                rcOut[pp]=i-mMinus1;
                pp++;
               // rcOutUT(i-mMinus1);
            } 
            i+=sh1; 
        } 
        else return count; 
    } 
}


#define RANK5 5

int searchHash5(unsigned char *x, int m, unsigned char *y, int n,int* rcOut) {
    int count,i, j,sh, shift[WSIZE], sh1, mMinus1, mMinus4;
    unsigned int h;
    if (m<5) return -1;
    
    /* Preprocessing */
    count = 0;
    mMinus1 = m-1;
    mMinus4 = m-4;
    int pp = 0;
    for (i = 0; i < WSIZE; ++i)
        shift[i] = mMinus4;
    
    h = x[0];
    h = ((h<<1) + x[1]);
    h = ((h<<1) + x[2]);
    h = ((h<<1) + x[3]);
    h = ((h<<1) + x[4]);
    shift[h%WSIZE] = m-RANK5;
    for (i=RANK5; i < mMinus1; ++i) {
        h = x[i-4];
        h = ((h<<1) + x[i-3]);
        h = ((h<<1) + x[i-2]);
        h = ((h<<1) + x[i-1]);
        h = ((h<<1) + x[i]);
        shift[h%WSIZE] = mMinus1-i;
    }
    h = x[i-4];
    h = ((h<<1) + x[i-3]);
    h = ((h<<1) + x[i-2]);
    h = ((h<<1) + x[i-1]);
    h = ((h<<1) + x[i]);
    sh1 = shift[h%WSIZE];
    shift[h%WSIZE] = 0;
    if (sh1==0) sh1=1;
    
    /* Searching */
    i = mMinus1;
    memcpy(y+n, x, m);
    while (1) {
        sh = 1;
        while (sh != 0) {
            h = y[i-4];
            h = ((h<<1) + y[i-3]);
            h = ((h<<1) + y[i-2]);
            h = ((h<<1) + y[i-1]);
            h = ((h<<1) + y[i]);
            sh = shift[h%WSIZE];
            i+=sh;
        }
        if (i < n) {
            j=0;
            while(j<m && x[j]==y[i-mMinus1+j]) j++;
            if (j>=m) {
                rcOut[pp]=i-mMinus1;
                pp++;
              //  rcOutUT(i-mMinus1);
            } 
            i+=sh1; 
        } 
        else return count; 
    } 
}

#define RANK8 8

int searchHash8(unsigned char *x, int m, unsigned char *y, int n,int* rcOut){
    int i, j, sh, shift[WSIZE], sh1, mMinus1, mMinus7, count;
    unsigned int h;
    if (m<8) return -1;
    
    /* Preprocessing */
    count = 0;
    mMinus1 = m-1;
    mMinus7 = m-7;
    int pp  = 0;
    for (i = 0; i < WSIZE; ++i)
        shift[i] = mMinus7;
    
    h = x[0];
    h = ((h<<1) + x[1]);
    h = ((h<<1) + x[2]);
    h = ((h<<1) + x[3]);
    h = ((h<<1) + x[4]);
    h = ((h<<1) + x[5]);
    h = ((h<<1) + x[6]);
    h = ((h<<1) + x[7]);
    shift[h%WSIZE] = m-RANK8;
    for (i=RANK8; i < mMinus1; ++i) {
        h = x[i-7];
        h = ((h<<1) + x[i-6]);
        h = ((h<<1) + x[i-5]);
        h = ((h<<1) + x[i-4]);
        h = ((h<<1) + x[i-3]);
        h = ((h<<1) + x[i-2]);
        h = ((h<<1) + x[i-1]);
        h = ((h<<1) + x[i]);
        shift[h%WSIZE] = mMinus1-i;
    }
    h = x[i-7];
    h = ((h<<1) + x[i-6]);
    h = ((h<<1) + x[i-5]);
    h = ((h<<1) + x[i-4]);
    h = ((h<<1) + x[i-3]);
    h = ((h<<1) + x[i-2]);
    h = ((h<<1) + x[i-1]);
    h = ((h<<1) + x[i]);
    sh1 = shift[h%WSIZE];
    shift[h%WSIZE] = 0;
    if (sh1==0) sh1=1;
    
    /* Searching */
    i = mMinus1;
    memcpy(y+n, x, m);
    while (1) {
        sh = 1;
        while (sh != 0) {
            h = y[i-7];
            h = ((h<<1) + y[i-6]);
            h = ((h<<1) + y[i-5]);
            h = ((h<<1) + y[i-4]);
            h = ((h<<1) + y[i-3]);
            h = ((h<<1) + y[i-2]);
            h = ((h<<1) + y[i-1]);
            h = ((h<<1) + y[i]);
            sh = shift[h%WSIZE];
            i+=sh;
        }
        if (i < n) {
            j=0;
            while(j<m && x[j]==y[i-mMinus1+j]) j++;
            if (j>=m) {
                rcOut[pp]=i-mMinus1;
                pp++;
               // rcOutUT(i-mMinus1);
            } 
            i+=sh1; 
        } 
        else return count; 
    } 
}

@end
