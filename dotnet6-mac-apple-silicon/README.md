# .NET 6 for Mac with Apple Silicon Developers

Microsoft released .NET 6 with a great focus on the availability of its runtime and SDK compiled natively for the `arm64` architectures of Apple Silicon Macs. This is exciting news but, its just half of the history. When it comes to the developer side the native promisse is still lacking decent tooling support.

This post is an attempt to document how I've setup my environment on a MacBook Pro with an M1 processor, trying to circunvent all the pains of being such an early adopter. 🤕

## The Problem

>Visual Studio 2019 for Mac doesn't support .NET 6 on Apple Silicon Macs **at all**.

This doesn't affect existing workflows like working in previous versions of .NET (5 and Core 3.1), and you can still setup your environment to work with your existing projects, like explained [here](https://devblogs.microsoft.com/visualstudio/developing-on-a-m1-mac-with-visual-studio-for-mac/) and [here](https://montemagno.com/setting-up-an-m1-mac-for-xamarin-development/).

The `arm64` of the .NET 6 SDK can still be installed and used to compile new projects. The limitation here is around the **tooling support**. When you install the latest SDK you should get this banner message on your IDE:

![](img/unsupported-install.png)

Clicking on the button leads you to a [support page](https://docs.microsoft.com/en-ca/visualstudio/mac/uninstall-net-2019?view=vsmac-2019) with a cryptic message:

>On Apple Silicon machines (also known as M1 or ARM), Visual Studio for Mac 8.10 does not currently support the .NET 6, .NET 5 and .NET Core 3.1 x64 SDKs released in November. It also does not support the .NET 6 Arm64 SDK. If any of these are installed, then they will break Visual Studio for Mac 8.10, and should be uninstalled, and the older .NET SDKs installed.

This is misleading and very confusing. Worst yet, the proposed solution is to uninstall all the SDK's and just install the latest ones without .NET 6. As I made it clear at first, .NET 6 is not supported on Visual Studio 2019 at all, **even if you install the x86 version of it!** But that shouldn't inhibit us from using the SDK from the command line with Visual Studio Code or other supported IDE.

The thing is, there is a workaround this issue. You can still have Visual Studio working correctly with previous versions by setting up the SDK Locations like below:

![](img/sdk-location.png)

That should put you on a supported scenario where you can still work with your existing projects that you hasn't updated to .NET 6. The limitation is that you won't be able to work on those newer projects.

## Visual Studio 2022 for Mac Preview

While Visual Studio 2022 for Windows was released along-side with .NET 6 last November, its macOS counterpart is still in a very early Preview. Microsoft has decided to do a huge refactor to the IDE, which is very desirable, but at the cost of us not knowing when the tool will be ready.

Since the Preview 3 it added support to .NET 6, but you had to pick if you wanted it to work with the newer or the former versions, as picted in the release notes:

>On Apple Silicon (M1 or Arm64) machines, the .NET 5.0, 6.0 and .NET Core 3.1 x64 SDKs, released in November, are not supported by Visual Studio for Mac 17.0 Preview 3. This is because the new x64 .NET SDKs install into a different directory and Visual Studio for Mac currently only supports the original .NET SDK install location, which is now only used by the Arm64 SDK.
> * If .NET 5.0, 6.0 or .NET Core 3.1 x64 SDKs are installed, then these should be removed, and the .NET 6 Arm64 SDK installed instead.
> * Learn how to migrate to .NET 6 Arm64 SDK with these instructions.
> * Visual Studio for Mac 8.10.13 and earlier versions are not supported side by side with Visual Studio for Mac 17.0 Preview 3.

This is messy! There's not support on side-by-side installation of the previous versions, and you gotta pick which version of .NET SDK you want installed. 

As the time of this writing the latest Preview release was the 4th, from december 14th. There is no word on the Release Notes about this messy .NET support scenario, but as of my testing I've found that it either run side-by-side with 2019 version and I was able to fully compile and run a solution that mixed projects for different SDK versions (Core 3.1, 5 and 6).

Its important to note that **Visual Studio 2022 is still an early Preview, lacking several of the features and workloads from its former version and very buggy**. Its definately not an viable option as a primary development, but at least it shed some light on the tunnel about what we can expect for the future. But we don't have any expected time-frame for when the stable version will arise. 

It's never been easy to be an early adopter! 🤷‍♂️

## Using JetBrains Rider

JetBrains has been gaining momentum as a preferred IDE for .NET developers beyond the mess that Microsoft is marking with Visual Studio for Mac. Its most recent version is fully support on Apple Silicon Macs and is already using .NET 6 as its backend.

It is possible to use Rider for either former and the latest .NET releases. The tricky is to select the proper version of the CLI tool on the Preferences:

![](img/rider-sdk.png)

This can be set per solution, which means that you won't be able to mix current and former versions on the same solution, but with a bit of organization on your project structure it works pretty fine!

## What about MFractor?

MFractor runs on top the Visual Studio engine and is supported on Visual Studio 2019 for Mac. The current preview of Visual Studio 2022 is lacking extension support, so we are unable to provide an updated version that can support you on .NET 6 projects. We'll be working on an update as soon as Microsoft adds extensions back to the product. In regards to Rider, there are no plans for supporting it at this time, so if you stick with Visual Studio 2019 for Mac for now you should be good to go.

## Summary

The release of .NET 6 represents an important milestone for developers who prefer macOS as the first to support a native runtime and SDK for the Apple Silicon processors. Yet, there are issues and flaws related to the tooling that should be addressed overtime. We're just in the middle of the expected 2 year transition to the new architecture and a lot has evolved. The thing is, there's no turn back when it comes to processor architecture on Apple systems, but early adopters always pay the price.

I hope that this post may shed some light on developers who have gone all-in like me to the new system, and needs to setup its environment properly. Please share your comments if you find anything that I've might have missed.

May we all have a great 2022! 🎄🎊🍾🎉🎁