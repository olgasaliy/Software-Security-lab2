//
//  WorkClass.m
//  lab2
//
//  Created by Olga Saliy on 12/17/17.
//  Copyright © 2017 Olga Saliy. All rights reserved.
//

#import "WorkClass.h"

@interface WorkClass ()

@property (assign) NSInteger goal;
@property (strong, nonatomic) Generator *generator;
@property (strong, nonatomic) Service *service;

@end

@implementation WorkClass

- (instancetype)init
{
    self = [super init];
    if (self) {
        _generator = [[Generator alloc] init];
        _service = [[Service alloc] init];
        _goal = 1000000;
    }
    return self;
}

- (void)mainFunction {
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    [self.service createAccountWithBlock:^(NSError *error) {
        dispatch_group_leave(group);
    }];
    
    dispatch_group_notify(group ,dispatch_get_main_queue(),^{
        [self lcgMode];
    });
    //        [h createAccount];
    //[s makeBet:10 onNumber:10 withMode:LCGMode];
}

- (void)lcgMode {
    [self.service makeBet:100 onNumber:[self.generator nextLcg] inMode:LCGMode withBlock:^(id responseObject, NSError *error) {
        self.generator.last = [responseObject integerValue];
        NSLog(@"goal = %ld, actual = %ld", (long)self.goal, (long)[Account sharedAccount].money.integerValue);
        int actual = [Account sharedAccount].money.intValue;
        if (self.goal > actual) {
            [self lcgMode];
        }
    }];
}

- (void)mtMode {
    [self.generator discoverSeed];
    /*if (self.generator.seedDiscovered) {
        [self.service makeBet:1 onNumber:[self.generator nextMt] inMode:MtMode withBlock:^(id responseObject, NSError *error) {
            //        self.generator.realNumber = (int32_t)responseObject;
            NSLog(@"goal = %ld, actual = %ld", (long)self.goal, (long)[Account sharedAccount].money.integerValue);
            int actual = [Account sharedAccount].money.intValue;
            if (self.goal > actual) {
                [self mtMode];
            }
        }];
    }*/
}

@end
