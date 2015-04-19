//
//  ViewGemetryEditView.m
//  iOSStudy
//
//  Created by leikun on 15-4-16.
//  Copyright (c) 2015年 leikun. All rights reserved.
//

#import "ViewGemetryEditView.h"

@interface ViewGemetryEditView()
{
    CGAffineTransform _traslateTransform;
    CGAffineTransform _scaleTransform;
    CGAffineTransform _rotateTransform;
}


@property(nonatomic)IBOutlet UITextField *frameField;
@property(nonatomic)IBOutlet UITextField *boundsField;
@property(nonatomic)IBOutlet UITextField *centerField;
@property(nonatomic)IBOutlet UITextField *anchorPointField;
@property(nonatomic)IBOutlet UITextField *translateField;
@property(nonatomic)IBOutlet UITextField *scaleField;
@property(nonatomic)IBOutlet UITextField *rotateField;

- (IBAction)textFieldDidEndOnExit:(UITextField *)textField;

@end

@implementation ViewGemetryEditView

- (void)awakeFromNib {
    _scaleTransform = CGAffineTransformIdentity;
    _traslateTransform = CGAffineTransformIdentity;
    _rotateTransform = CGAffineTransformIdentity;
}

- (IBAction)textFieldDidEndOnExit:(UITextField *)textField {
    if (textField.returnKeyType == UIReturnKeyDone) {
        if (textField == _frameField) {
            _showFrame = CGRectFromString(_frameField.text);
            _modifyType = ViewGemetryEditViewModifyFrame;
        } else if (textField == _boundsField) {
            _showBounds = CGRectFromString(_boundsField.text);
            _modifyType = ViewGemetryEditViewModifyBounds;
        } else if (textField == _centerField) {
            _showCenter = CGPointFromString(_centerField.text);
            _modifyType = ViewGemetryEditViewModifyCenter;
        } else if (textField == _anchorPointField) {
            _showLayerAnchorPoint = CGPointFromString(_anchorPointField.text);
            _modifyType = ViewGemetryEditViewModifyAnchorPoint;
        } else if (textField == _translateField) {
            CGPoint translate = CGPointFromString(_translateField.text);
            _traslateTransform = CGAffineTransformTranslate(CGAffineTransformIdentity, translate.x, translate.y);
            _modifyType = ViewGemetryEditViewModifyTransform;
        } else if (textField == _scaleField) {
            CGPoint scale = CGPointFromString(_scaleField.text);
            _scaleTransform = CGAffineTransformScale(CGAffineTransformIdentity, scale.x, scale.y);
            _modifyType = ViewGemetryEditViewModifyTransform;
        } else if (textField == _rotateField) {
            CGFloat rotate = [_rotateField.text floatValue];
            _rotateTransform = CGAffineTransformRotate(CGAffineTransformIdentity, (rotate * M_PI / 180));
            _modifyType = ViewGemetryEditViewModifyTransform;
        }
        if (_modifyType == ViewGemetryEditViewModifyTransform) {
            _showTransform = CGAffineTransformConcat(_scaleTransform, _traslateTransform);
            _showTransform = CGAffineTransformConcat(_showTransform, _rotateTransform);
        }
        [textField resignFirstResponder];
        if (_endEidtBlock) {
            _endEidtBlock(self);
        }
    }
}

- (void)setShowFrame:(CGRect)showFrame {
    _showFrame = showFrame;
    _frameField.text = NSStringFromCGRect(_showFrame);
}

- (void)setShowBounds:(CGRect)showBounds {
    _showBounds = showBounds;
    _boundsField.text = NSStringFromCGRect(_showBounds);
}

- (void)setShowCenter:(CGPoint)showCenter {
    _showCenter = showCenter;
    _centerField.text = NSStringFromCGPoint(_showCenter);
}

- (void)setShowLayerAnchorPoint:(CGPoint)showLayerAnchorPoint {
    _showLayerAnchorPoint = showLayerAnchorPoint;
    _anchorPointField.text = NSStringFromCGPoint(_showLayerAnchorPoint);
}

- (void)setShowTransform:(CGAffineTransform)showTransform {
    if (!CGAffineTransformEqualToTransform(_showTransform, showTransform)) {
        if (CGAffineTransformIsIdentity(showTransform)) {
            _showTransform = showTransform;
            _scaleTransform = CGAffineTransformIdentity;
            _traslateTransform = CGAffineTransformIdentity;
            _rotateTransform = CGAffineTransformIdentity;
            _scaleField.text = NSStringFromCGPoint(CGPointMake(1, 1));
            _translateField.text = NSStringFromCGPoint(CGPointZero);
            _rotateField.text = @"0";
        }
    }
}

@end
