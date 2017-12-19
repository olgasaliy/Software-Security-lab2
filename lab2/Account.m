//
//  Account.m
//  lab2
//
//  Created by Olga Saliy on 12/17/17.
//  Copyright © 2017 Olga Saliy. All rights reserved.
//

#import "Account.h"

@implementation Account

+ (instancetype)sharedAccount {
    static Account *sharedAcc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAcc = [[self alloc] init];
    });
    return sharedAcc;
}

@end
