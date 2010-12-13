//
//  GTMNSData+zlib.m
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

#import "NSData+zlib.h"
#import <zlib.h>

#define kChunkSize 1024

@interface NSData (GTMZlibAdditionsPrivate)

+ (NSData *)dataByCompressingBytes:(const void *)bytes length:(NSUInteger)length compressionLevel:(int)level useGzip:(BOOL)useGzip;

@end

@implementation NSData (GTMZlibAdditionsPrivate)

+ (NSData *)dataByCompressingBytes:(const void *)bytes length:(NSUInteger)length compressionLevel:(int)level useGzip:(BOOL)useGzip
	{
  
	if (!bytes || !length)
		{
    return nil;
		}
  
  if (level == Z_DEFAULT_COMPRESSION)
		{
    // the default value is actually outside the range, so we have to let it
    // through specifically.
		}
	else if (level < Z_BEST_SPEED)
		{
    level = Z_BEST_SPEED;
		}
	else if (level > Z_BEST_COMPRESSION)
		{
    level = Z_BEST_COMPRESSION;
		}

  z_stream strm;
  bzero(&strm, sizeof(z_stream));

  int windowBits = 15; // the default
  int memLevel = 8; // the default
  
	if (useGzip)
		{
    windowBits += 16; // enable gzip header instead of zlib header
		}
		
  int retCode;
  
	if ((retCode = deflateInit2(&strm, level, Z_DEFLATED, windowBits, memLevel, Z_DEFAULT_STRATEGY)) != Z_OK)
		{
    return nil;
		}

  // hint the size at 1/4 the input size
  NSMutableData *result = [NSMutableData dataWithCapacity:(length/4)];
  unsigned char output[kChunkSize];

  // setup the input
  strm.avail_in = (unsigned int)length;
  strm.next_in = (unsigned char*)bytes;

  // loop to collect the data
  do {
    // update what we're passing in
    strm.avail_out = kChunkSize;
    strm.next_out = output;
    retCode = deflate(&strm, Z_FINISH);
    if ((retCode != Z_OK) && (retCode != Z_STREAM_END)) {
      // COV_NF_START - no real way to force this in a unittest
      // (in inflate, we can feed bogus/truncated data to test, but an error
      // here would be some internal issue w/in zlib, and there isn't any real
      // way to test it)
      deflateEnd(&strm);
      return nil;
      // COV_NF_END
    }
    // collect what we got
    unsigned gotBack = kChunkSize - strm.avail_out;
    if (gotBack > 0) {
      [result appendBytes:output length:gotBack];
    }

  } while (retCode == Z_OK);

  // clean up
  deflateEnd(&strm);

  return result;
} // dataByCompressingBytes:length:compressionLevel:useGzip:
  

@end


@implementation NSData (GTMZLibAdditions)

+ (NSData *)dataByGzippingBytes:(const void *)bytes length:(NSUInteger)length
	{
  return [self dataByCompressingBytes:bytes
                                   length:length
                         compressionLevel:Z_DEFAULT_COMPRESSION
                                  useGzip:YES];
} // dataByGzippingBytes:length:

+ (NSData *)dataByGzippingData:(NSData *)data {
  return [self dataByCompressingBytes:[data bytes]
                                   length:[data length]
                         compressionLevel:Z_DEFAULT_COMPRESSION
                                  useGzip:YES];
} // dataByGzippingData:

+ (NSData *)dataByGzippingBytes:(const void *)bytes
                             length:(NSUInteger)length
                   compressionLevel:(int)level {
  return [self dataByCompressingBytes:bytes
                                   length:length
                         compressionLevel:level
                                  useGzip:YES];
} // dataByGzippingBytes:length:level:

+ (NSData *)dataByGzippingData:(NSData *)data
                  compressionLevel:(int)level {
  return [self dataByCompressingBytes:[data bytes]
                                   length:[data length]
                         compressionLevel:level
                                  useGzip:YES];
} // dataByGzippingData:level:

+ (NSData *)dataByDeflatingBytes:(const void *)bytes
                              length:(NSUInteger)length {
  return [self dataByCompressingBytes:bytes
                                   length:length
                         compressionLevel:Z_DEFAULT_COMPRESSION
                                  useGzip:NO];
} // dataByDeflatingBytes:length:

+ (NSData *)dataByDeflatingData:(NSData *)data {
  return [self dataByCompressingBytes:[data bytes]
                                   length:[data length]
                         compressionLevel:Z_DEFAULT_COMPRESSION
                                  useGzip:NO];
} // dataByDeflatingData:

+ (NSData *)dataByDeflatingBytes:(const void *)bytes
                              length:(NSUInteger)length
                    compressionLevel:(int)level {
  return [self dataByCompressingBytes:bytes
                                   length:length
                         compressionLevel:level
                                  useGzip:NO];
} // dataByDeflatingBytes:length:level:

+ (NSData *)dataByDeflatingData:(NSData *)data
                   compressionLevel:(int)level {
  return [self dataByCompressingBytes:[data bytes]
                                   length:[data length]
                         compressionLevel:level
                                  useGzip:NO];
} // dataByDeflatingData:level:

+ (NSData *)dataByInflatingBytes:(const void *)bytes
                              length:(NSUInteger)length {
  if (!bytes || !length) {
    return nil;
  }
  
  // TODO: support 64bit inputs
  // avail_in is a uInt, so if length > UINT_MAX we actually need to loop
  // feeding the data until we've gotten it all in.  not supporting this
  // at the moment.

  z_stream strm;
  bzero(&strm, sizeof(z_stream));

  // setup the input
  strm.avail_in = (unsigned int)length;
  strm.next_in = (unsigned char*)bytes;

  int windowBits = 15; // 15 to enable any window size
  windowBits += 32; // and +32 to enable zlib or gzip header detection.
  int retCode;
  if ((retCode = inflateInit2(&strm, windowBits)) != Z_OK) {
    // COV_NF_START - no real way to force this in a unittest (we guard all args)
    return nil;
    // COV_NF_END
  }

  // hint the size at 4x the input size
  NSMutableData *result = [NSMutableData dataWithCapacity:(length*4)];
  unsigned char output[kChunkSize];

  // loop to collect the data
  do {
    // update what we're passing in
    strm.avail_out = kChunkSize;
    strm.next_out = output;
    retCode = inflate(&strm, Z_NO_FLUSH);
    if ((retCode != Z_OK) && (retCode != Z_STREAM_END)) {
      inflateEnd(&strm);
      return nil;
    }
    // collect what we got
    unsigned gotBack = kChunkSize - strm.avail_out;
    if (gotBack > 0) {
      [result appendBytes:output length:gotBack];
    }

  } while (retCode == Z_OK);

  // make sure there wasn't more data tacked onto the end of a valid compressed
  // stream.
  if (strm.avail_in != 0) {
    result = nil;
  }
  // the only way out of the loop was by hitting the end of the stream

  // clean up
  inflateEnd(&strm);

  return result;
} // dataByInflatingBytes:length:

+ (NSData *)dataByInflatingData:(NSData *)data {
  return [self dataByInflatingBytes:[data bytes]
                                 length:[data length]];
} // dataByInflatingData:

@end
