//
//  DetailedKeyView.h
//  RSA
//
//  Created by Marcel Boersma on 5/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSAKeys.h"

@interface DetailedKeyView : UITableViewController {
       RSAKeys *rsaKey;
}

-(void)setRSAKey:(RSAKeys*)key;

@end
