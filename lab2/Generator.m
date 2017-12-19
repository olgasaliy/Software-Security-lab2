//
//  Generator.m
//  lab2
//
//  Created by Olga Saliy on 12/17/17.
//  Copyright © 2017 Olga Saliy. All rights reserved.
//

#import "Generator.h"

@interface Generator ()

@property (strong, nonatomic) MTRandom *random;

@end

@implementation Generator

- (instancetype)init
{
    self = [super init];
    if (self) {
        _last = 0;
        _seedDiscovered = NO;
        _random = [[MTRandom alloc] init];
    }
    return self;
}

- (NSInteger)nextLcg {
    _last = (kA * _last + kC) % (NSInteger)pow(2, 32); 
    return (NSInteger)_last;
}

- (void)discoverSeed {
    //simulate service's generator
    MTRandom *mine = [[MTRandom alloc] initWithSeed: (int32_t)time(NULL) - 105];
    self.realNumber = [mine randomUInt32];
    
    //create our own generator
    int32_t seed = (int32_t)time(NULL);
    for (int32_t offset = 0; offset <= 10000; ++offset) {
        _random = [[MTRandom alloc] initWithSeed: (int32_t)(seed - offset)];
        uint32_t number = [_random randomUInt32];
        NSLog(@"%u == %u", number, _realNumber);
        if (number == _realNumber) {
            _seedDiscovered = YES;
            break;
        }
    }
}

- (int)nextMt {
    if (_seedDiscovered) {
        int result = [_random randomUInt32];
        return result;
    }
    return 0;
}

@end
