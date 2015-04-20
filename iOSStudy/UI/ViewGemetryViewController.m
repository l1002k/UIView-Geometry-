//
//  ViewGemetryViewController.m
//  iOSStudy
//
//  Created by leikun on 15-4-16.
//  Copyright (c) 2015年 leikun. All rights reserved.
//

#import "ViewGemetryViewController.h"
#import "ViewGemetryEditView.h"

@interface ViewGemetryViewController()
{
    UIView *_blueView;
    UIView *_lightBlueView;
    ViewGemetryEditView *_editView;
    UIScrollView *_scrollView;
}

@end

@implementation ViewGemetryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubviews];
    [self initData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initSubviews {
    self.title = @"UIView Geometry";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 300)];
    contentView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    [_scrollView addSubview:contentView];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_scrollView];
    
    _editView = [[NSBundle mainBundle] loadNibNamed:@"ViewGemetryEditView" owner:self options:nil][0];
    _editView.frame = CGRectMake(0, 300, self.view.bounds.size.width, 400);
    [_scrollView addSubview:_editView];
    __weak typeof(self) weakSelf = self;
    _editView.endEidtBlock = ^(ViewGemetryEditView *edit){
        [weakSelf setTextViewData];
        [weakSelf setEditViewData];
    };
    
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 700);
    
    
    
    _blueView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    _blueView.center = CGPointMake(self.view.frame.size.width/2, 150);
    _blueView.backgroundColor = [UIColor blueColor];
    [contentView addSubview:_blueView];
    
    _lightBlueView = [[UIView alloc]initWithFrame:_blueView.frame];
    _lightBlueView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.5];
    [contentView insertSubview:_lightBlueView belowSubview:_blueView];
    
    UIView *_magentaView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    _magentaView.backgroundColor = [UIColor magentaColor];
    [_blueView addSubview:_magentaView];
    
    [self setEditViewData];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"reset" style:UIBarButtonItemStylePlain target:self action:@selector(resetTextView)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)setEditViewData {
    _editView.showFrame = _blueView.frame;
    _editView.showBounds = _blueView.bounds;
    _editView.showCenter = _blueView.center;
    _editView.showLayerAnchorPoint = _blueView.layer.anchorPoint;
    _editView.showTransform = _blueView.transform;
}

- (void)resetTextView {
    _blueView.transform = CGAffineTransformIdentity;
    _blueView.bounds = CGRectMake(0, 0, 100, 100);
    _blueView.center = CGPointMake(self.view.frame.size.width/2, 150);
    _blueView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    _lightBlueView.frame = _blueView.frame;
    [self setEditViewData];
}

- (void)setTextViewData {
    switch (_editView.modifyType) {
        case ViewGemetryEditViewModifyFrame:
            _blueView.frame = _editView.showFrame;
            break;
        case ViewGemetryEditViewModifyBounds:
            _blueView.bounds = _editView.showBounds;
            break;
        case ViewGemetryEditViewModifyCenter:
            _blueView.center = _editView.showCenter;
            break;
        case ViewGemetryEditViewModifyAnchorPoint:
            _blueView.layer.anchorPoint = _editView.showLayerAnchorPoint;
            break;
        case ViewGemetryEditViewModifyTransform:
            _blueView.transform = _editView.showTransform;
            break;
        default:
            break;
    }
    _lightBlueView.frame = _blueView.frame;
}

- (void)initData {
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    UIEdgeInsets edgeInsets =  _scrollView.contentInset;
    edgeInsets.bottom = keyboardRect.size.height;
    _scrollView.contentInset = edgeInsets;
}

- (void)keyboardWillChange:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    UIEdgeInsets edgeInsets =  _scrollView.contentInset;
    edgeInsets.bottom = keyboardRect.size.height;
    _scrollView.contentInset = edgeInsets;
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    UIEdgeInsets edgeInsets =  _scrollView.contentInset;
    edgeInsets.bottom = 0.f;
    _scrollView.contentInset = edgeInsets;
}

@end
