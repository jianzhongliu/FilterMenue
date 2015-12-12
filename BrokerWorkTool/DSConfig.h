//
//  DSConfig.h
//  DistributionProject
//
//  Created by liujianzhong on 15/7/13.
//  Copyright © 2015年 T.E.N_. All rights reserved.
//

#ifndef DSConfig_h
#define DSConfig_h

#define APPNAME @"i-store"
#define DPSIGNATURE @"psmtoiyrpyqofhfo8atdofdby4eqc02p"

#define DEBUG_51

#ifdef DEBUG_51
#define DPHOST @"http://120.132.50.73:6080/officeapi/v1"
//#define DPHOST @"http://api.51diansong.com/api"
//#define DPHOST @"http://192.168.0.90/api/v1"
#define UmengKey @"5593a55567e58e1caf000d6b"

#else

#define NSLog(...) {}
#define DPHOST @"http://api.51diansong.com/api"
#define UmengKey @"5593a51967e58eb418001e4d"

#endif

//121.40.87.85	51diansong.com  api.51diansong.com staff.51diansong.com store.51diansong.com
//#ifdef DEBUG_51
//
//
//#else
//
////#define DPHOST @"http://api.51diansong.com/api/v1"
//#define DPHOST @"http://121.40.87.85/api/v1"
//#endif

/**屏幕尺寸*/
#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height
/**封装颜色*/
#define DSColorMake(r, g, b)            [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define DSColorAlphaMake(r, g, b, a)    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define DSColorFromHex(rgb)     [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0 green:((float)((rgb & 0xFF00) >> 8))/255.0 blue:((float)(rgb & 0xFF))/255.0 alpha:1.0]
/**设置主题色*/
#define DSColor DSColorFromHex(0x189abc) //蓝色风格主题色调00ad88
#define DSNavi DSColorFromHex(0x060616) //navigation的颜色
#define DSRedColor DSColorFromHex(0xe36062)//红色风格主题色调
#define DSGrayColor DSColorFromHex(0x99999c)//灰色字体

#define DSBackColor DSColorFromHex(0xf5f5f5)//背景浅灰
#define DSLineSepratorColor DSColorFromHex(0xf4f4f4)//分割线颜色

#define DSBlackColor DSColorFromHex(0x333333)//浅黑色
/**判断系统版本*/
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#endif /* DSConfig_h */
