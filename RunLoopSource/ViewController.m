//
//  ViewController.m
//  RunLoopSource
//
//  Created by etiantian on 2019/10/30.
//  Copyright © 2019 etiantian. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",[NSRunLoop currentRunLoop]);
    
//    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
//    [self.view addGestureRecognizer:tapGes];
    
    
    //[self performSelectorOnMainThread:@selector(handleSource0) withObject:nil waitUntilDone:YES];
}

- (void)tapAction {
    NSLog(@"tap action");
}

//- (IBAction)click:(UIButton *)sender {
//    NSLog(@"click button");
//}

- (void)handleSource0 {
    NSLog(@"performSelector:OnThread");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"执行任务A");
        [self performSelector:@selector(tapAction) withObject:nil afterDelay:1.0];
        NSLog(@"执行任务C");
        [[NSRunLoop currentRunLoop]addPort:[NSPort new] forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop]run];
    });
}


@end
