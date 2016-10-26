//
//  helper.h
//  PrediAdmin
//
//  Created by parastoo on 7/11/1395 AP.
//  Copyright © 1395 AP parastoo. All rights reserved.
//

#import <Foundation/Foundation.h>

#define _mainThread(block) dispatch_async(dispatch_get_main_queue(), ^{block});

@interface helper : NSObject

+(NSURLSessionTask*)serverGetWithPath:(NSString*)path completion:(void (^) (long response_code, id obj))completionHandler;

@end
