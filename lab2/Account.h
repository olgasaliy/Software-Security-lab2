//
//  Account.h
//  lab2
//
//  Created by Olga Saliy on 12/17/17.
//  Copyright © 2017 Olga Saliy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject

@property (strong, nonatomic) NSNumber *money;
@property (strong, nonatomic) NSString *identifier;
@property (strong, nonatomic) NSString *deletionTime;

+ (instancetype)sharedAccount;

@end
