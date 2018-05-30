package com.acgpic.sixbit;

import android.app.DownloadManager;
import android.content.Context;
import android.net.Uri;
import android.os.Bundle;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;

import android.os.Environment;

import java.io.File;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "samples.flutter.io/downloadimage";

  @Override
  protected void onCreate(Bundle savedInstanceState) {

    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(new MethodCallHandler() {
      @Override
      public void onMethodCall(MethodCall call, Result result) {
        
        String url = call.arguments();

        if (call.method.equals("downloadImage")) {
       
         downloadImage(url);
  
        }

      }
    });

  }

   private void downloadImage(String url) {

     DownloadManager.Request request ;
   
     request = new DownloadManager.Request(Uri.parse(url));

    /* allow mobile and WiFi downloads */

     request.setAllowedNetworkTypes(DownloadManager.Request.NETWORK_MOBILE | DownloadManager.Request.NETWORK_WIFI);

    /* we let the user see the download in a notification */

    /*
     * Try to determine the file extension from the url. Only allow image types. You
     * can skip this check if you only plan to handle the downloaded file manually
     * and don't care about file managers not recognizing the file as a known type
     */

     String suffix = url.substring(url.lastIndexOf(".") + 1).toLowerCase();

    /* set the destination path for this download */
     request.setDestinationInExternalPublicDir(Environment.DIRECTORY_DOWNLOADS + File.separator + "acg_image",
         System.currentTimeMillis() + "." + suffix);
    /* allow the MediaScanner to scan the downloaded file */
     request.allowScanningByMediaScanner();
     final DownloadManager dm = (DownloadManager) getSystemService(Context.DOWNLOAD_SERVICE);
    /* this is our unique download id */

     final long DL_ID = dm.enqueue(request);

    /* get notified when the download is complete */
   }

}
