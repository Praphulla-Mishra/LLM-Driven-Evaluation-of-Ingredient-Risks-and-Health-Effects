# Keep Google Play Core classes
-keep class com.google.android.play.** { *; }
-dontwarn com.google.android.play.**

# Keep ML Kit classes
-keep class com.google.mlkit.** { *; }
-dontwarn com.google.mlkit.**

# Keep Flutter deferred component manager classes
-keep class io.flutter.embedding.engine.deferredcomponents.** { *; }
-dontwarn io.flutter.embedding.engine.deferredcomponents.**
