//
//  Service.m
//  lab2
//
//  Created by Olga Saliy on 12/17/17.
//  Copyright © 2017 Olga Saliy. All rights reserved.
//

#import "Service.h"

@interface Service ()

@property (strong, nonatomic) AFHTTPSessionManager *manager;

@end

@implementation Service

-(instancetype)init {
    self = [super init];
    if (self) {
        _manager = [AFHTTPSessionManager manager];
        [_manager.responseSerializer setAcceptableContentTypes:[NSSet setWithArray:@[@"application/json"]]];
    }
    return self;
}

-(void)createAccountWithBlock:(void(^)(NSError *error))block {
    NSDictionary *params = @{@"id": accId};
    [_manager GET:kServiceAccountCreationUrl parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *responseDict = responseObject;
            [[Account sharedAccount] setDeletionTime: responseDict[@"deletionTime"]];
            [[Account sharedAccount] setMoney:responseObject[@"money"]];
            [[Account sharedAccount] setIdentifier:accId];
            if (block)
                block(nil);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
        if (block)
            block(error);
    }];
}

-(void)makeBet:(NSInteger)money onNumber:(NSInteger)number inMode:(NSString *)mode withBlock:(void(^)(id responseObject, NSError *error))block {
    NSDictionary *params = @{@"id": accId, @"bet": @(money), @"number": @(number)};
    [_manager GET: [kServicePlayUrl stringByAppendingString:mode] parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *responseDict = responseObject;
            NSDictionary *account = responseDict[@"account"];
            [[Account sharedAccount] setMoney:account[@"money"]];
            if (block)
                block(responseDict[@"realNumber"], nil);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
        if (block)
            block(nil, error);
    }];
}

@end
