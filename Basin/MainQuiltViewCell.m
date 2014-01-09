//
//  MainQuiltViewCell.m
//  Basin
//
//  Created by Lucien Constable on 12/13/12.
//
//

// Credit to TMQuiltView


#import "MainQuiltViewCell.h"

const CGFloat kTMPhotoQuiltViewMargin = 1;

@implementation MainQuiltViewCell

@synthesize photoView = _photoView;
@synthesize titleLabel = _titleLabel;

/*
- (void)dealloc {
    [_photoView release], _photoView = nil;
    [_titleLabel release], _titleLabel = nil;
    
    [super dealloc];
}
*/

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (UIImageView *)photoView {
    if (!_photoView) {
        _photoView = [[UIImageView alloc] init];
        _photoView.contentMode = UIViewContentModeScaleAspectFill;
        _photoView.clipsToBounds = YES;
        [self addSubview:_photoView];
    }
    return _photoView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = UITextAlignmentLeft;
        _titleLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:12];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (void)layoutSubviews {
    
// corresponds to cellAtIndexPath in MainQuiltViewController.m
    CGRect photoRect = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height - 60);
    
    self.photoView.frame = CGRectInset(photoRect, kTMPhotoQuiltViewMargin, kTMPhotoQuiltViewMargin);

    self.titleLabel.frame = CGRectMake(kTMPhotoQuiltViewMargin, self.bounds.size.height - 60 - kTMPhotoQuiltViewMargin, self.bounds.size.width - 2 * kTMPhotoQuiltViewMargin, 60);
//    self.titleLabel.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    
    UIView *imageBottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
    imageBottomLine.backgroundColor = [UIColor lightGrayColor];
    
    [self.titleLabel addSubview:imageBottomLine];
}

@end