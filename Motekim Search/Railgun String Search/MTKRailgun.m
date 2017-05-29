//
//  RailgunTrolldom.m
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//
// Thanks - this is good stuff.
// Railgun_Trolldom (the successor of Railgun_Swampshine_BailOut - avoiding second pattern comparison in BMH2 and pseudo-BMH4), copyleft 2016-Aug-19, Kaze.
// Railgun_Swampshine_BailOut, copyleft 2016-Aug-10, Kaze.
// Internet "home" page: http://www.codeproject.com/Articles/250566/Fastest-strstr-like-function-in-C
// My homepage (homeserver, often down): http://www.sanmayce.com/Railgun/


#import "MTKRailgun.h"
#import "includeme.h"
@implementation MTKRailgun


char * Railgun_Doublet (char * pbTarget, char * pbPattern, int cbTarget, int cbPattern){
    char * pbTargetMax = pbTarget + cbTarget;
    register uint32_t ulHashPattern;
    uint32_t ulHashTarget, count, countSTATIC;
    
    if (cbPattern > cbTarget) return(NULL);
    
    countSTATIC = cbPattern-2;
    
    pbTarget = pbTarget+cbPattern;
    ulHashPattern = (*(uint16_t *)(pbPattern));
    
    for ( ;; ) {
        if ( ulHashPattern == (*(uint16_t *)(pbTarget-cbPattern)) ) {
            count = countSTATIC;
            while ( count && *(char *)(pbPattern+2+(countSTATIC-count)) == *(char *)(pbTarget-cbPattern+2+(countSTATIC-count)) ) {
                count--;
            }
            if ( count == 0 ) return((pbTarget-cbPattern));
        }
        pbTarget++;
        if (pbTarget > pbTargetMax) return(NULL);
    }
}

#define NeedleThreshold2vs4swampLITE 9 + 10
char *Railgun_Trolldom(char *pbTarget, char *pbPattern, size_t cbTarget,
                       size_t cbPattern) {
    char *pbTargetMax = pbTarget + cbTarget;
    register uint32_t ulHashPattern;
    signed long count;
    
    unsigned char bm_Horspool_Order2[256 * 256];
    unsigned char bm_Horspool_Order2bitwise[(256 * 256) >> 3];
    size_t i, Gulliver;
    
    size_t PRIMALposition = 0, PRIMALpositionCANDIDATE;
    size_t PRIMALlength, PRIMALlengthCANDIDATE;
    size_t j, FoundAtPosition;
    
    // Quadruplet [
    // char * pbTargetMax = pbTarget + cbTarget;
    // register unsigned long  ulHashPattern;
    unsigned long ulHashTarget;
    // unsigned long count;
    unsigned long countSTATIC;
    unsigned char SINGLET;
    unsigned long Quadruplet2nd;
    unsigned long Quadruplet3rd;
    unsigned long Quadruplet4th;
    unsigned long AdvanceHopperGrass;
    // Quadruplet ]
    
    if (cbPattern > cbTarget)
        return (NULL);
    
    if (cbPattern < 4) {
        pbTarget = pbTarget + cbPattern;
        ulHashPattern =
        ((*(char *)(pbPattern)) << 8) + *(pbPattern + (cbPattern - 1));
        if (cbPattern == 3) {
            for (;;) {
                if (ulHashPattern ==
                    ((*(char *)(pbTarget - 3)) << 8) + *(pbTarget - 1)) {
                    if (*(char *)(pbPattern + 1) == *(char *)(pbTarget - 2))
                        return ((pbTarget - 3));
                }
                if ((char)(ulHashPattern >> 8) != *(pbTarget - 2)) {
                    pbTarget++;
                    if ((char)(ulHashPattern >> 8) != *(pbTarget - 2))
                        pbTarget++;
                }
                pbTarget++;
                if (pbTarget > pbTargetMax)
                    return (NULL);
            }
        } else {
        }
        for (;;) {
            if (ulHashPattern == ((*(char *)(pbTarget - 2)) << 8) + *(pbTarget - 1))
                return ((pbTarget - 2));
            if ((char)(ulHashPattern >> 8) != *(pbTarget - 1))
                pbTarget++;
            pbTarget++;
            if (pbTarget > pbTargetMax)
                return (NULL);
        }
    } else { // if ( cbPattern<4 )
        if (cbPattern <= NeedleThreshold2vs4swampLITE) {
            if (cbTarget < 777) // this magic number ensures it must better
                // performance than 'Boyer_Moore_Horspool'.
                {
                pbTarget = pbTarget + cbPattern;
                ulHashPattern = sizeof(pbPattern);
                //        countSTATIC = cbPattern-1;
                
                // SINGLET = *(char *)(pbPattern);
                SINGLET = ulHashPattern & 0xFF;
                Quadruplet2nd = SINGLET << 8;
                Quadruplet3rd = SINGLET << 16;
                Quadruplet4th = SINGLET << 24;
                
                for (;;) {
                    AdvanceHopperGrass = 0;
                    ulHashTarget = *(unsigned long *)(pbTarget - cbPattern);
                    
                    if (ulHashPattern == ulHashTarget) {
                        count = cbPattern - 1;
                        while (count && *(char *)(pbPattern + (cbPattern - count)) ==
                               *(char *)(pbTarget - count)) {
                            if (cbPattern - 1 == AdvanceHopperGrass + count &&
                                SINGLET != *(char *)(pbTarget - count))
                                AdvanceHopperGrass++;
                            count--;
                        }
                        if (count == 0)
                            return ((pbTarget - cbPattern));
                    } else { // The goal here: to avoid memory accesses by stressing the
                        // registers.
                        if (Quadruplet2nd != (ulHashTarget & 0x0000FF00)) {
                            AdvanceHopperGrass++;
                            if (Quadruplet3rd != (ulHashTarget & 0x00FF0000)) {
                                AdvanceHopperGrass++;
                                if (Quadruplet4th != (ulHashTarget & 0xFF000000))
                                    AdvanceHopperGrass++;
                            }
                        }
                    }
                    
                    AdvanceHopperGrass++;
                    
                    pbTarget = pbTarget + AdvanceHopperGrass;
                    if (pbTarget > pbTargetMax)
                        return (NULL);
                }
                } else if (cbTarget < 77777) {
                    // The warmup/overhead is lowered from 64K down to 8K, however the
                    // bitwise additional instructions quickly start hurting the
                    // throughput/traversal. BMH order 2, needle should be >=4:
                    ulHashPattern = *(uint32_t *)(pbPattern); // First four bytes
                    for (i = 0; i<(256 * 256)>> 3; i++) {
                        bm_Horspool_Order2bitwise[i] = 0;
                    }
                    for (i = 0; i < cbPattern - 2 + 1; i++)
                        bm_Horspool_Order2bitwise[(*(unsigned short *)(pbPattern + i)) >> 3] =
                        bm_Horspool_Order2bitwise[(*(unsigned short *)(pbPattern + i)) >>
                                                  3] |
                        (1 << ((*(unsigned short *)(pbPattern + i)) & 0x7));
                    i = 0;
                    while (i <= cbTarget - cbPattern) {
                        Gulliver = 1;
                        if ((bm_Horspool_Order2bitwise
                             [(*(unsigned short *)&pbTarget[i + cbPattern - 1 - 1]) >>
                              3] &
                             (1 << ((*(unsigned short *)&pbTarget[i + cbPattern - 1 - 1]) &
                                    0x7))) != 0) {
                            if ((bm_Horspool_Order2bitwise[(*(unsigned short *)&pbTarget
                                                            [i + cbPattern - 1 - 1 - 2]) >>
                                                           3] &
                                 (1 << ((*(unsigned short
                                           *)&pbTarget[i + cbPattern - 1 - 1 - 2]) &
                                        0x7))) == 0)
                                Gulliver = cbPattern - (2 - 1) - 2;
                            else {
                                if (*(uint32_t *)&pbTarget[i] ==
                                    ulHashPattern) { // This fast check ensures not missing a
                                    // match (for remainder) when going under 0
                                    // in loop below:
                                    count = cbPattern - 4 + 1;
                                    while (count > 0 &&
                                           *(uint32_t *)(pbPattern + count - 1) ==
                                           *(uint32_t *)(&pbTarget[i] + (count - 1)))
                                        count = count - 4;
                                    if (count <= 0)
                                        return (pbTarget + i);
                                }
                            }
                        } else
                            Gulliver = cbPattern - (2 - 1);
                        i = i + Gulliver;
                        // GlobalI++; // Comment it, it is only for stats.
                    }
                    return (NULL);
                    //		} else { // if ( cbPattern<=NeedleThreshold2vs4Decumanus
                    //)
                } else { // if (cbTarget<777)
                    // BMH order 2, needle should be >=4:
                    ulHashPattern = *(uint32_t *)(pbPattern); // First four bytes
                    for (i = 0; i < 256 * 256; i++) {
                        bm_Horspool_Order2[i] = 0;
                    }
                    for (i = 0; i < cbPattern - 1; i++)
                        bm_Horspool_Order2[*(unsigned short *)(pbPattern + i)] = 1;
                    i = 0;
                    while (i <= cbTarget - cbPattern) {
                        Gulliver = 1; // 'Gulliver' is the skip
                        if (bm_Horspool_Order2[*(
                                                 unsigned short *)&pbTarget[i + cbPattern - 1 - 1]] != 0) {
                            if (bm_Horspool_Order2[*(
                                                     unsigned short *)&pbTarget[i + cbPattern - 1 - 1 - 2]] == 0)
                                Gulliver = cbPattern - (2 - 1) - 2;
                            else {
                                if (*(uint32_t *)&pbTarget[i] ==
                                    ulHashPattern) { // This fast check ensures not missing a
                                    // match (for remainder) when going under 0
                                    // in loop below:
                                    count = cbPattern - 4 + 1;
                                    while (count > 0 &&
                                           *(uint32_t *)(pbPattern + count - 1) ==
                                           *(uint32_t *)(&pbTarget[i] + (count - 1)))
                                        count = count - 4;
                                    if (count <= 0)
                                        return (pbTarget + i);
                                }
                            }
                        } else
                            Gulliver = cbPattern - (2 - 1);
                        i = i + Gulliver;
                        // GlobalI++; // Comment it, it is only for stats.
                    }
                    return (NULL);
                    
                } // if (cbTarget<777)
            
        } else {
            // Needle: BOOOOOM                                      PRIMALposition=03
            // PRIMALlength=05  'OOOOM' Needle: aaaaaBOOOOOM
            // PRIMALposition=02 PRIMALlength=09  'aaaaBOOOO' Needle: BOOOOOMaaaaa
            // PRIMALposition=03 PRIMALlength=09  'OOOOMaaaa'
            PRIMALlength = 0;
            for (i = 0 + (1); i < cbPattern - ((4) - 1) + (1) - (1);
                 i++) { // -(1) because the last BB (Building-Block) order 4 has no
                // counterpart(s)
                FoundAtPosition = cbPattern - ((4) - 1) + 1;
                PRIMALpositionCANDIDATE = i;
                while (PRIMALpositionCANDIDATE <= (FoundAtPosition - 1)) {
                    j = PRIMALpositionCANDIDATE + 1;
                    while (j <= (FoundAtPosition - 1)) {
                        if (*(uint32_t *)(pbPattern + PRIMALpositionCANDIDATE - (1)) ==
                            *(uint32_t *)(pbPattern + j - (1)))
                            FoundAtPosition = j;
                        j++;
                    }
                    PRIMALpositionCANDIDATE++;
                }
                PRIMALlengthCANDIDATE = (FoundAtPosition - 1) - i + 1 + ((4) - 1);
                if (PRIMALlengthCANDIDATE >= PRIMALlength) {
                    PRIMALposition = i;
                    PRIMALlength = PRIMALlengthCANDIDATE;
                }
                if (cbPattern - i + 1 <= PRIMALlength)
                    break;
                if (PRIMALlength > 128)
                    break; // Bail Out for 129[+]
            }
            // Swampwalker_BAILOUT heuristic order 4 (Needle should be bigger than 4)
            // ]
            
            // Swampwalker_BAILOUT heuristic order 2 (Needle should be bigger than 2)
            // [ Needle: 1234567890qwertyuiopasdfghjklzxcv
            // PRIMALposition=01 PRIMALlength=33  '1234567890qwertyuiopasdfghjklzxcv'
            // Needle: vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv            PRIMALposition=31
            // PRIMALlength=02  'vv' Here we have 4 or bigger NewNeedle, apply order 2
            // for pbPattern[i+(PRIMALposition-1)] with length 'PRIMALlength' and
            // compare the pbPattern[i] with length 'cbPattern':
            PRIMALlengthCANDIDATE = cbPattern;
            cbPattern = PRIMALlength;
            pbPattern = pbPattern + (PRIMALposition - 1);
            if (cbPattern <= NeedleThreshold2vs4swampLITE) {
                
                // BMH order 2, needle should be >=4:
                ulHashPattern = *(uint32_t *)(pbPattern); // First four bytes
                for (i = 0; i < 256 * 256; i++) {
                    bm_Horspool_Order2[i] = 0;
                }
                for (i = 0; i < cbPattern - 1; i++)
                    bm_Horspool_Order2[*(unsigned short *)(pbPattern + i)] = 1;
                i = 0;
                while (i <= cbTarget - cbPattern) {
                    Gulliver = 1; // 'Gulliver' is the skip
                    if (bm_Horspool_Order2[*(
                                             unsigned short *)&pbTarget[i + cbPattern - 1 - 1]] != 0) {
                        if (bm_Horspool_Order2[*(
                                                 unsigned short *)&pbTarget[i + cbPattern - 1 - 1 - 2]] == 0)
                            Gulliver = cbPattern - (2 - 1) - 2;
                        else {
                            if (*(uint32_t *)&pbTarget[i] ==
                                ulHashPattern) { // This fast check ensures not missing a
                                // match (for remainder) when going under 0
                                // in loop below:
                                count = cbPattern - 4 + 1;
                                while (count > 0 &&
                                       *(uint32_t *)(pbPattern + count - 1) ==
                                       *(uint32_t *)(&pbTarget[i] + (count - 1)))
                                    count = count - 4;
                                
                                if (cbPattern !=
                                    PRIMALlengthCANDIDATE) { // No need of same comparison when
                                    // Needle and NewNeedle are equal!
                                    // If we miss to hit then no need to compare the original:
                                    // Needle
                                    if (count <= 0) {
                                        // FIX from 2016-Aug-10 (two times failed to do simple
                                        // boundary checks, pfu):
                                        if (((signed int)(i - (PRIMALposition - 1)) >= 0) &&
                                            (&pbTarget[i - (PRIMALposition - 1)] +
                                             ((PRIMALlengthCANDIDATE - 4 + 1) - 1) <=
                                             pbTargetMax - 4)) {
                                                if (*(uint32_t *)&pbTarget[i - (PRIMALposition - 1)] ==
                                                    *(uint32_t *)(pbPattern -
                                                                  (PRIMALposition -
                                                                   1))) { // This fast check ensures not
                                                                      // missing a match (for
                                                                      // remainder) when going under 0
                                                                      // in loop below:
                                                                      count = PRIMALlengthCANDIDATE - 4 + 1;
                                                                      while (count > 0 &&
                                                                             *(uint32_t *)(pbPattern - (PRIMALposition - 1) +
                                                                                           count - 1) ==
                                                                             *(uint32_t *)(&pbTarget[i - (PRIMALposition -
                                                                                                          1)] +
                                                                                           (count - 1)))
                                                                          count = count - 4;
                                                                      if (count <= 0)
                                                                          return (pbTarget + i - (PRIMALposition - 1));
                                                                  }
                                            }
                                    }
                                } else { // if (cbPattern != PRIMALlengthCANDIDATE)
                                    if (count <= 0)
                                        return (pbTarget + i);
                                }
                            }
                        }
                    } else
                        Gulliver = cbPattern - (2 - 1);
                    i = i + Gulliver;
                    // GlobalI++; // Comment it, it is only for stats.
                }
                return (NULL);
                
            } else { // if ( cbPattern<=NeedleThreshold2vs4swampLITE )
                
                // BMH pseudo-order 4, needle should be >=8+2:
                ulHashPattern = *(uint32_t *)(pbPattern);
                // First four bytes
                for (i = 0; i < 256 * 256; i++) {
                    bm_Horspool_Order2[i] = 0;
                }
                // In line below we "hash" 4bytes to 2bytes i.e. 16bit table, how to
                // compute TOTAL number of BBs, 'cbPattern - Order + 1' is the number of
                // BBs for text 'cbPattern' bytes long, for example, for cbPattern=11
                // 'fastest fox' and Order=4 we have BBs = 11-4+1=8:
                //"fast"
                //"aste"
                //"stes"
                //"test"
                //"est "
                //"st f"
                //"t fo"
                //" fox"
                // for (i=0; i < cbPattern-4+1; i++) bm_Horspool_Order2[( *(unsigned
                // short *)(pbPattern+i+0) + *(unsigned short *)(pbPattern+i+2) ) & (
                // (1<<16)-1 )]=1;  for (i=0; i < cbPattern-4+1; i++) bm_Horspool_Order2[(
                // (*(uint32_t *)(pbPattern+i+0)>>16)+(*(uint32_t
                // *)(pbPattern+i+0)&0xFFFF) ) & ( (1<<16)-1 )]=1;
                // Above line is replaced by next one with better hashing:
                for (i = 0; i < cbPattern - 4 + 1; i++)
                    bm_Horspool_Order2[((*(uint32_t *)(pbPattern + i + 0) >> (16 - 1)) +
                                        (*(uint32_t *)(pbPattern + i + 0) & 0xFFFF)) &
                                       ((1 << 16) - 1)] = 1;
                i = 0;
                while (i <= cbTarget - cbPattern) {
                    Gulliver = 1;
                    // if ( bm_Horspool_Order2[( (*(uint32_t
                    // *)&pbTarget[i+cbPattern-1-1-2]>>16)+(*(uint32_t
                    // *)&pbTarget[i+cbPattern-1-1-2]&0xFFFF) ) & ( (1<<16)-1 )] != 0 ) {
                    // // DWORD #1
                    // Above line is replaced by next one with better hashing:
                    if (bm_Horspool_Order2
                        [((*(uint32_t *)&pbTarget[i + cbPattern - 1 - 1 - 2] >>
                           (16 - 1)) +
                          (*(uint32_t *)&pbTarget[i + cbPattern - 1 - 1 - 2] &
                           0xFFFF)) &
                         ((1 << 16) - 1)] != 0) { // DWORD #1
                            
                            if ((bm_Horspool_Order2[((*(uint32_t *)&pbTarget[i + cbPattern - 1 -
                                                                             1 - 2 - 6 + 1] >>
                                                      (16 - 1)) +
                                                     (*(uint32_t *)&pbTarget[i + cbPattern - 1 -
                                                                             1 - 2 - 6 + 1] &
                                                      0xFFFF)) &
                                                    ((1 << 16) - 1)]) == 0 ||
                                (bm_Horspool_Order2[((*(uint32_t *)&pbTarget[i + cbPattern - 1 -
                                                                             1 - 2 - 4 + 1] >>
                                                      (16 - 1)) +
                                                     (*(uint32_t *)&pbTarget[i + cbPattern - 1 -
                                                                             1 - 2 - 4 + 1] &
                                                      0xFFFF)) &
                                                    ((1 << 16) - 1)]) == 0)
                                Gulliver = cbPattern - (2 - 1) - 2 - 4 - 2 + 1;
                            else {
                                if (*(uint32_t *)&pbTarget[i] == ulHashPattern) {
                                    // Order 4 [
                                    // Let's try something "outrageous" like comparing with[out]
                                    // overlap BBs 4bytes long instead of 1 byte back-to-back:
                                    // Inhere we are using order 4, 'cbPattern - Order + 1' is the
                                    // number of BBs for text 'cbPattern' bytes long, for example,
                                    // for cbPattern=11 'fastest fox' and Order=4 we have BBs =
                                    // 11-4+1=8:
                                    // 0:"fast" if the comparison failed here, 'count' is 1;
                                    // 'Gulliver' is cbPattern-(4-1)-7  1:"aste" if the comparison
                                    // failed here, 'count' is 2; 'Gulliver' is cbPattern-(4-1)-6
                                    // 2:"stes" if the comparison failed here, 'count' is 3;
                                    // 'Gulliver' is cbPattern-(4-1)-5  3:"test" if the comparison
                                    // failed here, 'count' is 4; 'Gulliver' is cbPattern-(4-1)-4
                                    // 4:"est " if the comparison failed here, 'count' is 5;
                                    // 'Gulliver' is cbPattern-(4-1)-3  5:"st f" if the comparison
                                    // failed here, 'count' is 6; 'Gulliver' is cbPattern-(4-1)-2
                                    // 6:"t fo" if the comparison failed here, 'count' is 7;
                                    // 'Gulliver' is cbPattern-(4-1)-1  7:" fox" if the comparison
                                    // failed here, 'count' is 8; 'Gulliver' is cbPattern-(4-1)
                                    count = cbPattern - 4 + 1;
                                    // Below comparison is UNIdirectional:
                                    while (count > 0 &&
                                           *(uint32_t *)(pbPattern + count - 1) ==
                                           *(uint32_t *)(&pbTarget[i] + (count - 1)))
                                        count = count - 4;
                                    
                                    if (cbPattern != PRIMALlengthCANDIDATE) {
                                        // If we miss to hit then no need to compare the original:
                                        // Needle
                                        if (count <= 0) {
                                            // FIX from 2016-Aug-10 (two times failed to do simple
                                            // boundary checks, pfu):
                                            if (((signed int)(i - (PRIMALposition - 1)) >= 0) &&
                                                (&pbTarget[i - (PRIMALposition - 1)] +
                                                 ((PRIMALlengthCANDIDATE - 4 + 1) - 1) <=
                                                 pbTargetMax - 4)) {
                                                    if (*(uint32_t *)&pbTarget[i - (PRIMALposition - 1)] ==
                                                        *(uint32_t *)(pbPattern -
                                                                      (PRIMALposition -
                                                                       1))) { // This fast check ensures not
                                                                          // missing a match (for
                                                                          // remainder) when going under 0
                                                                          // in loop below:
                                                                          count = PRIMALlengthCANDIDATE - 4 + 1;
                                                                          while (count > 0 &&
                                                                                 *(uint32_t *)(pbPattern - (PRIMALposition - 1) +
                                                                                               count - 1) ==
                                                                                 *(uint32_t *)(&pbTarget[i - (PRIMALposition -
                                                                                                              1)] +
                                                                                               (count - 1)))
                                                                              count = count - 4;
                                                                          if (count <= 0)
                                                                              return (pbTarget + i - (PRIMALposition - 1));
                                                                      }
                                                }
                                        }
                                    } else {
                                        if (count <= 0)
                                            return (pbTarget + i);
                                    }
                                }
                            }
                        } else
                            Gulliver = cbPattern - (2 - 1) -
                            2; // -2 because we check the 4 rightmost bytes not 2.
                    i = i + Gulliver;
                    // GlobalI++; // Comment it, it is only for stats.
                }
                return (NULL);
                
            } // if ( cbPattern<=NeedleThreshold2vs4swampLITE )
        }   // if ( cbPattern<=NeedleThreshold2vs4swampLITE )
    }     // if ( cbPattern<4 )
}


@end
