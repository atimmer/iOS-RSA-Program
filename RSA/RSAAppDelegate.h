//
//  RSAAppDelegate.h
//  RSA
//
//  Created by Marcel Boersma(1) on 5/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RSAViewController;

@interface RSAAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet RSAViewController *viewController;

@end
