#import "MTKTunedBoyerMoore.h"
@implementation MTKTunedBoyerMoore




@end

//#include <stdio.h>
//#include <string.h>
//#include <stdlib.h>
//
//#define ASCII_SIZE      256
//#define BUFSIZE 	16
//
//int bcs2[ASCII_SIZE];
//int match2[256];
//int matchIndex2 = 0;
//
//void create_bcs_table (const char * needle, int len)
//{
//    int i;
//    int last = len - 1;
//    
//    for (i = 0; i < ASCII_SIZE; ++ i)
//        {
//        bcs2[i] = len;
//        }
//    
//    for (i = 0; i < last; ++ i)
//        {
//        bcs2[(int)needle[i]] = last - i;
//        }
//}
//
///* Boyer-Moore-Horspool algorithm */
//void bmh (int offset, const char * haystack, const char * needle, int * edgeL, int * edgeR)
//{
//    int lenH, lenN, n, m, i, k, shift, cnt = 0;
//    
//    *edgeL = *edgeR = 0;
//    lenH = (int)strlen (haystack);
//    lenN = (int)strlen (needle);
//    n = lenH;
//    m = lenN;
//    
//    printf ("Haystack: %d Needle: %d\n", n, m);
//    
//    if (m > n) return;
//    
//    create_bcs_table (needle, m);
//    
//    // check Left Edge
//    for (k=1; k < lenN; k++) {
//        ++cnt;
//        for (i=k; i>0 && haystack[i-1] == needle[lenN-k+i-1]; -- i);
//        (*edgeL) = (*edgeL) << 1 | !i;
//    }
//    
//    
//    k = 0;
//    while (n >= m)
//        {
//        ++ cnt;
//        printf ("Haystack: %s\n  Needle: %*s%s\n", haystack, k, "", needle);
//        for (i = m - 1; haystack[k + i] == needle[i]; -- i)
//            if (i == 0)
//                {
//                match2[matchIndex2++] = offset + k;
//                printf ("Match: %d (%d)\n", k, offset + k);
//                break;
//                }
//        
//        shift = bcs2[(int)haystack[k + i]];
//        k += shift;
//        n -= shift;
//        printf ("\n");
//        }
//    
//    // check Right Edge
//    for (k=lenN-1; k > 0; k--) {
//        ++cnt;
//        for (i=k; i>0 && haystack[lenH-k+i-1] == needle[i-1]; -- i);
//        (*edgeR) = (*edgeR) << 1 | !i;
//    }
//    
//    printf ("Edges = %d %d\n", *edgeL, *edgeR);
//    printf ("Total operations: %d\n", cnt);
//}
//
//static int cmpint(const void *p1, const void *p2) {
//    return *(int const *)p1 > *(int const *)p2;
//}
//
//int runTBM (int argc, char * argv[])
//{
//    FILE * f;
//    int i, fileIndex, pos0, dz;
//    
//    if (argc < 3) {
//        printf("usage: <ex> regexp file");
//        return 1;
//    }
//    
//    char buf[BUFSIZE];
//    char * needle   = argv[1];//"aba";
//    for (fileIndex = 2; fileIndex < argc; fileIndex++) {
//        
//        f = fopen(argv[fileIndex], "r");
//        if (f == NULL) {
//            printf("can't open %s:", argv[fileIndex]);
//            continue;
//        }
//        int pEdgeL = 0, pEdgeR = 0;
//        int edgeL;
//        int edgeR;
//        pos0 = 0;
//        while (fgets(buf, sizeof buf, f) != NULL) {
//            bmh (pos0, buf, needle, &edgeL, &edgeR);
//            if (pEdgeR) {
//                int matches = pEdgeR & pEdgeL;
//            }
//            
//            // check joint position
//            dz = edgeL & pEdgeR;
//            printf("In Joints: %d\n", dz);
//            
//            i=1;
//            for (; dz>0; dz>>=1) {
//                if (dz & 1) {
//                    match2[matchIndex2++] = pos0 - i;
//                }
//                i++;
//            }
//            
//            pEdgeL = edgeL;
//            pEdgeR = edgeR;
//            
//            pos0 += BUFSIZE-1;
//        }
//        
//        qsort(match2, matchIndex2, sizeof(int), cmpint);
//        for (i=0; i < matchIndex2; i++)
//            printf("%d: Match in %d\n", i, match2[i]);
//        
//        fclose(f);
//        
//    }
//    
//    return (0);
//}
