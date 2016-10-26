//
//  NSObject+jsonStr.m
//  Prediscore
//
//  Created by Hamidreza Vaklian on 6/2/16.
//  Copyright © 2016 pxlmind. All rights reserved.
//

#import "NSObject+jsonStr.h"

@implementation NSObject (jsonStr)

-(NSString *)jsonStrPretty
{
    return nil;
}
-(NSString *)jsonStr
{
    return nil;
}

@end

@implementation NSArray (jsonStr)

-(NSString *)jsonStrPretty
{
    NSError* error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    if (error) {NSLog(@"NSObject+jsonStr: jsonStr %@ ---- %@", error, self); return nil;}
    
    return jsonString;
}

-(NSString *)jsonStr
{
    NSError* error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    if (error) {NSLog(@"NSObject+jsonStr: jsonStr %@ ---- %@", error, self); return nil;}
    
    return jsonString;
}

@end

@implementation NSDictionary (jsonStr)

-(NSString *)jsonStrPretty
{
    NSError* error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    if (error) {NSLog(@"NSObject+jsonStr: jsonStr %@ ---- %@", error, self); return nil;}
    
    return jsonString;
}

-(NSString *)jsonStr
{
    NSError* error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    if (error) {NSLog(@"NSObject+jsonStr: jsonStr %@ ---- %@", error, self); return nil;}
    
    return jsonString;
}

@end
