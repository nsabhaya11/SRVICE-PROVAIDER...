//
//  base64.h
//  Project
//
//  Created by Tops on 6/26/14.
//  Copyright (c) 2014 Tops. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface base64 : NSObject
{
    
}
+ (void) initialize;
+ (NSString*) encode:(const uint8_t*) input length:(NSInteger) length;
+ (NSString*) encode:(NSData*) rawBytes;
+ (NSData*) decode:(const char*) string length:(NSInteger) inputLength;
+ (NSData*) decode:(NSString*) string;

@end
