//
//  NSObject+RouteMe.h
//  Pods
//
//  Created by xujian on 15/12/5.
//
//

#import <Foundation/Foundation.h>

typedef void (^RouteCompleteHandler)(UIViewController* targetObj);
typedef void (^RouteSelectHandler)(NSInteger selectIndex);
@interface RouteMe:NSObject{
    
}
@property(nonatomic,strong) NSDictionary  *routeMap;
@property(nonatomic,weak) UINavigationController  *navigationController;
@property (nonatomic,weak) UITabBarController *tabBarController;
+ (instancetype)sharedRouteMe;
- (void)loadConfig:(NSString*)filepath;
- (void)routeTo:(NSURL*)targetUrl;
- (void)routeTo:(NSURL *)targetUrl withPresenter:(UIViewController*)presenter;
- (void)routeTo:(NSURL*)targetUrl withParams:(NSString *)params completion:(RouteCompleteHandler)complete;
- (void)selectTabTo:(NSURL *)targetUrl withParams:(NSString *)params completion:(RouteSelectHandler)complete;
@end
