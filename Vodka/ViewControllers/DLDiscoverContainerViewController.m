//
//  DLDiscoverContainerViewController.m
//  Vodka
//
//  Created by dinglin on 2017/4/28.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLDiscoverContainerViewController.h"
#import <Masonry/Masonry.h>
#import "DLDiscoverViewController.h"

typedef NS_ENUM(NSInteger, Option)
{
    inRoom = 0,
    outRoom = 1
};


@interface DLDiscoverContainerViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, assign) Option currentOption;

@property (nonatomic) UIPageViewController *pageViewController;
@property (nonatomic) UISegmentedControl *segmentedControl;

@property (nonatomic) DLBaseViewController *vc1;
@property (nonatomic) DLDiscoverViewController *vc2;


@end

@implementation DLDiscoverContainerViewController


-(instancetype)init {
    self = [super init];
    if (self) {
        DDLogInfo(@"DLDiscoverContainerViewController init");
        
        [self addObserver:self forKeyPath:@"currentOption" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];

    }
    
    return self;
}

-(void)dealloc {
    DDLogInfo(@"DLDiscoverContainerViewController dealloc");
    
    [self removeObserver:self forKeyPath:@"currentOption"];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    [self.navigationItem setTitleView:self.segmentedControl];
    
    [self.view addSubview:self.pageViewController.view];

    [self addChildViewController:self.pageViewController];

    self.currentOption = inRoom;
    self.segmentedControl.selectedSegmentIndex = inRoom;
    
    
}

-(UIPageViewController *)pageViewController {
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:@{UIPageViewControllerOptionSpineLocationKey:@0,UIPageViewControllerOptionInterPageSpacingKey:@10}];
        
        _pageViewController.dataSource = self;
        _pageViewController.delegate = self;
    }

    return _pageViewController;
}

-(UISegmentedControl *)segmentedControl {
    if (!_segmentedControl) {
        _segmentedControl = [[UISegmentedControl alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
        [_segmentedControl addTarget:self action:@selector(currentOptionValueChanged:) forControlEvents:UIControlEventValueChanged];

        [_segmentedControl insertSegmentWithTitle:@"inRoom" atIndex:0 animated:YES];
        [_segmentedControl insertSegmentWithTitle:@"outRoom" atIndex:1 animated:YES];
        
    }
    
    return _segmentedControl;
}

-(DLBaseViewController *)vc1 {
    if (!_vc1) {
        _vc1 = [[DLBaseViewController alloc] init];
    }
    
    return _vc1;
}

-(DLDiscoverViewController *)vc2 {
    if (!_vc2) {
        _vc2 = [[DLDiscoverViewController alloc] init];
    }
    
    return _vc2;
}

//kvo
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"currentOption"]){
        
        int currentOption = [[change valueForKey:@"new"] intValue];
        
        switch (currentOption) {
            case inRoom:
            {
                [self.pageViewController setViewControllers:@[self.vc1] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
            }
                break;
            case outRoom:
            {
                [self.pageViewController setViewControllers:@[self.vc2] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
            }
                break;
            default:
                break;
        }
        
        
        DDLogInfo(@"%d", currentOption);
    }

        

}

-(void)currentOptionValueChanged:(UISegmentedControl *)sender {

    NSInteger index = sender.selectedSegmentIndex;
    
    switch (index) {
        case 0:
        {
            self.currentOption = inRoom;
        }
            break;
        case 1:
        {
            self.currentOption = outRoom;
        }
            break;
        default:
            break;
    }


}

// MARK: - UIViewControllerPreviewingDelegate
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {

    if (viewController == self.vc2) {
        return self.vc1;
    }

    return nil;
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    if (viewController == self.vc1) {
        return self.vc2;
    }
    
    return nil;
}



// MARK: - UIPageViewControllerDelegate

-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {

    if (!completed) {
        return;
    }
    
    if (previousViewControllers.firstObject == self.vc1) {
        self.currentOption = outRoom;
    } else if (previousViewControllers.firstObject == self.vc2) {
        self.currentOption = inRoom;
    }

    self.segmentedControl.selectedSegmentIndex = self.currentOption;
}

// MARK: - UIViewControllerPreviewingDelegate


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
