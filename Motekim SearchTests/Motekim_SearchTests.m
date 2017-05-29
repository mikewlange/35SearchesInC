//
//  MotekimSearchAlgosTests.m
//  MotekimSearchAlgosTests
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MOFinateAutomatica.h"
#import "MTKKnuthMorrisPratt.h"
#import "MTKbruteforce.h"
#import "MTKKarpRabin.h"
#include "MTKMorrisPratt.h"
#include "MTKdfaa.h"
#include "MTKSimonAlgo.h"
#include "MTKColussi.h"
#include "MTKGalilGiancarlo.h"
#include "MTKApostolicoGiancarlo.h"
#include "MTKApostolicoCrochemore.h"
#include "MTKNsn.h"
#include "MTKBoyerMoore.h"
#include "MTKTurboBM.h"
#include "MTKReverseColussi.h"
#include "MTKQuickSearch.h"
#import "MTKTunedBoyerMoore.h"
#import "MTKZAlgo.h"
#import "MTKZhuTakaoka.h"
#import "MTKBerryRavindran.h"
#import "MTKSmith.h"
#import "MTKReverseFactor.h"
#import "MTKBackwardOracle.h"
#import "MTKRailgun.h"
#import "MTKBoyerMooreHorspool.h"
#import "MTKShiftOr.h"
#import "MTKGalilSeiferas.h"
#import "MTKTwoWay.h"
#import "MTKOrderedAlpha.h"
#import "MTKOptimalMismatch.h"
#import "MTKSkipSearch.h"
#import "MTKKMPSkip.h"
#import "MTKAlphaSkip.h"
#import "MTKShiftAnd.h"
@interface MotekimSearchAlgosTests : XCTestCase

@end

@implementation MotekimSearchAlgosTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
/////////////////////////////
//+++++++++++++++++++++++++++
// BRUTE FORCE SEARCH
//+++++++++++++++++++++++++++
/////////////////////////////
-(void)testMTKbruteforce{
    
    char *txt = "xx sf  d  jk hgdgh hghsf  d  jk hgdgh hggsf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxxdsf  d  jk hgdgh hghsf  d  jk hgdgh hg sf  d  jk hgdgh hgfsf  d  jk hgdgh hggoohgxxhsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hgdsf  d  jk hgdgh hggoohgxxfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgdsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hgfsf  d  jk hgdgh hg sf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxx sf  d  jk hgdgh hg sf  d  jk hgdgh hghsf  d  jk hgdgh hgfsf  d  jk hgdgh hg oohgxxdsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hg sf  d  jk hgdgh hgdsf  d  jk hgdgh hgdsf  d  jk hgdgh hgfoohgxxdsf  d  jk hgdgh hgdsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hg oohgxxhsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hg oo";
    // PATTERN
    char *pat = "hgdgh";
    // OUT
    char output[CHAR_MAX];// ALG
    BF(pat,txt,output);
    // FOUND?
    XCTAssertTrue(output[0]!=0);
    
    
}
/////////////////////////////
//+++++++++++++++++++++++++++
// Morris-Pratt
//+++++++++++++++++++++++++++
/////////////////////////////
-(void)testMTKMorrisPratt{
    // TEXT
    char *txt = "xx sf  d  jk hgdgh hghsf  d  jk hgdgh hggsf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxxdsf  d  jk hgdgh hghsf  d  jk hgdgh hg sf  d  jk hgdgh hgfsf  d  jk hgdgh hggoohgxxhsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hgdsf  d  jk hgdgh hggoohgxxfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgdsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hgfsf  d  jk hgdgh hg sf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxx sf  d  jk hgdgh hg sf  d  jk hgdgh hghsf  d  jk hgdgh hgfsf  d  jk hgdgh hg oohgxxdsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hg sf  d  jk hgdgh hgdsf  d  jk hgdgh hgdsf  d  jk hgdgh hgfoohgxxdsf  d  jk hgdgh hgdsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hg oohgxxhsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hg oo";
    // PATTERN
    char *pat = "hgdgh";
    // OUT
    int output[256] = {0};;// ALG
    MTKMorrisPrattSearch(pat,txt,output);
    // FOUND?
    XCTAssertTrue(output[0]!=0);
}

/////////////////////////////
//+++++++++++++++++++++++++++
// Knuth-Morris-Pratt
//+++++++++++++++++++++++++++
/////////////////////////////
-(void)testMTKKnuthMorrisPratt{
    // TEXT
    char *txt = "xx sf  d  jk hgdgh hghsf  d  jk hgdgh hggsf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxxdsf  d  jk hgdgh hghsf  d  jk hgdgh hg sf  d  jk hgdgh hgfsf  d  jk hgdgh hggoohgxxhsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hgdsf  d  jk hgdgh hggoohgxxfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgdsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hgfsf  d  jk hgdgh hg sf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxx sf  d  jk hgdgh hg sf  d  jk hgdgh hghsf  d  jk hgdgh hgfsf  d  jk hgdgh hg oohgxxdsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hg sf  d  jk hgdgh hgdsf  d  jk hgdgh hgdsf  d  jk hgdgh hgfoohgxxdsf  d  jk hgdgh hgdsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hg oohgxxhsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hg oo";
    // PATTERN
    char *pat = "hgdgh";
    // OUT
    int output[256] = {0};;// ALG
    MTKKMPSearch(pat,txt,output);
    // FOUND?
    XCTAssertTrue(output[0]!=0);
}

/////////////////////////////
//+++++++++++++++++++++++++++
// Karp-Rabin
//+++++++++++++++++++++++++++
/////////////////////////////
-(void)testMTKKarpRabin{
    
    char *txt = "xx sf  d  jk hgdgh hghsf  d  jk hgdgh hggsf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxxdsf  d  jk hgdgh hghsf  d  jk hgdgh hg sf  d  jk hgdgh hgfsf  d  jk hgdgh hggoohgxxhsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hgdsf  d  jk hgdgh hggoohgxxfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgdsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hgfsf  d  jk hgdgh hg sf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxx sf  d  jk hgdgh hg sf  d  jk hgdgh hghsf  d  jk hgdgh hgfsf  d  jk hgdgh hg oohgxxdsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hg sf  d  jk hgdgh hgdsf  d  jk hgdgh hgdsf  d  jk hgdgh hgfoohgxxdsf  d  jk hgdgh hgdsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hg oohgxxhsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hg oo";
    // PATTERN
    char *pat = "hgdgh";
    // OUT
    int q = 101;
    int output[256] = {0};;
    
    KRsearch(pat,txt,q,output);// ALG
    // FOUND?
    XCTAssertTrue(output[0]!=0);
}


/////////////////////////////
//+++++++++++++++++++++++++++

// Deterministic Finite Automaton algorithm

//+++++++++++++++++++++++++++
/////////////////////////////
//-(void)testDFAA{
//    // TEXT
//    char *txt = "xx sf  d  jk hgdgh hghsf  d  jk hgdgh hggsf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxxdsf  d  jk hgdgh hghsf  d  jk hgdgh hg sf  d  jk hgdgh hgfsf  d  jk hgdgh hggoohgxxhsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hgdsf  d  jk hgdgh hggoohgxxfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgdsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hgfsf  d  jk hgdgh hg sf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxx sf  d  jk hgdgh hg sf  d  jk hgdgh hghsf  d  jk hgdgh hgfsf  d  jk hgdgh hg oohgxxdsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hg sf  d  jk hgdgh hgdsf  d  jk hgdgh hgdsf  d  jk hgdgh hgfoohgxxdsf  d  jk hgdgh hgdsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hg oohgxxhsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hg oo";
//    // PATTERN
//    char *pat = "hgdgh";
//    // OUT
//        int output[256] = {0};;// ALG
//
//    DFAA(txt,pat,output);
//    // FOUND?
//    XCTAssertTrue(output[0]!=0);
//}

-(void)testMLDFAA{
    // TEXT
    char *txt = "xx sf  d  jk hgdgh hghsf  d  jk hgdgh hggsf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxxdsf  d  jk hgdgh hghsf  d  jk hgdgh hg sf  d  jk hgdgh hgfsf  d  jk hgdgh hggoohgxxhsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hgdsf  d  jk hgdgh hggoohgxxfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgdsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hgfsf  d  jk hgdgh hg sf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxx sf  d  jk hgdgh hg sf  d  jk hgdgh hghsf  d  jk hgdgh hgfsf  d  jk hgdgh hg oohgxxdsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hg sf  d  jk hgdgh hgdsf  d  jk hgdgh hgdsf  d  jk hgdgh hgfoohgxxdsf  d  jk hgdgh hgdsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hg oohgxxhsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hg oo";
    // PATTERN
    char *pat = "hgdgh";
    // OUT
    int output[256] = {0};;// ALG
    mlDaa(pat,txt,output);
    // FOUND?
    XCTAssertTrue(output[0]!=0);
}

/////////////////////////////
//+++++++++++++++++++++++++++
// Finite Automata
//+++++++++++++++++++++++++++
/////////////////////////////
-(void)testFiniteAutomata{
    
    char *txt = "xx sf  d  jk hgdgh hghsf  d  jk hgdgh hggsf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxxdsf  d  jk hgdgh hghsf  d  jk hgdgh hg sf  d  jk hgdgh hgfsf  d  jk hgdgh hggoohgxxhsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hgdsf  d  jk hgdgh hggoohgxxfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgdsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hgfsf  d  jk hgdgh hg sf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxx sf  d  jk hgdgh hg sf  d  jk hgdgh hghsf  d  jk hgdgh hgfsf  d  jk hgdgh hg oohgxxdsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hg sf  d  jk hgdgh hgdsf  d  jk hgdgh hgdsf  d  jk hgdgh hgfoohgxxdsf  d  jk hgdgh hgdsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hg oohgxxhsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hg oo";
    // PATTERN
    char *pat = "hgdgh";
    // OUT
    int output[256] = {0};;// ALG
    FAsearch(pat,txt,output);
    // FOUND?
    XCTAssertTrue(output[0]!=0);
}
/////////////////////////////
//+++++++++++++++++++++++++++
// Finite Automata
//+++++++++++++++++++++++++++
/////////////////////////////
-(void)testSIMON{
    
    char *txt = "xx sf  d  jk hgdgh hghsf  d  jk hgdgh hggsf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxxdsf  d  jk hgdgh hghsf  d  jk hgdgh hg sf  d  jk hgdgh hgfsf  d  jk hgdgh hggoohgxxhsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hgdsf  d  jk hgdgh hggoohgxxfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgdsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hgfsf  d  jk hgdgh hg sf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxx sf  d  jk hgdgh hg sf  d  jk hgdgh hghsf  d  jk hgdgh hgfsf  d  jk hgdgh hg oohgxxdsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hg sf  d  jk hgdgh hgdsf  d  jk hgdgh hgdsf  d  jk hgdgh hgfoohgxxdsf  d  jk hgdgh hgdsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hg oohgxxhsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hg oo";
    // PATTERN
    char *pat = "hgdgh";
    // OUT
    int output[256] = {0};;// ALG
    SIMON(pat,txt,output);
    // FOUND?
    XCTAssertTrue(output[0]!=0);
}
/////////////////////////////
//+++++++++++++++++++++++++++
// Colussi algorithm
//+++++++++++++++++++++++++++
/////////////////////////////
-(void)testCOLUSSI{
    
    char *txt = "xx sf  d  jk hgdgh hghsf  d  jk hgdgh hggsf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxxdsf  d  jk hgdgh hghsf  d  jk hgdgh hg sf  d  jk hgdgh hgfsf  d  jk hgdgh hggoohgxxhsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hgdsf  d  jk hgdgh hggoohgxxfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgdsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hgfsf  d  jk hgdgh hg sf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxx sf  d  jk hgdgh hg sf  d  jk hgdgh hghsf  d  jk hgdgh hgfsf  d  jk hgdgh hg oohgxxdsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hg sf  d  jk hgdgh hgdsf  d  jk hgdgh hgdsf  d  jk hgdgh hgfoohgxxdsf  d  jk hgdgh hgdsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hg oohgxxhsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hg oo";
    // PATTERN
    char *pat = "hgdgh";
    // OUT
    int output[256] = {0};;// ALG
    COLUSSI(pat,txt,output);
    // FOUND?
    XCTAssertTrue(output[0]!=0);
}
/////////////////////////////
//+++++++++++++++++++++++++++
// MTKGalilGiancarloSearch
//+++++++++++++++++++++++++++
/////////////////////////////
-(void)testMTKGalilGiancarloSearch{
    
    char *txt = "xx sf  d  jk hgdgh hghsf  d  jk hgdgh hggsf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxxdsf  d  jk hgdgh hghsf  d  jk hgdgh hg sf  d  jk hgdgh hgfsf  d  jk hgdgh hggoohgxxhsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hgdsf  d  jk hgdgh hggoohgxxfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgdsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hgfsf  d  jk hgdgh hg sf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxx sf  d  jk hgdgh hg sf  d  jk hgdgh hghsf  d  jk hgdgh hgfsf  d  jk hgdgh hg oohgxxdsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hg sf  d  jk hgdgh hgdsf  d  jk hgdgh hgdsf  d  jk hgdgh hgfoohgxxdsf  d  jk hgdgh hgdsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hg oohgxxhsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hg oo";
    // PATTERN
    char *pat = "hgdgh";
    // OUT
    int output[256] = {0};;// ALG
    MTKGalilGiancarloSearch(pat,txt,output);
    // FOUND?
    XCTAssertTrue(output[0]!=0);
}
/////////////////////////////
//+++++++++++++++++++++++++++
// Apostolico-Crochemore algorithm
//+++++++++++++++++++++++++++
/////////////////////////////
-(void)testApostolicoCrochemore{
    
    char *txt = "xx sf  d  jk hgdgh hghsf  d  jk hgdgh hggsf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxxdsf  d  jk hgdgh hghsf  d  jk hgdgh hg sf  d  jk hgdgh hgfsf  d  jk hgdgh hggoohgxxhsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hgdsf  d  jk hgdgh hggoohgxxfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgdsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hgfsf  d  jk hgdgh hg sf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxx sf  d  jk hgdgh hg sf  d  jk hgdgh hghsf  d  jk hgdgh hgfsf  d  jk hgdgh hg oohgxxdsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hg sf  d  jk hgdgh hgdsf  d  jk hgdgh hgdsf  d  jk hgdgh hgfoohgxxdsf  d  jk hgdgh hgdsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hg oohgxxhsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hg oo";
    // PATTERN
    char *pat = "hgdgh";
    // OUT
    int output[256] = {0};;// ALG
    MTKACA(pat,txt,output);
    // FOUND?
    XCTAssertTrue(output[0]!=0);
}

/////////////////////////////
//+++++++++++++++++++++++++++
// Not So Naive algorithm
//+++++++++++++++++++++++++++
/////////////////////////////
-(void)testNotSoNaivealgorithm{
    
    char *txt = "xx sf  d  jk hgdgh hghsf  d  jk hgdgh hggsf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxxdsf  d  jk hgdgh hghsf  d  jk hgdgh hg sf  d  jk hgdgh hgfsf  d  jk hgdgh hggoohgxxhsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hgdsf  d  jk hgdgh hggoohgxxfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgdsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hgfsf  d  jk hgdgh hg sf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxx sf  d  jk hgdgh hg sf  d  jk hgdgh hghsf  d  jk hgdgh hgfsf  d  jk hgdgh hg oohgxxdsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hg sf  d  jk hgdgh hgdsf  d  jk hgdgh hgdsf  d  jk hgdgh hgfoohgxxdsf  d  jk hgdgh hgdsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hg oohgxxhsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hg oo";
    // PATTERN
    char *pat = "hgdgh";
    // OUT
    int output[256] = {0};;// ALG
    MTKNSN(pat,txt,output);
    // FOUND?
    XCTAssertTrue(output[0]!=0);
}


/////////////////////////////
//+++++++++++++++++++++++++++
// Boyer-Moore
//+++++++++++++++++++++++++++
/////////////////////////////
-(void)testBoyerMoore{
    
    char *txt = "xx sf  d  jk hgdgh hghsf  d  jk hgdgh hggsf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxxdsf  d  jk hgdgh hghsf  d  jk hgdgh hg sf  d  jk hgdgh hgfsf  d  jk hgdgh hggoohgxxhsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hgdsf  d  jk hgdgh hggoohgxxfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgdsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hgfsf  d  jk hgdgh hg sf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxx sf  d  jk hgdgh hg sf  d  jk hgdgh hghsf  d  jk hgdgh hgfsf  d  jk hgdgh hg oohgxxdsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hg sf  d  jk hgdgh hgdsf  d  jk hgdgh hgdsf  d  jk hgdgh hgfoohgxxdsf  d  jk hgdgh hgdsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hg oohgxxhsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hg oo";
    // PATTERN
    char *pat = "hgdgh";
    // OUT
    int output[256] = {0};;// ALG
    MTKBM2(txt,pat,output);
    // FOUND?
    XCTAssertTrue(output[0]!=0);
}

/////////////////////////////
//+++++++++++++++++++++++++++
// Boyer-Moore-Horsepool
//+++++++++++++++++++++++++++
/////////////////////////////
-(void)testBMH{
    
    char *txt = "xx sf  d  jk hgdgh hghsf  d  jk hgdgh hggsf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxxdsf  d  jk hgdgh hghsf  d  jk hgdgh hg sf  d  jk hgdgh hgfsf  d  jk hgdgh hggoohgxxhsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hgdsf  d  jk hgdgh hggoohgxxfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgdsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hgfsf  d  jk hgdgh hg sf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxx sf  d  jk hgdgh hg sf  d  jk hgdgh hghsf  d  jk hgdgh hgfsf  d  jk hgdgh hg oohgxxdsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hg sf  d  jk hgdgh hgdsf  d  jk hgdgh hgdsf  d  jk hgdgh hgfoohgxxdsf  d  jk hgdgh hgdsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hg oohgxxhsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hg oo";
    // PATTERN
    char *pat = "hgdgh";
    // OUT
    //   int output[256];// ALG
    const char *ch = searchBoyerMooreHorspoolString(txt,pat);
    // FOUND?
    XCTAssertTrue(ch>0);
}



/////////////////////////////
//+++++++++++++++++++++++++++
// Turbo-BM algorithm - the lightning fast bm
//+++++++++++++++++++++++++++
/////////////////////////////
-(void)testTurboBM{
    // TEXT
    char *txt = "xx sf  d  jk hgdgh hghsf  d  jk hgdgh hggsf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxxdsf  d  jk hgdgh hghsf  d  jk hgdgh hg sf  d  jk hgdgh hgfsf  d  jk hgdgh hggoohgxxhsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hgdsf  d  jk hgdgh hggoohgxxfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgdsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hgfsf  d  jk hgdgh hg sf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxx sf  d  jk hgdgh hg sf  d  jk hgdgh hghsf  d  jk hgdgh hgfsf  d  jk hgdgh hg oohgxxdsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hg sf  d  jk hgdgh hgdsf  d  jk hgdgh hgdsf  d  jk hgdgh hgfoohgxxdsf  d  jk hgdgh hgdsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hg oohgxxhsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hg oo";
    // PATTERN
    char *pat = "hgdgh";
    // OUT
    int output[256] = {0};// ALG
    TBM(pat,txt,output);
    // FOUND?
    XCTAssertTrue(output[0]!=0);
}

/////////////////////////////
//+++++++++++++++++++++++++++
// Apostolico-Giancarlo algorithm
//+++++++++++++++++++++++++++
/////////////////////////////
-(void)testAG{
    // TEXT
    char *txt = "xx sf  d  jk hgdgh hghsf  d  jk hgdgh hggsf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxxdsf  d  jk hgdgh hghsf  d  jk hgdgh hg sf  d  jk hgdgh hgfsf  d  jk hgdgh hggoohgxxhsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hgdsf  d  jk hgdgh hggoohgxxfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgdsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hgfsf  d  jk hgdgh hg sf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxx sf  d  jk hgdgh hg sf  d  jk hgdgh hghsf  d  jk hgdgh hgfsf  d  jk hgdgh hg oohgxxdsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hg sf  d  jk hgdgh hgdsf  d  jk hgdgh hgdsf  d  jk hgdgh hgfoohgxxdsf  d  jk hgdgh hgdsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hg oohgxxhsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hg oo";
    // PATTERN
    char *pat = "hgdgh";
    // OUT
    int output[256] = {0};;// ALG
    AGSearch(pat,txt,output);
    // FOUND?
    XCTAssertTrue(output[0]!=0);
}

/////////////////////////////
//+++++++++++++++++++++++++++
// Reverse Colussi algorithm
//+++++++++++++++++++++++++++
/////////////////////////////

// FIRST INSTANCE
-(void)testRC{
    // TEXT
    char *txt = "xx sf  d  jk hgdgh hghsf  d  jk hgdgh hggsf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxxdsf  d  jk hgdgh hghsf  d  jk hgdgh hg sf  d  jk hgdgh hgfsf  d  jk hgdgh hggoohgxxhsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hgdsf  d  jk hgdgh hggoohgxxfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgdsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hgfsf  d  jk hgdgh hg sf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxx sf  d  jk hgdgh hg sf  d  jk hgdgh hghsf  d  jk hgdgh hgfsf  d  jk hgdgh hg oohgxxdsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hg sf  d  jk hgdgh hgdsf  d  jk hgdgh hgdsf  d  jk hgdgh hgfoohgxxdsf  d  jk hgdgh hgdsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hg oohgxxhsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hg oo";
    // PATTERN
    char *pat = "hgdgh";
    // OUT
    int output[256] = {0};;// ALG
    RCSearch(pat,txt,output);
    // FOUND?
    XCTAssertTrue(output[0]!=0);
}


/////////////////////////////
//+++++++++++++++++++++++++++
// Zhu-Takaoka algorithm  -- FAST
//+++++++++++++++++++++++++++
/////////////////////////////
//variant of the Boyer-Moore algorithm;
//uses two consecutive text characters to compute the bad-character shift;
//preprocessing phase in O(m+sigma2) time and space complexity;
//searching phase in O(mn) time complexity.
-(void)testZT{
    // TEXT
    char *txt = "xx sf  d  jk hgdgh hghsf  d  jk hgdgh hggsf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxxdsf  d  jk hgdgh hghsf  d  jk hgdgh hg sf  d  jk hgdgh hgfsf  d  jk hgdgh hggoohgxxhsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hgdsf  d  jk hgdgh hggoohgxxfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgdsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hgfsf  d  jk hgdgh hg sf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxx sf  d  jk hgdgh hg sf  d  jk hgdgh hghsf  d  jk hgdgh hgfsf  d  jk hgdgh hg oohgxxdsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hg sf  d  jk hgdgh hgdsf  d  jk hgdgh hgdsf  d  jk hgdgh hgfoohgxxdsf  d  jk hgdgh hgdsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hg oohgxxhsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hg oo";
    // PATTERN
    char *pat = "hgdgh";
    // OUT
    int output[256] = {0};;// ALG
    ZT(pat,txt,output);
    // FOUND?
    XCTAssertTrue(output[0]!=0);
}

/////////////////////////////
//+++++++++++++++++++++++++++
// Backward Oracle Matching algorithm
//+++++++++++++++++++++++++++
/////////////////////////////
//Backward Oracle Matching algorithm
-(void)testBWO{
    // TEXT
    char *txt = "xx sf  d  jk hgdgh hghsf  d  jk hgdgh hggsf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxxdsf  d  jk hgdgh hghsf  d  jk hgdgh hg sf  d  jk hgdgh hgfsf  d  jk hgdgh hggoohgxxhsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hgdsf  d  jk hgdgh hggoohgxxfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgdsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hgfsf  d  jk hgdgh hg sf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxx sf  d  jk hgdgh hg sf  d  jk hgdgh hghsf  d  jk hgdgh hgfsf  d  jk hgdgh hg oohgxxdsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hg sf  d  jk hgdgh hgdsf  d  jk hgdgh hgdsf  d  jk hgdgh hgfoohgxxdsf  d  jk hgdgh hgdsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hg oohgxxhsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hg oo";
    // PATTERN
    char *pat = "hgdgh";
    // OUT
    int output[256] = {0};;// ALG
    
    BOM(pat,txt,output); 
    // FOUND?
    XCTAssertTrue(output[0]!=0);
}


// FIRST INSTANCE OF _ THE FSTEST
/////////////////////////////
//+++++++++++++++++++++++++++
//RAILGUN
//+++++++++++++++++++++++++++
/////////////////////////////
//RAILGUN
-(void)testRailgunDoublet{
    // TEXT
    char *txt = "xx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfoohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfoohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oo";
    // PATTERN
    char *pat = "hgdsf65656";
    // OUT
    //  char *output =0;// ALG
    //   BOM(pat,txt,output);
    char* ch =   Railgun_Doublet(txt, pat, (int)strlen(txt),  (int)strlen(pat));//(haystack, needle,(uint32_t)(haystack), (uint32_t)(needle));
    // FOUND?
    XCTAssertTrue(ch>0);
}

-(void)testRailgunFastest{
    // TEXT
    char *txt = "xx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfoohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfoohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oo";
    // PATTERN
    char *pat = "hgdsf65656";
    // OUT
    
    //   BOM(pat,txt,output);
    char *ch =   Railgun_Trolldom(txt, pat,strlen(txt), strlen(pat));
    // FOUND?
    XCTAssertTrue(ch>0);
}


// First Find strshr() uish
-(void)testShiftOr{
    // TEXT
    char *txt = "xx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfoohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfoohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oo";
    // PATTERN
    char *pat = "hgdsf65656";
    // OUT
    
    //   BOM(pat,txt,output);
    const char *x  = ShiftOr(txt, pat);
    // FOUND?
    XCTAssertTrue(x>0);
}

// Fixxy search. Perfect for an ato complete or similar.
-(void)testShiftOrFuzzy{
    // TEXT
    char *txt = "xx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfoohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfoohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oo";
    // PATTERN
    char *pat = "hgdsf65656";
    // OUT
    
    //   BOM(pat,txt,output);
    const char *x  = ShiftOrFuzzy(txt, pat);
    // FOUND?
    XCTAssertTrue(x>0);
}


/////////////////////////////
//+++++++++++++++++++++++++++
//Galil-Seiferas algorithm
//+++++++++++++++++++++++++++
/////////////////////////////
//Galil-Seiferas algorithm
//-(void)testGS{
//    // TEXT
//    char *txt = "xx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfoohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfoohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oo";
//    // PATTERN
//    char *pat = "fhg";
//    // OUT
//    int output[] = {0};// ALG
//    //   BOM(pat,txt,output);
//    //  GS(txt, pat, strlen(txt),  strlen(pat));//(haystack, needle,(uint32_t)(haystack), (uint32_t)(needle));
//    GS(txt, (int)strlen(txt), pat,  (int)strlen(pat), output);// FOUND?
//    XCTAssertTrue(output[0]>0);
//}

/////////////////////////////
//+++++++++++++++++++++++++++
// Two Way algorithm
//+++++++++++++++++++++++++++
/////////////////////////////
//Two Way algorithm
-(void)testTW{
    // TEXT
    char *txt = "xx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfoohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfoohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oo";
    // PATTERN
    char *pat = "ghfhgfhgfhgfh";
    // OUT
    int output[256] = {0};// ALG
    //   BOM(pat,txt,output);
    //  GS(txt, pat, strlen(txt),  strlen(pat));//(haystack, needle,(uint32_t)(haystack), (uint32_t)(needle));
    TW(pat,txt, output);
    // TW(txt, (int)strlen(txt), pat,  (int)strlen(pat), output);// FOUND?
    XCTAssertTrue(output[0]>0);
}

/////////////////////////////
//+++++++++++++++++++++++++++
// String Matching on Ordered Alphabets algorithm
//+++++++++++++++++++++++++++
/////////////////////////////
//String Matching on Ordered Alphabets algorithm
-(void)testSMOA{
    // TEXT
    char *txt = "xx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfoohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfoohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oo";
    // PATTERN
    char *pat = "ghfhgfhgfhgfh";
    // OUT
    int  output[256] = {0};// ALG
    //   BOM(pat,txt,output);
    //  GS(txt, pat, strlen(txt),  strlen(pat));//(haystack, needle,(uint32_t)(haystack), (uint32_t)(needle));
    SMOA(pat,txt, output);
    // TW(txt, (int)strlen(txt), pat,  (int)strlen(pat), output);// FOUND?
    XCTAssertTrue(output[0]>0);
}


/////////////////////////////
//+++++++++++++++++++++++++++
// Optimal Mismatch algorithm
//+++++++++++++++++++++++++++
/////////////////////////////
///Optimal Mismatch algorithm
//-(void)testOM{
//    // TEXT
//    char *txt = "xx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfoohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfoohgxxfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hghsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdoohgxx sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgfoohgxxhsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg sf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oohgxxgsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hggsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hgdsf65656 fgdgfdgfdggg ghfhgfhgfhgfh dgfg  d  jk hgdgh hg oo";
//    // PATTERN
//    char *pat = "hgdgh";
//    // OUT
//    int output[] = {0};
//    //   BOM(pat,txt,output);
//    //  GS(txt, pat, strlen(txt),  strlen(pat));//(haystack, needle,(uint32_t)(haystack), (uint32_t)(needle));
//    OM(pat, txt,output);
//    // TW(txt, (int)strlen(txt), pat,  (int)strlen(pat), output);// FOUND?
//    XCTAssertTrue(output[0]>0);
//}

/////////////////////////////
//+++++++++++++++++++++++++++
// Skip Search algorithm
//+++++++++++++++++++++++++++
/////////////////////////////
//Skip Search algorithm
/////////////////////////////
//+++++++++++++++++++++++++++
// Optimal Mismatch algorithm
//+++++++++++++++++++++++++++
/////////////////////////////
///Optimal Mismatch algorithm
-(void)testSKIP{
    // TEXT
    char *txt = "xx sf  d  jk hgdgh hghsf  d  jk hgdgh hggsf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxxdsf  d  jk hgdgh hghsf  d  jk hgdgh hg sf  d  jk hgdgh hgfsf  d  jk hgdgh hggoohgxxhsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hgdsf  d  jk hgdgh hggoohgxxfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgdsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hgfsf  d  jk hgdgh hg sf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxx sf  d  jk hgdgh hg sf  d  jk hgdgh hghsf  d  jk hgdgh hgfsf  d  jk hgdgh hg oohgxxdsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hg sf  d  jk hgdgh hgdsf  d  jk hgdgh hgdsf  d  jk hgdgh hgfoohgxxdsf  d  jk hgdgh hgdsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hg oohgxxhsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hg oo";
    // PATTERN
    char *pat = "hgdgh";
    // OUT
    int output[256] = {0};
    //   BOM(pat,txt,output);
    //  GS(txt, pat, strlen(txt),  strlen(pat));//(haystack, needle,(uint32_t)(haystack), (uint32_t)(needle));
    SKIP(pat,txt, output);
    // TW(txt, (int)strlen(txt), pat,  (int)strlen(pat), output);// FOUND?
    XCTAssertTrue(output[0]>0);
}

/////////////////////////////
//+++++++++++++++++++++++++++
//KMP Skip Search algorithm
//+++++++++++++++++++++++++++
/////////////////////////////
//KMP Skip Search algorithm
// BEST MULTI PATTERN I THINK....
-(void)testkmpSKIP{
    // TEXT
    char *txt = "xx sf  d  jk hgdgh hghsf  d  jk hgdgh hggsf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxxdsf  d  jk hgdgh hghsf  d  jk hgdgh hg sf  d  jk hgdgh hgfsf  d  jk hgdgh hggoohgxxhsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hgdsf  d  jk hgdgh hggoohgxxfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgdsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hgfsf  d  jk hgdgh hg sf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxx sf  d  jk hgdgh hg sf  d  jk hgdgh hghsf  d  jk hgdgh hgfsf  d  jk hgdgh hg oohgxxdsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hg sf  d  jk hgdgh hgdsf  d  jk hgdgh hgdsf  d  jk hgdgh hgfoohgxxdsf  d  jk hgdgh hgdsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hg oohgxxhsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hg oo";
    // PATTERN
    char *pat = "hgdgh";
    // OUT
    int output[256] = {0};
    //   BOM(pat,txt,output);
    //  GS(txt, pat, strlen(txt),  strlen(pat));//(haystack, needle,(uint32_t)(haystack), (uint32_t)(needle));
    KMPSKIP(pat,txt, output);
    // TW(txt, (int)strlen(txt), pat,  (int)strlen(pat), output);// FOUND?
    XCTAssertTrue(output[0]>0);
}
/////////////////////////////
//+++++++++++++++++++++++++++
// Alpha Skip Search algorithm
//+++++++++++++++++++++++++++
/////////////////////////////
//Alpha Skip Search algorithm
-(void)testkmpALPHASKIP{
    // TEXT
    char *txt = "xx sf  d  jk hgdgh hghsf  d  jk hgdgh hggsf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxxdsf  d  jk hgdgh hghsf  d  jk hgdgh hg sf  d  jk hgdgh hgfsf  d  jk hgdgh hggoohgxxhsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hgdsf  d  jk hgdgh hggoohgxxfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgdsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hgfsf  d  jk hgdgh hg sf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxx sf  d  jk hgdgh hg sf  d  jk hgdgh hghsf  d  jk hgdgh hgfsf  d  jk hgdgh hg oohgxxdsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hg sf  d  jk hgdgh hgdsf  d  jk hgdgh hgdsf  d  jk hgdgh hgfoohgxxdsf  d  jk hgdgh hgdsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hg oohgxxhsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hg oo";
    // PATTERN
    char *pat = "hgdgh";
    // OUT
    int output[256] = {0};
    //   BOM(pat,txt,output);
    //  GS(txt, pat, strlen(txt),  strlen(pat));//(haystack, needle,(uint32_t)(haystack), (uint32_t)(needle));
    ALPHASKIP(pat,txt, output);
    // TW(txt, (int)strlen(txt), pat,  (int)strlen(pat), output);// FOUND?
    XCTAssertTrue(output[0]>0);
}


/////////////////////////////
//+++++++++++++++++++++++++++
// Shift And algorithm
//+++++++++++++++++++++++++++
/////////////////////////////
-(void)testShiftAnd{
    // TEXT
    char *txt = "xx sf  d  jk hgdgh hghsf  d  jk hgdgh hggsf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxxdsf  d  jk hgdgh hghsf  d  jk hgdgh hg sf  d  jk hgdgh hgfsf  d  jk hgdgh hggoohgxxhsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hgdsf  d  jk hgdgh hggoohgxxfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgdsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hgfsf  d  jk hgdgh hg sf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxx sf  d  jk hgdgh hg sf  d  jk hgdgh hghsf  d  jk hgdgh hgfsf  d  jk hgdgh hg oohgxxdsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hg sf  d  jk hgdgh hgdsf  d  jk hgdgh hgdsf  d  jk hgdgh hgfoohgxxdsf  d  jk hgdgh hgdsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hg oohgxxhsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hg oo";
    // PATTERN
    char *pat = "hgdgh";
    // OUT
    int output[256] = {0};
    //   BOM(pat,txt,output);
    //  GS(txt, pat, strlen(txt),  strlen(pat));//(haystack, needle,(uint32_t)(haystack), (uint32_t)(needle));
    int s = ShiftAndsearch(pat,(int)strlen(pat),txt,(int)strlen(txt), output);
    // TW(txt, (int)strlen(txt), pat,  (int)strlen(pat), output);// FOUND?
    XCTAssertTrue(output[0]>0);
}
/////////////////////////////
//+++++++++++++++++++++++++++
////////////////////////======++++++++++++++++++++++++++++////////////////////////======++++++++++++++++++++++++++++
////////////////////////======++++++++++++++++++++++++++++////////////////////////======++++++++++++++++++++++++++++
// BROKEN - NEEDS WORK
//+++++++++++++++++++++++++++
/////////////////////////////


/////////////////////////////
//+++++++++++++++++++++++++++
// Quick Search algorithm
//+++++++++++++++++++++++++++
/////////////////////////////
//-(void)testQSA{
//    // TEXT
//    char *txt = "xx sf  d  jk hgdgh hghsf  d  jk hgdgh hggsf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxxdsf  d  jk hgdgh hghsf  d  jk hgdgh hg sf  d  jk hgdgh hgfsf  d  jk hgdgh hggoohgxxhsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hgdsf  d  jk hgdgh hggoohgxxfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgdsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hgfsf  d  jk hgdgh hg sf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxx sf  d  jk hgdgh hg sf  d  jk hgdgh hghsf  d  jk hgdgh hgfsf  d  jk hgdgh hg oohgxxdsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hg sf  d  jk hgdgh hgdsf  d  jk hgdgh hgdsf  d  jk hgdgh hgfoohgxxdsf  d  jk hgdgh hgdsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hg oohgxxhsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hg oo";
//    // PATTERN
//    char *pat = "hgdgh";
//    // OUT
//    int m = (int)strlen(txt);
//    int n = (int)strlen(pat);
//    int output[256] = {0};;// ALG
//    BR(pat,n,txt,m);
//    // FOUND?
//    XCTAssertTrue(output[0]!=0);
//}


/////////////////////////////
//+++++++++++++++++++++++++++
// Tuned Boyer-Moore algorithm
//+++++++++++++++++++++++++++
/////////////////////////////
//-(void)testTUBM{
//    // TEXT
//    char *txt = "xx sf  d  jk hgdgh hghsf  d  jk hgdgh hggsf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxxdsf  d  jk hgdgh hghsf  d  jk hgdgh hg sf  d  jk hgdgh hgfsf  d  jk hgdgh hggoohgxxhsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hgdsf  d  jk hgdgh hggoohgxxfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgdsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hgfsf  d  jk hgdgh hg sf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxx sf  d  jk hgdgh hg sf  d  jk hgdgh hghsf  d  jk hgdgh hgfsf  d  jk hgdgh hg oohgxxdsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hg sf  d  jk hgdgh hgdsf  d  jk hgdgh hgdsf  d  jk hgdgh hgfoohgxxdsf  d  jk hgdgh hgdsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hg oohgxxhsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hg oo";
//    // PATTERN
//    char *pat = "hgdgh";
//    // OUT
//    int output[256] = {0};;// ALG
//    TUNEDBM(pat,txt,output);
//    // FOUND?
//    XCTAssertTrue(output[0]!=0);
//}


/////////////////////////////
//+++++++++++++++++++++++++++
// Zalgo
//+++++++++++++++++++++++++++
/////////////////////////////
//-(void)testZalgo{
//    // TEXT
//    char *txt = "xx sf  d  jk hgdgh hghsf  d  jk hgdgh hggsf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxxdsf  d  jk hgdgh hghsf  d  jk hgdgh hg sf  d  jk hgdgh hgfsf  d  jk hgdgh hggoohgxxhsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hgdsf  d  jk hgdgh hggoohgxxfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgdsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hgfsf  d  jk hgdgh hg sf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxx sf  d  jk hgdgh hg sf  d  jk hgdgh hghsf  d  jk hgdgh hgfsf  d  jk hgdgh hg oohgxxdsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hg sf  d  jk hgdgh hgdsf  d  jk hgdgh hgdsf  d  jk hgdgh hgfoohgxxdsf  d  jk hgdgh hgdsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hg oohgxxhsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hg oo";
//    // PATTERN
//    char *pat = "hgdgh";
//    // OUT
//    int output[256] = {0};;// ALG
//    zalgo(pat,txt,output);
//    // FOUND?
//    XCTAssertTrue(output[0]!=0);
//}

/////////////////////////////
//+++++++++++++++++++++++++++
// Berry-Ravindran algorithm
//+++++++++++++++++++++++++++
/////////////////////////////

/////////////////////////////
//+++++++++++++++++++++++++++
// Smith algorithm
//+++++++++++++++++++++++++++
/////////////////////////////
//Smith algorithm
//-(void)testSMITH{
//    // TEXT
//      char *txt = "xx sf  d  jk hgdgh hghsf  d  jk hgdgh hggsf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxxdsf  d  jk hgdgh hghsf  d  jk hgdgh hg sf  d  jk hgdgh hgfsf  d  jk hgdgh hggoohgxxhsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hgdsf  d  jk hgdgh hggoohgxxfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgdsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hgfsf  d  jk hgdgh hg sf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxx sf  d  jk hgdgh hg sf  d  jk hgdgh hghsf  d  jk hgdgh hgfsf  d  jk hgdgh hg oohgxxdsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hg sf  d  jk hgdgh hgdsf  d  jk hgdgh hgdsf  d  jk hgdgh hgfoohgxxdsf  d  jk hgdgh hgdsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hg oohgxxhsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hg oo";
//    // PATTERN
//      char *pat = "hgdoohgxxdsf";
//
//    int m = (int)strlen(txt);
//    int n = (int)strlen(pat);
//    // OUT
//    int output[256] = {0};;// ALG
//    SMITH(txt,m,pat,n,output);
//    // FOUND?
//    XCTAssertTrue(output[0]!=0);
//}


/////////////////////////////
//+++++++++++++++++++++++++++
// Raita algorithm
//+++++++++++++++++++++++++++
/////////////////////////////
//Raita algorithm


/////////////////////////////
//+++++++++++++++++++++++++++
// Reverse Factor algorithm
//+++++++++++++++++++++++++++
/////////////////////////////
//Reverse Factor algorithm
//-(void)testRFA{
//    // TEXT
//    char *txt = "xx sf  d  jk hgdgh hghsf  d  jk hgdgh hggsf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxxdsf  d  jk hgdgh hghsf  d  jk hgdgh hg sf  d  jk hgdgh hgfsf  d  jk hgdgh hggoohgxxhsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hgdsf  d  jk hgdgh hggoohgxxfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgfsf  d  jk hgdgh hgdsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hgfsf  d  jk hgdgh hg sf  d  jk hgdgh hggsf  d  jk hgdgh hgdoohgxx sf  d  jk hgdgh hg sf  d  jk hgdgh hghsf  d  jk hgdgh hgfsf  d  jk hgdgh hg oohgxxdsf  d  jk hgdgh hgfsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hgdoohgxxgsf  d  jk hgdgh hg sf  d  jk hgdgh hgdsf  d  jk hgdgh hgdsf  d  jk hgdgh hgfoohgxxdsf  d  jk hgdgh hgdsf  d  jk hgdgh hggsf  d  jk hgdgh hghsf  d  jk hgdgh hg oohgxxhsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hghsf  d  jk hgdgh hg oo";
//    // PATTERN
//    char *pat = "hgdoohgxxdsf";
//
//    int m = (int)strlen(txt);
//    int n = (int)strlen(pat);
//    // OUT
//    int output[256] = {0};;// ALG
//    RF(pat,n,txt,m,output);
//    // FOUND?
//    XCTAssertTrue(output[0]!=0);
//}

/////////////////////////////
//+++++++++++++++++++++++++++
// Turbo Reverse Factor algorithm
//+++++++++++++++++++++++++++
/////////////////////////////
//Turbo Reverse Factor algorithm


/////////////////////////////
//+++++++++++++++++++++++++++
// Forward Dawg Matching algorithm
//+++++++++++++++++++++++++++
/////////////////////////////
//Forward Dawg Matching algorithm


/////////////////////////////
//+++++++++++++++++++++++++++
// Backward Nondeterministic Dawg Matching algorithm
//+++++++++++++++++++++++++++
/////////////////////////////
//Backward Nondeterministic Dawg Matching algorithm
////////////////////////======++++++++++++++++++++++++++++////////////////////////======++++++++++++++++++++++++++++
////////////////////////======++++++++++++++++++++++++++++////////////////////////======++++++++++++++++++++++++++++


- (void)testExample {
    // This is an example of a functional test case.
    //    // Use XCTAssert and related functions to verify your tests produce the correct results. char txt[] = "GEEKS FOR GEEKS";
    //   void BF(char *x, int m, char *y, int n, char out[], bool bFirstOnly)
    //
    //    char txt[] = "GEEKS FOR GEEKS";
    //    char pat[] = "GEEK";
    //    int m = (int)strlen(txt);
    //    int q = 101; // A prime number
    //    MTK(pat, txt, q);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
