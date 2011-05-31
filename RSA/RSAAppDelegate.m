//
//  RSAAppDelegate.m
//  RSA
//
//  Created by Marcel Boersma on 5/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RSAAppDelegate.h"


@implementation RSAAppDelegate


@synthesize  myNavigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    return YES;
}

-(void)dealloc
{
    [myNavigationController release];
    [super dealloc];
}

@end
