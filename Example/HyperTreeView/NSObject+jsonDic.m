//
//  NSString+jsonDic.m
//  emGarson
//
//  Created by hAmidReza on 7/16/14.
//  Copyright (c) 2014 Hamidreza Vakilian. All rights reserved.
//

#import "NSObject+jsonDic.h"

@implementation NSObject (jsonDic)

-(id)jsonDic
{
    return nil;
}

@end

@implementation NSString (jsonDic)

-(id)jsonDic
{
    NSError *error;
	id jsonDic = [NSJSONSerialization
							 JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding]
							 options:NSJSONReadingMutableContainers
							 error:&error];
	
	if(error) {NSLog(@"NSString+jsonDic: jsonDic %@ ---- %@", error, self); return nil;}
	
	return jsonDic;
}

@end

@implementation NSData (jsonDic)

-(id)jsonDic
{
    NSError *error;
    id jsonDic = [NSJSONSerialization
                                    JSONObjectWithData:self
                                    options:NSJSONReadingMutableContainers
                                    error:&error];
    
    if(error) {NSLog(@"NSData+jsonDic: jsonDic %@ ---- %@", error, self); return nil;}
    
    return jsonDic;
}

@end
