//
//  FMMindnodeDocument.m
//  FMMindnodeKit
//
//  Created by Felix Morgner on 26.11.10.
//  Copyright 2010 Felix Morgner. All rights reserved.
//

#import "FMMindnodeDocument.h"

#import "ZKDefs.h"
#import "ZKDataArchive.h"
#import "ZKCDHeader.h"

@implementation FMMindnodeDocument

@synthesize author, comments, keywords, title, mindMap, printInfo, windowConfig, isUsingConstrainedLayout, version, delegate;

- (id) init
	{
	if(self = [super init])
		{
		self.author = nil;
		self.comments = nil;
		self.keywords = nil;
		self.title = nil;
		
		self.mindMap = nil;
		
		self.printInfo = nil;
		
		self.windowConfig = nil;
		
		self.isUsingConstrainedLayout = NO;
		
		self.version = 0;
		}
	return self;
	}

- (id) initWithDictionary:(NSDictionary*)theDictionary
	{
	if(self = [super init])
		{
		[self setAuthor:[theDictionary valueForKey:@"author"]];
		[self setComments:[theDictionary valueForKey:@"comments"]];
		[self setKeywords:[theDictionary valueForKey:@"keywords"]];
		[self setTitle:[theDictionary valueForKey:@"title"]];
		
		[self setMindMap:[FMMindnodeMindmap mindmapWithDictionary:[theDictionary objectForKey:@"mindMap"]]];
		
		[self setPrintInfo:[NSUnarchiver unarchiveObjectWithData:[theDictionary objectForKey:@"printInfo"]]];
		
		[self setWindowConfig:[theDictionary objectForKey:@"windowConfig"]];
		
		[self setIsUsingConstrainedLayout: [[theDictionary valueForKey:@"isUsingConstrainedLayout"] boolValue]];
		
		[self setVersion:[[theDictionary valueForKey:@"version"] intValue]];
		}
	return self;
	}

+ (id) documentWithDictionary:(NSDictionary*)theDictionary
	{
	return [[[FMMindnodeDocument alloc] initWithDictionary:theDictionary] autorelease];
	}

+ (id) documentWithContentOfFile:(NSString*)path
	{
	NSDictionary* xmlDictionary = nil;
	NSError* error = nil;
	FMMindnodeDocument* returnDocument = nil;
	
	ZKDataArchive* archive = [ZKDataArchive archiveWithArchivePath:path];
	NSUInteger status = [archive inflateAll];

	if(status == zkSucceeded)
		{
		NSDictionary* fileInfo = [[archive inflatedFiles] objectAtIndex:0];
		NSData* xmlData = [fileInfo valueForKey:@"fileData"];
		xmlDictionary = [NSPropertyListSerialization propertyListWithData:xmlData options:0 format:NULL error:&error];
		if(error == nil)
			{
			returnDocument = [FMMindnodeDocument documentWithDictionary:xmlDictionary];
			}
		}
	
	return returnDocument;
	}
@end
