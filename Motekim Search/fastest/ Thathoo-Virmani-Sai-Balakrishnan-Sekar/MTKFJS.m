//
//  MTKMTK MTKtvsbs.m
//  Motekim Search
//
//  Created by Michael Lange on 5/29/17.
//  Copyright © 2017 motekim. All rights reserved.
//

//Thathoo-Virmani-Sai-Balakrishnan-Sekar
/////////////////////////////
//+++++++++++++++++++++++++++
//Thathoo-Virmani-Sai-Balakrishnan-Sekar
//+++++++++++++++++++++++++++
/////////////////////////////
//https://www.dmi.unict.it/~faro/smart/algorithms.php?algorithm=TVSBS
//http://www.serc.iisc.ernet.in/~balki/papers/CurrentScience-2006.pdf
#import "MTKFJS.h"
#import "includeme.h"
#import "define.h"
@implementation MTKFJS

typedef unsigned char CTYPE;   // type of alphabet letters

#define ALPHA      (256)       // alphabet size
#define MAX_PATLEN (100)       // maximum pattern length

int betap[ MAX_PATLEN+1 ];
int Delta[ ALPHA ];


void makebetap( const char* p, int m ) {
    int i = 0, j = betap[0] = -1;
    
    while( i < m ) {
        while( (j > -1) && (p[i] != p[j]) )
            j = betap[j];
        if( p[++i] == p[++j] )
            betap[i] = betap[j];
        else
            betap[i] = j;
    }
}

void makeDelta( const char* p, int m ) {
    int i;
    
    for( i = 0; i < ALPHA; ++i )
        Delta[i] = m + 1;
    for( i = 0; i < m; ++i )
        Delta[ p[i] ] = m - i;
}

//The Franek Jennings Smyth algorithm
void FJS( char *p, int m,  char* x, int n, int*outt ) {
    if( m < 1 ) return;
    makebetap( p, m );
    makeDelta( p, m );
    int xx = 0;
    int i = 0, j = 0, mp = m-1, ip = mp;
    while( ip < n ) {
        if( j <= 0 ) {
            while( p[ mp ] != x[ ip ] ) {
                ip += Delta[ x[ ip+1 ] ];
                if( ip >= n ) return;
            }
            j = 0;
            i = ip - mp;
            while( (j < mp) && (x[i] == p[j]) )
                { ++i; ++j; }
            if( j == mp ) {
                    printf( "match found at position %d\n", i-mp );
                outt[xx] = i-mp;  xx++;
             //  outp( i-mp );
                ++i; ++j;
                break;
            }
            if( j <= 0 )
                ++i;
            else
                j = betap[j];
        } else {
            while( (j < m) && (x[i] == p[j]) )
                { ++i; ++j; }
            if( j == m ){
                     printf( "match found at position %d\n", i-mp );
                  outt[xx] = i-m;  xx++;
               outp( i-m );
            j = betap[j];
                      break;
            }
        }
        ip = i + mp - j;
    }
}

//int main( int argc, char** argv ) {
//    int m;
//    
//    if( argc == 3 ) {
//        if( ( m = strlen( argv[2] )) <= MAX_PATLEN )
//            FJS( (CTYPE*) argv[2], m,
//                (CTYPE*) argv[1], strlen( argv[1] ) );
//        else
//            printf( "Recompile with MAX_PATLEN >= %d\n", m );
//    } else
//        printf( "Usage: %s text pattern\n", argv[0] );
//    return 0;
//}


//// BASIC
//
//void TVSBSpreBrBc(unsigned char *x, int m, int brBc[SIGMA][SIGMA]) {
//    int a, b, i;
//    for (a = 0; a < SIGMA; ++a)
//        for (b = 0; b < SIGMA; ++b)
//            brBc[a][b] = m + 2;
//    for (a = 0; a < SIGMA; ++a)
//        brBc[a][x[0]] = m + 1;
//    for (i = 0; i < m - 1; ++i)
//        brBc[x[i]][x[i + 1]] = m - i;
//    for (a = 0; a < SIGMA; ++a)
//        brBc[x[m - 1]][a] = 1;
//}
//
//int searchBasic(unsigned char *x, int m, unsigned char *y, int n) {
//    int count, i, j = 0;
//    int BrBc[SIGMA][SIGMA];
//    unsigned char firstCh, lastCh;
//    count = 0;
//    TVSBSpreBrBc(x, m, BrBc);
//    firstCh = x[0];
//    lastCh = x[m - 1];
//    for (i = 0; i < m; i++)
//        y[n + i] = y[n + m + i] = x[i];
//    while (j <= n - m) {
//        if (lastCh == y[j + m - 1] && firstCh == y[j]) {
//            for (i = m - 2; i > 0 && x[i] == y[j + i]; i--)
//                ;
//            if (i <= 0)
//                count++;
//        }
//        j += BrBc[y[j + m]][y[j + m + 1]];
//    }
//    return count;
//}
//
//// Two Sliding Windows
//
//int searchTwoWindows( char *x, int m,  char *y, int n) {
//    int count, i, s1, s2 = 0;
//    int BrBcR[SIGMA][SIGMA], BrBcL[SIGMA][SIGMA];
//    unsigned char firstch, lastch;
//    unsigned char xr[XSIZE];
//    for (i = 0; i < m; i++)
//        xr[i] = x[m - 1 - i];
//    xr[m] = '\0';
//    count = 0;
//    TVSBSpreBrBc(x, m, BrBcR);
//    TVSBSpreBrBc(xr, m, BrBcL);
//    lastch = x[m - 1];
//    firstch = x[0];
//    int mm1 = m - 1;
//    int mp1 = m + 1;
//    
//    for (i = 0; i < m; i++)
//        y[n + i] = y[n + m + i] = x[i];
//    s1 = 0;
//    s2 = n - m;
//    while (s1 <= s2) {
//        if (firstch == y[s1] || firstch == y[s2]) {
//            if (lastch == y[s1 + mm1] || lastch == y[s2 + mm1]) {
//                i = 0;
//                while (i < m && x[i] == y[s1 + i])
//                    i++;
//                if (i == m)
//                    count++;
//                i = 0;
//                while (i < m && x[i] == y[s2 + i])
//                    i++;
//                if (i == m && s1 < s2)
//                    count++;
//            }
//        }
//        s1 += BrBcR[y[s1 + m]][y[s1 + mp1]];
//        s2 -= BrBcL[y[s2 - 1]][y[s2 - 2]];
//    }
//    return count;
//}
//
//// Four Windows
//int searchFourWin(unsigned char *x, int m, unsigned char *y, int n) {
//    int count, i, s1, s2, s3, s4, j = 0;
//    int BrBcR[SIGMA][SIGMA], BrBcL[SIGMA][SIGMA];
//    unsigned char firstch, lastch;
//    unsigned char xr[XSIZE];
//    unsigned char c;
//    for (i = 0; i < m; i++)
//        xr[i] = x[m - 1 - i];
//    xr[m] = '\0';
//    count = 0;
//    TVSBSpreBrBc(x, m, BrBcR);
//    TVSBSpreBrBc(xr, m, BrBcL);
//    int mm1 = m - 1, mp1 = m + 1;
//    firstch = x[0];
//    lastch = x[m - 1];
//    
//    for (i = 0; i < m; i++)
//        y[n + i] = y[n + m + i] = x[i];
//    int q = n / 2;
//    s1 = 0;
//    s2 = q - 1;
//    s3 = q;
//    s4 = n - m;
//    while (s1 <= s2 || s3 <= s4) {
//        if (firstch == y[s1] || firstch == y[s2] || firstch == y[s3] ||
//            firstch == y[s4]) {
//            if (lastch == y[s1 + mm1] || lastch == y[s2 + mm1] ||
//                lastch == y[s3 + mm1] || lastch == y[s4 + mm1]) {
//                i = 0;
//                while (i < m && x[i] == y[s1 + i])
//                    i++;
//                if (i == m && s1 <= s2)
//                    count++;
//                i = 0;
//                while (i < m && x[i] == y[s2 + i])
//                    i++;
//                if (i == m && s1 < s2)
//                    count++;
//                i = 0;
//                while (i < m && x[i] == y[s3 + i])
//                    i++;
//                if (i == m && s3 <= s4)
//                    count++;
//                i = 0;
//                while (i < m && x[i] == y[s4 + i])
//                    i++;
//                if (i == m && s3 < s4)
//                    count++;
//            }
//        }
//        s1 += BrBcR[y[s1 + m]][y[s1 + mp1]];
//        s2 -= BrBcL[y[s2 - 1]][y[s2 - 2]];
//        s3 += BrBcR[y[s3 + m]][y[s3 + mp1]];
//        s4 -= BrBcL[y[s4 - 1]][y[s4 - 2]];
//    }
//    return count;
//}
//
//int searchSixWindow(unsigned char *x, int m, unsigned char *y, int n) {
//    int count, i, s1, s2, s3, s4, s5, s6, j = 0;
//    int BrBcR[SIGMA][SIGMA], BrBcL[SIGMA][SIGMA];
//    unsigned char firstCh, lastCh;
//    unsigned char xr[XSIZE];
//    unsigned char c, lastch, firstch;
//    for (i = 0; i < m; i++)
//        xr[i] = x[m - 1 - i];
//    xr[m] = '\0';
//    count = 0;
//    int mp1 = m + 1, mm1 = m - 1;
//    TVSBSpreBrBc(x, m, BrBcR);
//    TVSBSpreBrBc(xr, m, BrBcL);
//    lastch = x[m - 1];
//    firstch = x[0];
//    
//    for (i = 0; i < m; i++)
//        y[n + i] = y[n + m + i] = x[i];
//    int q = n / 3;
//    s1 = 0;
//    s2 = q - 1;
//    s3 = q;
//    s4 = 2 * q - 1;
//    s5 = 2 * q;
//    s6 = n - m;
//    ;
//    while (s1 <= s2 || s3 <= s4 || s5 <= s6) {
//        if (firstch == y[s1] || firstch == y[s2] || firstch == y[s3] ||
//            firstch == y[s4] || firstch == y[s5] || firstch == y[s6]) {
//            if (lastch == y[s1 + mm1] || lastch == y[s2 + mm1] ||
//                lastch == y[s3 + mm1] || lastch == y[s4 + mm1] ||
//                lastch == y[s5 + mm1] || lastch == y[s6 + mm1]) {
//                i = 1;
//                c = x[1];
//                while (i < mm1 && (c == y[s1 + i] || c == y[s2 + i] || c == y[s3 + i] ||
//                                   c == y[s4 + i] || c == y[s5 + i] || c == y[s6 + i]))
//                    c = x[++i];
//                if (i == mm1) {
//                    i = 0;
//                    while (i < m && x[i] == y[s1 + i])
//                        i++;
//                    if (i == m && s1 <= s2)
//                        count++;
//                    i = 0;
//                    while (i < m && x[i] == y[s2 + i])
//                        i++;
//                    if (i == m && s1 < s2)
//                        count++;
//                    i = 0;
//                    while (i < m && x[i] == y[s3 + i])
//                        i++;
//                    if (i == m && s3 <= s4)
//                        count++;
//                    i = 0;
//                    while (i < m && x[i] == y[s4 + i])
//                        i++;
//                    if (i == m && s3 < s4)
//                        count++;
//                    i = 0;
//                    while (i < m && x[i] == y[s5 + i])
//                        i++;
//                    if (i == m && s5 <= s6)
//                        count++;
//                    i = 0;
//                    while (i < m && x[i] == y[s6 + i])
//                        i++;
//                    if (i == m && s5 < s6)
//                        count++;
//                }
//            }
//        }
//        s1 += BrBcR[y[s1 + m]][y[s1 + mp1]];
//        s2 -= BrBcL[y[s2 - 1]][y[s2 - 2]];
//        s3 += BrBcR[y[s3 + m]][y[s3 + mp1]];
//        s4 -= BrBcL[y[s4 - 1]][y[s4 - 2]];
//        s5 += BrBcR[y[s5 + m]][y[s5 + mp1]];
//        s6 -= BrBcL[y[s6 - 1]][y[s6 - 2]];
//    }
//    return count;
//}
//
//int searchEightWindow(unsigned char *x, int m, unsigned char *y, int n) {
//    int count, i, s1, s2, s3, s4, s5, s6, s7, s8, j = 0;
//    int BrBcR[SIGMA][SIGMA], BrBcL[SIGMA][SIGMA];
//    unsigned char firstCh, lastCh;
//    unsigned char xr[XSIZE];
//    unsigned char c;
//    for (i = 0; i < m; i++)
//        xr[i] = x[m - 1 - i];
//    xr[m] = '\0';
//    count = 0;
//    int mPlus1 = m + 1;
//    TVSBSpreBrBc(x, m, BrBcR);
//    TVSBSpreBrBc(xr, m, BrBcL);
//    
//    for (i = 0; i < m; i++)
//        y[n + i] = y[n + m + i] = x[i];
//    int q = n / 4;
//    s1 = 0;
//    s2 = q - 1;
//    s3 = q;
//    s4 = 2 * q - 1;
//    s5 = 2 * q;
//    s6 = 3 * q - 1;
//    s7 = 3 * q;
//    s8 = n - m;
//    while (s1 <= s2 || s3 <= s4 || s5 <= s6 || s7 <= s8) {
//        i = 0;
//        c = x[0];
//        while (c == y[s1 + i] | c == y[s2 + i] | c == y[s3 + i] | c == y[s4 + i] |
//               c == y[s5 + i] | c == y[s6 + i] | c == y[s7 + i] | c == y[s8 + i])
//            c = x[++i];
//        if (i >= m) {
//            i = 0;
//            while (i < m && x[i] == y[s1 + i])
//                i++;
//            if (i == m && s1 <= s2)
//                count++;
//            i = 0;
//            while (i < m && x[i] == y[s2 + i])
//                i++;
//            if (i == m && s1 < s2)
//                count++;
//            i = 0;
//            while (i < m && x[i] == y[s3 + i])
//                i++;
//            if (i == m && s3 <= s4)
//                count++;
//            i = 0;
//            while (i < m && x[i] == y[s4 + i])
//                i++;
//            if (i == m && s3 < s4)
//                count++;
//            i = 0;
//            while (i < m && x[i] == y[s5 + i])
//                i++;
//            if (i == m && s5 <= s6)
//                count++;
//            i = 0;
//            while (i < m && x[i] == y[s6 + i])
//                i++;
//            if (i == m && s5 < s6)
//                count++;
//            i = 0;
//            while (i < m && x[i] == y[s7 + i])
//                i++;
//            if (i == m && s7 <= s8)
//                count++;
//            i = 0;
//            while (i < m && x[i] == y[s8 + i])
//                i++;
//            if (i == m && s7 < s8)
//                count++;
//        }
//        s1 += BrBcR[y[s1 + m]][y[s1 + mPlus1]];
//        s2 -= BrBcL[y[s2 - 1]][y[s2 - 2]];
//        s3 += BrBcR[y[s3 + m]][y[s3 + mPlus1]];
//        s4 -= BrBcL[y[s4 - 1]][y[s4 - 2]];
//        s5 += BrBcR[y[s5 + m]][y[s5 + mPlus1]];
//        s6 -= BrBcL[y[s6 - 1]][y[s6 - 2]];
//        s7 += BrBcR[y[s7 + m]][y[s7 + mPlus1]];
//        s8 -= BrBcL[y[s8 - 1]][y[s8 - 2]];
//    }
//    return count;
//}
@end
