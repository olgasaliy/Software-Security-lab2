//
//  main.m
//  lab2
//
//  Created by Olga Saliy on 12/17/17.
//  Copyright © 2017 Olga Saliy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WorkClass.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        [[[WorkClass alloc] init] mainFunction];
        [[NSRunLoop currentRunLoop] run];
    }
    return 0;
}
