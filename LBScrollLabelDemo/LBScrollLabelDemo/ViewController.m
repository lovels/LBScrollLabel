//
//  ViewController.m
//  LBScrollLabelDemo
//
//  Created by luobbe on 15/9/26.
//  Copyright (c) 2015年 luobbe. All rights reserved.
//

#import "ViewController.h"
#import "LBScrollLabel.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *scrollLBArray = @[[NSNumber numberWithInteger:LBScrollLabelDirection_Top],
                               [NSNumber numberWithInteger:LBScrollLabelDirection_Bottom],
                               [NSNumber numberWithInteger:LBScrollLabelDirection_Left],
                               [NSNumber numberWithInteger:LBScrollLabelDirection_Right]
                               ];
    NSArray *scrollLBText = @[@"Scroll label, from bottom to top!",
                              @"Scroll label, from top to bottom!",
                              @"Hello, I am a scroll label, from right to left! I can become long longer longest      ",
                              @"Hello, I am a scroll label, from left to right! I can be long longer longest      ",
                              ];
    
    [scrollLBArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        //
        NSNumber *direction = (NSNumber *)obj;
        LBScrollLabel *topLB = [[LBScrollLabel alloc] initWithFrame:CGRectMake(20, 100 + 50 *idx, CGRectGetWidth(self.view.frame) - 40, 30)];
        topLB.backgroundColor = [UIColor colorWithRed:(arc4random()%255)/255.0 green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:1];
        topLB.text = [scrollLBText objectAtIndex:direction.integerValue];
        [topLB beginScrollWithDirection:direction.integerValue];
        [self.view addSubview:topLB];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
