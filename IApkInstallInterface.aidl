package com.vivo.appstore.installserver;

import com.vivo.appstore.installserver.ApkInfo;
import com.vivo.appstore.installserver.IApkInstallStatusCallback;

/**
 * Apk安装的服务接口
 * Created by 10964564 on 2017/9/5.
 */

interface IApkInstallInterface {

    /**
    * 默认静默安装接口，同一时刻可能有多个渠道使用商店安装，或者同一渠道会多处调用安装apk，但是却想从回调中
    * 区分出当前状态是哪个apk的回调，可以通过source区分，会将此标志进行回调，商店仅仅将此应用发起的安装回调给
    * 对于应用，避免如A应用接收到B应用发起的安装回调
    * @param apkInfo 所要安装的apk信息
    * @param forced 如果手机已经安装了此应用，是否继续安装，如果为true，手机内为高版本时，则回调安装异常
    * @param source 冗余的字段，可以用于区分一个应用哪里发起的安装
    */
    void installApkWithSilent(in ApkInfo apkInfo, boolean forced, int source);

    /**
    * @param apkList 所要安装的apk列表，即批量安装方式
    * @param forced 如果手机已经安装了此应用，是否继续安装，如果为true，手机内为高版本时，则回调安装异常
    * @param source 冗余的字段，可以用于区分一个应用哪里发起的安装
    */
    void installApkListWithSilent(in List<ApkInfo> apkList, boolean forced, int source);

    /**
    * 商店可能没有静默安装权限，或者没有存储权限，所以对外提供权限检查接口
    */
    boolean checkPermission();

    /**
    * @param status 根据分发出去的状态判断是不是校验失败，即未真正的进入到安装
    */
    boolean isVerifyFailed(int status);

    /**
    * @param status 根据分发出去的状态判断是不是安装阶段出现失败
    */
    boolean isInstallFailed(int status);

    /**
    * @param errorCode 将错误码转换成字符串，可用于调试，线上最好关闭
    */
    String transformError(int errorCode);

    /**
    * 注册回调接口，分发安装中状态
    * @param callback 安装中状态的回调接口
    */
    void registerInstallStatusCallBack(in IApkInstallStatusCallback callback);

    /**
    * 解注册回调接口
    * @param callback 安装中状态的回调接口
    */
    void unregisterInstallStatusCallBack(in IApkInstallStatusCallback callback);
}
