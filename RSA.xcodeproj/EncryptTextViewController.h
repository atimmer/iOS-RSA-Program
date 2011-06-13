//
//  EncryptTextViewController.h
//  RSA
//
//  Created by Marcel Boersma on 6/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "RSAKeys.h"

@interface EncryptTextViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate>
{
    RSAKeys *currentKey;
}


@property (nonatomic, retain) IBOutlet UITextField *toEncryptText;
@property (nonatomic, retain) IBOutlet UITextView *encryptedText;
@property (nonatomic, retain) IBOutlet UIPickerView *picker;

@property (nonatomic, retain) IBOutlet NSFetchedResultsController *frc;

- (void)didEndEditingToEncryptTextField:(id)sender;

@end
