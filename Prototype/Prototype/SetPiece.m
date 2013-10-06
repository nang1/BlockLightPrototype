//
//  SetPiece.m
//  Prototype
//
//  Created by nang1 on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import "SetPiece.h"

@implementation SetPiece

@synthesize name = _name;
@synthesize uniqueID = _uniqueID;
@synthesize icon = _icon;

-(id) init{
    self = [super init];
    
    if(self == nil)
        return nil;
    
    return self;
}

/* Save feature
- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:_name forKey:@"setPieceName"];
    [encoder encodeObject:_uniqueID forKey:@"setPieceID"];
    [encoder encodeObject:UIImagePNGRepresentation(_icon) forKey:@"setPieceIcon"];
}

- (id)initWithCoder:(NSCoder *)decoder{
    if(self = [super init]){
        self.name = [decoder decodeObjectForKey:@"setPieceName"];
        self.uniqueID = [decoder decodeObjectForKey:@"setPieceID"];
        self.icon = [UIImage imageWithData:[decoder decodeObjectForKey:@"setPieceIcon"]];
    }
    return self;
}
*/
@end
