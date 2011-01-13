//
//  MNTitle.m
//  FMMindnodeKit
//
//  Created by Felix Morgner on 26.11.10.
//  Copyright 2010 Felix Morgner. All rights reserved.
//

#import "FMMindnodeTitle.h"


@implementation FMMindnodeTitle

@synthesize constrainedWidth, shrinkToFitContent, text;

- (id) init
	{
	if((self = [super init]))
		{
		self.constrainedWidth = 0;
		self.shrinkToFitContent = 0;
		self.text = nil;
		}
		
	return self;
	}

- (id) initWithDictionary:(NSDictionary*)theDictionary
	{
		if((self = [super init]))
		{
		[self setConstrainedWidth:[[theDictionary valueForKey:@"constrainedWidth"] intValue]];
		[self setShrinkToFitContent:[[theDictionary valueForKey:@"shrinkToFitContent"] intValue]];

		NSData* textRTFData = [[theDictionary objectForKey:@"text"] dataUsingEncoding:NSASCIIStringEncoding];
			
		[self setText:[[NSTextStorage alloc] initWithRTF:textRTFData documentAttributes:nil]];
		}
		
	return self;
	}

+ (id) titleWithDictionary:(NSDictionary*)theDictionary
	{
	return [[[FMMindnodeTitle alloc] initWithDictionary:theDictionary] autorelease];
	}

- (NSString*) stringValue
	{
	return [text string];
	}

@end
