## Introduction

Sometime around the year 2016 Matthew Robins, a talented mobile developer, felt that Xamarin Studio, the main IDE for developing Xamarin apps on mac systems, was severely lacking productivty features for the mobile workflows. **MFractor**, a contraction of the _Mono Refactor_ name, has born to a few years later became one of the most powerful productivity toolbox for Xamarin and .NET developers.

On this post we'll get to know MFractor, what it is and how it can boost your productivity as a mobile developer for the Xamarin platform, by leveraging tools that you already used to with features carefuly thought for mobile developers.

## Powerful Tools For Xamarin.Forms Developers

Xamarin.Forms is a beloved by thousands of developers around the globe by its powerful cross-platform UI capabilities. Once being a tool for prototyping simple commercial apps, Forms has become a full-featured platform for mobile development. Powerful platforms demands powerful tooling, so we can extract the most with less effort.

This is the mindset that drove the features of MFractor for Xamarin.Forms developers. This tooling enhances your development experience by adding hundreds of Code Analysis and Code Actions for editing XAML files, shortcuts to navigate around your code, wizards for adding Fonts and Value Converters and tooltips and adornments to enhance your edit and Intellisense experience.

Let's take a look of some of these features!  

### Fix XAML Bugs Instantly

XAML is a powerful language for describing your UI. Yet, most its features are built on top XML and are "loosely" joint. This is the case of Resource Dictionaries, a feature that allow us to declare shared resources that are referenced by a string key. Sometimes though we may have typos that will only be found when the app crashes at runtime 🤯...

MFractor to the rescue! The static resource analysis will check every reference declaration to make sure it resolves to an item on the resource dictionary of that declaration scope. An error will be shown when MFractor identifies that a reference 

![](img/style-tooltip.png)

![](img/image-intellisense-tooltip.png)

XAML is a powerful language for describing your UI, with features like Styles, Behaviors, Triggers and Markup Expressions, that allows the magical Data-Binding stuff to happen. MFractor add several features to facilitate writing all this stuff, while running lots of diagnostics tools to identify potential issues your code.

Let's take Style references for instance. When applying a style to a element such as a Label, you may have typos that would only be catch at runtime (or even not catch at all!) 

while applying the MVVM pattern to separate design from behaviors. It comes packed with features such as Markup Extensions, that allow the loved Binding Expressions to exist, among several other interesting tools.



### Cleanup Your XAML

Designing your UI with XAML in one of the strongest(?!) features of Xamarin.Forms projects. Although being very powerful, XAML may become messy if we don't manage the dependencies. MFractor introduces several Code Analysis tools that helps you identifying how to simplify and cleanup your XAML code. 

Take for instance values that are declared repeteadly throughout the project, such as Thicknesses. With the thickness analysis MFractor constantly check all `Margin` and `Padding` property declarations to identify duplications. Green squiggles will be shown to indicate it, but the interesting part is hovering it, take a look at the tooltip:  

![](img/thickness-consolidation.png)

With just a click you can view all the usages of that thickness or consolidate all thickness declarations of the same value with a Static Resource, a nice and quick you to clean up your code!

### Ready for MVVM

The Model-View-ViewModel pattern is broadly used on Forms projects and MFractor make it really easy to work with it by adding handful features such as the MVVM Navigation, Wizard, Intellisense and several code actions.

When working with a View you can quickly switch between the XAML file, its code-behind and its View Model using keyboard shortcuts that can be easily be remembered:

![](img/mvvm-navigation.png)

MFractor uses common conventions to identify where each of these parts are. 

With the MVVM Wizard you can create a new View with its ViewModel while preview the output: 

![](img/mvvm-wizard.png)

But it's not just about the creation, but how you create them and in what places. The Wizards stands for lots of customization that allow you to adapt to any project convention.


## Image Management Simplified

Every modern and engaging app has several assets to compose its layouts. Adding images to projects is tedious and error prone. MFractor brings the Image Importer, a powerful tool that adds an image to all the required projects of your solution, giving it's correct names and resizing as required, freeing you from the complexity of dealing with densities and buckets.

![](img/image-importer.png)

Using the importer is as simple as browsing your image and clicking _Import Image_, most of the defaults will suffice for most projects. But importing is just the start! MFractor also 



![](img/image-asset-manager.png)

Mobile developers have to leave coding from time to time to import and manage the assets of its product, a required yet time consuming and error prone task.  

Developers love coding, but its inevitable to deal with images in a Mobile project. MFractor strives to made image management simple and straightforward, so you can focus on your coding while integrate designers work into your project effortless. 





## Choose Your IDE

MFractor is available as an extension of Visual Studio for Windows and Mac with almost all features available in both platforms, being one of the first cross-platform productivity extension for developers. By unleashing the full power of the Professional edition, you can use a single license for either environments. 

## Summary
