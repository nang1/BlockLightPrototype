//
//  SetPiece.m
//  Prototype
//
//  A model that holds information about a set piece.
// 
//  Created by Nicole Ang on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import "SetPiece.h"

@implementation SetPiece

@synthesize scaleRotationMatrix = _scaleRotationMatrix;
@synthesize icon = _icon;
@synthesize piecePosition = _piecePosition;

/*************************************************************
 * @function: init
 * @discussion: initializes a Set Piece object
 * @return: id to model instance
 ************************************************************/
-(id) init{
    self = [super init];
    
    if(self == nil)
        return nil;
    
    _scaleRotationMatrix = CGAffineTransformIdentity;
    _piecePosition = [[Position alloc] init];
    
    return self;
}

/*************************************************************
 * @function: initWithImage
 * @discussion: initializes a SetPiece object with a specific image
 * @param: UIImage* icon - image of the set piece
 * @return: id to model instance
 ************************************************************/
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

/*************************************************************
 * @function: copyWithZone
 * @discussion: creates a copy of this model instance
 * @param: NSZone* zone
 * @return: id to new model instance copy
 ************************************************************/
-(id)copyWithZone:(NSZone *)zone
{
	id copy = [[[self class]alloc]init];
	if (copy){
		[copy setPiecePosition:[self.piecePosition copyWithZone:zone]];
		[copy setIcon:[UIImage imageWithCGImage:self.icon.CGImage]];
        [copy setScaleRotationMatrix:_scaleRotationMatrix];
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
