//
//  StartAppSDK.h
//  StartAppAdSDK
//
//  Created by StartApp on 3/13/14.
//  Copyright (c) 2014 StartApp. All rights reserved.
//  SDK version 2.4.2

#import <Foundation/Foundation.h>
#import "STAStartAppAd.h"
#import "STASplashPreferences.h"

// STAAdPreferences holds params specific to an ad
@interface STASDKPreferences : NSObject
@property (nonatomic,assign) NSUInteger age;
@property (nonatomic,strong) NSString* ageStr;

typedef enum {
	STAGender_Undefined = 0,
	STAGender_Female = 1,
    STAGender_Male=2
} STAGender;
@property (nonatomic, assign) STAGender gender;

+ (instancetype)prefrencesWithAge:(NSUInteger)age andGender:(STAGender)gender;
+ (instancetype)prefrencesWithAgeStr:(NSString *)ageStr andGender:(STAGender)gender;

@end



@interface STAStartAppSDK : NSObject

+ (STAStartAppSDK*) sharedInstance;
- (void) SDKInitialize:(NSString*)devID andAppID:(NSString*) appID;

@property (nonatomic, strong) NSString* appID;
@property (nonatomic, strong) NSString* devID;
@property (nonatomic, strong) STASDKPreferences* preferences;

// Disable Return Ad
- (void)disableReturnAd;

// Initialize Splash Ad
- (void)showSplashAd;
- (void)showSplashAdWithDelegate:(id<STADelegateProtocol>)delegate;
- (void)showSplashAdWithPreferences:(STASplashPreferences *)splashPreferences;
- (void)showSplashAdWithDelegate:(id<STADelegateProtocol>)delegate withPreferences:(STASplashPreferences *)splashPreferences;
- (void)showSplashAdWithDelegate:(id<STADelegateProtocol>)delegate withAdPreferences:(STAAdPreferences*) adPrefs withPreferences:(STASplashPreferences *)splashPreferences;
- (void)showSplashAdWithDelegate:(id<STADelegateProtocol>)delegate withAdPreferences:(STAAdPreferences*) adPrefs withPreferences:(STASplashPreferences *)splashPreferences withAdTag:(NSString*)adTag;

//Unity methods
- (void)unitySDKInitialize;
- (void)unityAppWillEnterForeground;
- (void)unityAppDidEnterBackground;


@property (readonly)  NSString* version;
@property (readonly)  long buildNumber;


@property (nonatomic)BOOL isUnityEnvironment;
@property (nonatomic)BOOL isCoronaEnvironment;
@property (nonatomic)BOOL isCocos2DXEnvironment;
@property (nonatomic)BOOL isAdMobMediationEnvironment;
@property (nonatomic)BOOL isMoPubMediationEnvironment;
@property (nonatomic)BOOL isSwiftEnvironment;


@end
