//
//  RSAKeys.h
//  RSA
//
//  Created by Marcel Boersma on 6/1/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface RSAKeys : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * Name;
@property (nonatomic, retain) NSNumber * PublicKey;
@property (nonatomic, retain) NSNumber * PrivateKey;
@property (nonatomic, retain) NSNumber * PrimeA;
@property (nonatomic, retain) NSNumber * PrimeB;
@property (nonatomic, retain) NSNumber * N;
@property (nonatomic, retain) NSNumber * Z;

@end
