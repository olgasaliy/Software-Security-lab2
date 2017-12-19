//
//  Generator.h
//  lab2
//
//  Created by Olga Saliy on 12/17/17.
//  Copyright © 2017 Olga Saliy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppConstants.h"
#import "MTRandom.h"
#import "Service.h"

@interface Generator : NSObject

@property (assign) NSInteger last;
@property (assign) uint32_t realNumber;
@property BOOL seedDiscovered;

- (void)discoverSeed;
- (NSInteger)nextLcg;
- (int)nextMt;


@end
