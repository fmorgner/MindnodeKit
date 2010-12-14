//
//  FMMindnodeDocument.h
//  FMMindnodeKit
//
//  Created by Felix Morgner on 26.11.10.
//  Copyright 2010 Felix Morgner. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FMMindnodeMindmap.h"

@interface FMMindnodeDocument : NSObject
	{
	NSString* author;
	NSString* comments;
	NSString* keywords;
	NSString* title;

	FMMindnodeMindmap* mindMap;

	NSPrintInfo* printInfo;

	NSDictionary* windowConfig;

	BOOL isUsingConstrainedLayout;

	NSInteger version;	
	}

- (id) initWithDictionary:(NSDictionary*)theDictionary;
+ (id) documentWithDictionary:(NSDictionary*)theDictionary;

+ (id) documentWithContentOfFile:(NSString*)path;

@property(nonatomic, retain) NSString* author;
@property(nonatomic, retain) NSString* comments;
@property(nonatomic, retain) NSString* keywords;
@property(nonatomic, retain) NSString* title;

@property(nonatomic, retain) FMMindnodeMindmap* mindMap;

@property(nonatomic, retain) NSPrintInfo* printInfo;

@property(nonatomic, retain) NSDictionary* windowConfig;

@property(nonatomic, assign) BOOL isUsingConstrainedLayout;

@property(nonatomic, assign) NSInteger version;

@property(nonatomic, assign) id delegate; 


@end
