//
//  GTMNSData+zlib.h
//
//  Copyright 2007-2008 Google Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License"); you may not
//  use this file except in compliance with the License.  You may obtain a copy
//  of the License at
// 
//  http://www.apache.org/licenses/LICENSE-2.0
// 
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
//  WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
//  License for the specific language governing permissions and limitations under
//  the License.
//

#import <Foundation/Foundation.h>

@interface NSData (ZLibAdditions)

+ (NSData *)dataByGzippingBytes:(const void *)bytes length:(NSUInteger)length;

+ (NSData *)dataByGzippingData:(NSData *)data;

+ (NSData *)dataByGzippingBytes:(const void *)bytes length:(NSUInteger)length compressionLevel:(int)level;

+ (NSData *)dataByGzippingData:(NSData *)data compressionLevel:(int)level;

+ (NSData *)dataByDeflatingBytes:(const void *)bytes length:(NSUInteger)length;

+ (NSData *)dataByDeflatingData:(NSData *)data;

+ (NSData *)dataByDeflatingBytes:(const void *)bytes length:(NSUInteger)length compressionLevel:(int)level;

+ (NSData *)dataByDeflatingData:(NSData *)data compressionLevel:(int)level;

+ (NSData *)dataByInflatingBytes:(const void *)bytes length:(NSUInteger)length;

+ (NSData *)dataByInflatingData:(NSData *)data;

@end
