//
//  PrimeView.h
//  RSA
//
//  Created by Marcel Boersma on 5/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PrimeView : UIViewController<UIPickerViewDataSource> {
    
}

-(IBAction)doneButtonClicked:(id)sender;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *doneButton;

@end
