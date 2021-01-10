## Introduction

Reverse engineering is the



Overview of reverse engineering

Why might someone reverse engineer software?

 * Gain insights into you


Personally, I've found reverse engineering to be valuable at multiple points in my career. Before attending job interviews, I typically reverse engineer their app to create discussion points for the interview. Early in the COVID19 pandemic, [I reverse engineered Australia's COVIDSafe application](https://twitter.com/matthewrdev/status/1254336105203200000?lang=en) to verify that it only uploaded anonymous data and through user consent

Therefore

## Understanding Application Bundles

## Reverse Engineering Xamarin.iOS Apps

* Downloading and unpacking an IPA. (See: https://medium.com/xcnotes/how-to-download-ipa-from-app-store-43e04b3d0332)
* Inspecting the contents of an IPA.


Take-aways:


## Reverse Engineering Xamarin.Android Apps

When an Android application is published to Google Play, it ships as an APK, an **A**ndroid **A**pplication **P**ackage. 

* Downloading an APK
* Unpacking an APK.
* Inspecting the contents of an APK.


* Inspecting the Java code. (Jadx)
* Inspecting the NET IL code. (Unpack)

Tools:

 * Inspecting the Java code. ()
 * Inspecting the .NET code. (dotPeek)

Take-aways:

 * Xamarin.Android apps are significantly easier than iOS apps to reverse engineer.
 * If you have both an Android and iOS application in the stores, and it uses a high-degree of shared code, someone can reverse your Android app and gain a pretty good idea of how the iOS app looks. The


## Securing Against Reverse Engineering

Now that we've covered the ways an application can be reverse engineered, lets talk about how to harden

Steps we can take to mitigate the threats posed by reverse engineering.

To harden our application package, we can:

  * Use AOT compilation on our Xamarin.Android builds to generate machine code and lessen the amount of IL code we ship.

  * Use an obfuscation tool to scramble the IL code in your assemblies. Tools such as Dotfuscator by Premptive obfuscate assemblies, making it significantly more difficult to decompile. Dotfuscator can apply techniques from scrambling the inner contents of methods/constructors/functions all the way to modifying

  * If AOT and/or obfuscation are not deemed strongsecure enough, then you should move business critical code out of the mobile app and onto the server. For example, say your business has a trade secret algorithm, then it is risky to ship the code in your mobile app. Given enough effort, people can reverse engineer the IL (even when obfuscated) and can also use tools like IDA Pro to reverse engineer the machine code.

  * Aim to embed as few API keys and security tokens as possible into our app. Where not possible to do so (such as analytics API keys), ensure these keys can be easily disable and regenerated.

  * Require that API calls use authenticated user accounts. This means that while endpoints may be published into your app bundle, people who reverse engineer the app require a user account to do anything meaningful with it.

Finally, any steps you take to harden your application are only as strong as your weakest link. For example, Xamarin.Android apps ship two forms of Intermediate Language (DEX and .NET IL) and are easily reversible, any hardening of your iOS app is in-vain if someone can decompile your Android app and

## Summary


Take aways
