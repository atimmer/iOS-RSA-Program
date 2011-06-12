//
//  RSAKeyGenerator.h
//  RSA
//
//  Created by Marcel Boersma on 6/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSAKeyGenerator : NSObject
{
    
}

@property (nonatomic, retain) IBOutlet NSDecimalNumber *primeA;
@property (nonatomic, retain) IBOutlet NSDecimalNumber *primeB;

@property (nonatomic, retain) IBOutlet NSDecimalNumber *n;
@property (nonatomic, retain) IBOutlet NSDecimalNumber *z;

@property (nonatomic, retain) IBOutlet NSDecimalNumber *publicKey;
@property (nonatomic, retain) IBOutlet NSDecimalNumber *privateKey;




-(void)calculateKeyWithPrimeA:(NSDecimalNumber*)aPrime andPrimeB:(NSDecimalNumber*)bPrime;

-(NSString*)decrypteMessage:(NSString*)message;
-(NSString*)encrypteMessage:(NSString*)message;

-(int) GCDWithIntA: (int) a andIntB:(int) b;

@end
