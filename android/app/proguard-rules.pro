# Flutter Core (keep from previous rules)
 -keep class io.flutter.app.** { *; }
 -keep class io.flutter.plugin.** { *; }
 -keep class io.flutter.util.** { *; }
 -keep class io.flutter.view.** { *; }
 -keep class io.flutter.** { *; }
 -keep class io.flutter.plugins.** { *; }

 # GetX (if using)
 -keep class io.get.** { *; }
 -dontwarn io.get.**

 # just_audio / ExoPlayer (for your audio fix)
 -keep class com.google.android.exoplayer2.** { *; }
 -dontwarn com.google.android.exoplayer2.**
 -keep class androidx.media3.** { *; }
 -dontwarn androidx.media3.**

 # Dio / HTTP
 -dontwarn okio.**
 -dontwarn org.codehaus.mojo.animal_sniffer.**

 # Google Play Core: Keep/Don't Warn Deprecated Classes (🔥 MAIN FIX)
 -dontwarn com.google.android.play.core.**
 -keep class com.google.android.play.core.** { *; }
 -dontwarn com.google.android.play.core.splitcompat.**
 -dontwarn com.google.android.play.core.splitinstall.**
 -dontwarn com.google.android.play.core.tasks.**

 # Specific Missing Classes from Your Log
 -dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
 -dontwarn com.google.android.play.core.splitinstall.SplitInstallException
 -dontwarn com.google.android.play.core.splitinstall.SplitInstallManager
 -dontwarn com.google.android.play.core.splitinstall.SplitInstallManagerFactory
 -dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest$Builder
 -dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest
 -dontwarn com.google.android.play.core.splitinstall.SplitInstallSessionState
 -dontwarn com.google.android.play.core.splitinstall.SplitInstallStateUpdatedListener
 -dontwarn com.google.android.play.core.tasks.OnFailureListener
 -dontwarn com.google.android.play.core.tasks.OnSuccessListener
 -dontwarn com.google.android.play.core.tasks.Task

 # Firebase (if using, from your plugins)
 -keep class com.google.firebase.** { *; }
 -dontwarn com.google.firebase.**

 # General: Native Methods & Enums
 -keepclasseswithmembernames class * { native <methods>; }
 -keepclassmembers enum * { public static **[] values(); public static ** valueOf(java.lang.String); }