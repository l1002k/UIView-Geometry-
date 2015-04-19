//
//  ViewGemetryEditView.h
//  iOSStudy
//
//  Created by leikun on 15-4-16.
//  Copyright (c) 2015年 leikun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    ViewGemetryEditViewModifyFrame,
    ViewGemetryEditViewModifyBounds,
    ViewGemetryEditViewModifyCenter,
    ViewGemetryEditViewModifyAnchorPoint,
    ViewGemetryEditViewModifyTransform
} ViewGemetryEditViewModifyType;

@interface ViewGemetryEditView : UIView

@property(nonatomic)CGRect showFrame;
@property(nonatomic)CGRect showBounds;
@property(nonatomic)CGPoint showCenter;
@property(nonatomic)CGPoint showLayerAnchorPoint;
@property(nonatomic)CGAffineTransform showTransform;

@property(nonatomic, readonly)ViewGemetryEditViewModifyType modifyType;

@property(nonatomic, copy)void(^endEidtBlock)(ViewGemetryEditView *editView);

@end
