//
//  EncryptViewController.h
//  RSA
//
//  Created by Anton Timmermans on 19-05-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EncryptViewController : UIViewController <UITextViewDelegate> {
    IBOutlet UITextView *toEncryptText;
    IBOutlet UITextView *encryptedText;
}

@end
