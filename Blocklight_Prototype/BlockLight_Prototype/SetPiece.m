//
//  SetPiece.m
//  Prototype
//
//  Created by nang1 on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import "SetPiece.h"

@implementation SetPiece

@synthesize scaleRotationMatrix = _scaleRotationMatrix;
@synthesize icon = _icon;
@synthesize piecePosition = _piecePosition;

-(id) init{
    self = [super init];
    
    if(self == nil)
        return nil;
    
    _scaleRotationMatrix = CGAffineTransformIdentity;
    _piecePosition = [[Position alloc] init];
    
    return self;
}

-(id) initWithImage:(UIImage*)icon
{
    self = [super init];
    
    if(self == nil)
        return nil;
    
    _scaleRotationMatrix = CGAffineTransformIdentity;
    _piecePosition = [[Position alloc] init];
    _icon = icon;
    
    return self;
}

-(id)copyWithZone:(NSZone *)zone
{
	id copy = [[[self class]alloc]init];
	if (copy){
		[copy setPiecePosition:[self.piecePosition copyWithZone:zone]];
		[copy setIcon:[UIImage imageWithCGImage:self.icon.CGImage]];
	}
	return copy;
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
