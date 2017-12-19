//
//  Service.h
//  lab2
//
//  Created by Olga Saliy on 12/17/17.
//  Copyright © 2017 Olga Saliy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "AppConstants.h"
#import "Account.h"

@interface Service : NSObject

-(void)createAccountWithBlock:(void(^)(NSError *error))block;
-(void)makeBet:(NSInteger)money onNumber:(NSInteger)number inMode:(NSString *)mode withBlock:(void(^)(id responseObject, NSError *error))block;

@end
