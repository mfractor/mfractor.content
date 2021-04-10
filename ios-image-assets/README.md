
## Introduction

When developing apps you'll come to the point where you'll need to deal with image assets. No matter how crudiest the UI could be, you'll probably need some icons or small image resources to compose your layouts. In this post we'll explore how image assets works on iOS.

## The Problem

You might ask, why do I need to care about image assets? Aren't they just plain images that I render on my layout? It used to be that simple, but not anymore. But what are the problem with they so? Well, a little history will make things clear.

When Apple launched iPhone in 2007 they set the landscape for the "glass" smartphones where we are today. A screen of 3,5` with 320x480 resolution was a big deal. Smartphone displays of that era was crappy ugly and pixelated. The iPhone display by contrast was very sharp and beautiful. For developers the fixed resolution made it very easy to design for iPhone in that very early years, and everyone was happy.

But enough is never enough, so circa 2010 we've got iPhone 4 and its **retina display**, that doubled the resolution keeping the same screen size. The idea was that with such high res you couldn't notice the spacing between pixels and rounded edges would be naturally smooth.

![](img/retina.jpg)

That bump on the screen quality was very noticeable. But it comes with its own issues to developers. To take advantage of such high resolution our apps needed to provide images that doubled its own density or they would look so small on the screen that would be impossible to interact with. Software upscaling was possible, but wouldn't produce that sharp edges that users were looking for.

>BTW, Apple being Apple started sometime to force apps to be compatible with the retina display, otherwise they would be rejected on the review. There was no escape for developers!

This is when image asset management hell was the born on iOS projects! For now own we needed to provide variations of the same image to match with the screen resolutions. Then came iPhone 6 Plus, that trippled the resolution, iPads, Retina Display Macs and, well, you got the idea...

Of course that tools were created to help with this new problem. They're what this post is about! 😎

## Types of Image Files

Have you ever asked yourself how computers represent images? Alghouth this may be some basic knowledge to most developers, it's a good theme to revisit. When it comes to modern computer graphics there are two main ways of representing the images: **bitmaps** and **vectors**.

Bitmaps are just a matrix of rows and columns where each intersection is painted with a color. Bitmaps are best for representing pictures and highly detailed images, but it has a fixed width and height, and despite we actually have very good algorithms for shrinking or enlarging bitmaps, there's always some lose.

![](img/smile-bitmap.png)

I found the little smiley above very representative of what a bitmap is. Of course its just a black and white image. But turning the bits into bytes let us represent a wide palete of colors for each pixel.

Now we come to the vectors, which are more cool to programmers! They're are a mathematical representation of the shapes that forms an image. This means that they can be easily scaled which make them very desirable for the responsive designs that we strive to produce in web and mobile apps.

To better understand vector images lets dirty our hands of code. There's an app called [PaintCode](https://www.paintcodeapp.com), that is a drawing app like Sketch or Illustrator where you can make your designs. What makes it different is that instead of saving it to a file, PaintCode generates the code necessary to draw your image on screen with [`UIKit`]().

Take a look at this screenshot from the tutorial:

![](img/paintcode.png)

Notice that we have a canvas and below it a code section. 

The code itself is not important, but to understand that it represents a series of instructions on **how** the image should be draw on the screen. You can easily change the frame parameter of the `drawBubbleButton` function to any size and the shape will be draw preserving its sharp quality. This is the power of vectors!

There's a lot of debate around which type is better, and, as always when it comes to software engineering, the answer is: it depends! Each representation has its pros and cons and you should evaluate your usage scenario and requirements to take a better pick.

Generally speaking you can use both representations for any kind of image but bitmaps are usually better for photography or highly detailed images where vectors deals better with shapes and abstract drawings. Also, don't forget to consult with a designer, they usually now what's best! 🧑‍🎨
 
### Representation vs. Storage

The discussion about bitmaps vs. vectors is all about how to digitally represent an image, but when it comes to storing that images it's a completely different story. Either bitmaps and vectors can be stored in several different file formats. This is because the way we represent this image as a data structure is not necessarly the best way to store it.

For instance, if we would save a bitmap to a file without any compression we would need to store the color of each pixel which is very wasteful. Formats like PNG or JPEG rely on things like repeated patterns and noise to reduce the space needed to store that bitmap.

The same thing happens for vector images. One of the most common ways of storing then in SVG files, which are very convenient because they're just a plain XML file. Here's the content of a simple SVG for an information icon:

```xml
<svg xmlns="http://www.w3.org/2000/svg" 
    viewBox="0 0 24 24" 
    fill="black" 
    width="18px" 
    height="18px">
    <path 
        d="M0 0h24v24H0z" 
        fill="none"/>
    <path 
        d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-6h2v6zm0-8h-2V7h2v2z"/>
</svg>
```

Notice that you can easily modify this file to change it's "viewbox" (the size of the canvas), the width and height or the fill color. More adventurous people may want to mess with the path coordinates, but I think its better to have some image editor for that.

>**Tip**: Gaplin is very useful free tool for macOS to with SVG files. It has a decent previewer and an exporter to save as PNG or other common image formats.

There are several file formats for storing vector images, such as EPS (Extensible PostScript), AI (from Adobe Illustrator) or PDF. Although vectorial images are usually associated with shapes, each of those formats allows you to describe more complex types of elements such as texts and even embbed bitmaps inside a document.

Vectorial images have a very rich and interesting history that dates back to the PostScript language, the most popular effort to create a standard for describing documents for printing! This has evolved until our modern standards that allows us to store rich image assets in a very optimized way.

>Understanding those differences about image types and their storage is key for organizing the image assets of your project. Also this will allow you to communicate better with the design team. 

## Understanding Screen Densities

Now that we know or problem space let's understand the screen densities, but first let's recall some concepts:

* **Screen Size**: referes to the physical size of of a screen that's normalized measured by its diagonal inches. The screen size by itself normally don't specify its aspect ratio.
* **Resolution**: refers to how many **pixels** we have on a given screen. They are defined by how many pixels we have on the horizontal axis (the width) by the quantity of pixels on the vertical axis (the height), which forms a matrix. The amount of pixels on a given screen is the product of this two numbers. A few examples:
    * The original iPhone had a 240x320 screen resolution, with a total of 76800 pixels
    * iPhone 4 had a 480x640 screen solution with a whoping 307200 pixels!
* **Density**: the density of a screen is the relation between its size and resolution. Its normally measured by `ppi`, or **pixels per inch**, that is the quantity of dots or pixels that fits into an inch of that screen. The higher the density the better the quality of the image because with more pixels the image can more detailed.

So in the example above either the original iPhone and the iPhone 4 had an 3,5' inch display. While the original has a 165 ppi, iPhone 4 had an stunning 326 ppi!

But what does this means in practice? A picture still worth a thousand words...

![](img/retina-vs-non-retina.jpg)

The image above was taken from the article ["Real retina vs. non-retina photos"](https://artauthority.net/real-retina-vs-non-retina-photos/). On the left we have an image presented on a non-retina display. We can see that there's a lot of spacing around each of the dots that compromises the image quality.

On the right we have the same picture presented on a retina display. This is a screen that has the same physical size of the left one but the resolution is doubled. We can see that the spacing aruond each pixel is much smaller, producing a higher quality image with much more details. The rounded edges are a lot smoother as an example.

The picture above is a close-up. We normally don't use a screen to close to our eyes to see it in that detail. So in effect when using a retina display you won't be able to notice the spacing around pixels.

>If you're curious about all the iPhones screen size, resolution and PPI [there's an excelent reference on this site](https://iosref.com/res).

### What About Developers?

Historically developers of graphical interfaces always thought of developing UI's based on the screen resolution alone, and this was also true for the first generation of iPhones. We had a single device and it had a single display size and resolution and would draw our elements based on that available space, by doing simple calculations and rendering on absolute coordinates.

The introduction of retina displays doubled the resolution but keep the same screen size. This would have two immediate effects:

* Breaking all the existing programs that relied on the fixed screen size. In the worst case scenario they would take a quarter of the screen;
* All the UI elements would be he a quarter of its size making then unberable to read or interact with touch.

Its important to remember that increasing the screen resolution is all about **image quality** and not giving more space. The iPhone 4 display had the same physical size but doubled the resolution so where we had 1 pixel now we had 4 pixels in the same space. But wait, what?! You told me that it's the double of the resolution, how do we have 4 pixels to 1 ratio? I'll try to picture that for you:


When we put the 2 screens side-by-side its very easy to picture! (no pun intended). Since we doubled the resolution on each axis we actually have 4 times many pixels than the previous generation. Another way of seeing it is that we can fit 4 screens of the original iPhone on just one screen of the retina display.

When running our app on a retina display we want to keep the UI elements with the same **physical** size and its just a matter of doubling the size of the elements themselves. But we don't want to manage different sizes for different devices. This seems the kind of problem that can be solved by software, and this is exactly what the `point` measure does.

Starting on iOS 4, Apple updated the whole `UIKit` library to start using the `Point` measure instead of pixels. This abstracts away our concerns about the **density** of the screen. From the developer point of view, he was still working with a canvas of 240x320 **points**. It is now up to UIKit to decide the **actual** size of an element depending on the device that the rendering is done. 

Ok, so this is quite a lot to grasp! 😓 And I myself took a long time to make a sense of all of this. But now we can advance to talk about images at least...


The Apple HIG (Human Interface Guidelines) recommended that buttons should have at least 44 pixels in height. 





 they decided to abstract away the **density** aspect by introducing `Point` measure, a "virtual" measure unit for development.





The introduction of retina displays would move us away from our confort zone, but high density screens on a phone wasn't about the space but the quality.



Also, an app would always fills that entire screen space, in contrast with computer UI's where the user can resize your app window.

This made developing UI's for iPhone apps very easy and convenient because we were aware of all the space we have available all the time.

By that time it was common to develop user interfaces using absolute coordinates so designers though on screens based on the available space in pixels, and developers just draw the elements following those guides.



Drawing on screen was just like drawing on a canvas, we know upfront available space and draw 


>Modern UI development doesn't rely on absolute coordinates because of the plethora of screen sizes that an interface should adapt. There are smart tools for handling this, like Auto Layout and Reactive UI's, where we think of an layout based on contraints rather the space available.



Now, let's think for a moment. 

If you have a screen with double the resolution on such a small device you don't want your buttons to have half of this side, because they would be hard to read and to interact with.

The **physical size** of the elements should be preserved. 

So Apple made it very for developers by introducing the `point` measure. 



Points are a "virtual measure" that abstracts away from the developer the density concern. 


while resolution is a measure of their own, the density of a screen is a ratio between the resolution and the **physical size** of an screen. 


 Screen Densities - The Apple Take

Ok, so now that we understand about image types and how they're represented, how does it fits to the problem that we've proposed at first? When Apple first brought the Retina Displays, they've carefully thought about it in a way that would have the lesser impact on the developer side. So a new measure unit was introduced for developing with UIKit, the `point`. To be more exact, the pixel unit was entirely replaced throught the UIKit SDK anywhere sizing is applied.

We can think of `point`s as a "virtual" measurement unit, the idea is for us to design our layouts over a base size, allowing the system to automatically scale the rendering of elements when the canvas size changes. In practice


## Understanding iOS Image Assets

The iOS SDK supports, out of the box, several types of image formats and has built-in API's to handle loading and rendering of those assets. On this post we will keep our focus on the UIKit framework. There are other low-level API's to directly manipulating image files or working with different formats and other kind of tools for frameworks like SpriteKit for high-performance graphics.

On the previous section we've presented why image management became a subject of app development with the introduction of Retina Displays. With this we had to deliver different versions of the same image. But the density is not the only varation that we must take into account for modern apps. Let's break down all the variations that an image asset can have:

* The screen density
* Variations for specific devices (Apple Watch, iPad, Apple TV, carOS, etc)
* Direction (Left-to-Right or Right-to-Left depending on the language)
* Width and Height classes (for use with [Size Classes](https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/TheAdaptiveModel.html))
* Light and Dark theme variants
* Localized images

Those are some, but not all the possible variations that you can have for image assets, but the others are so specific that it's not worth mentioning, and to be fair, I personally never got beyond density, theme and localized images. The important thing about variants is that the iOS SDK has some clever API's that automatically select a variation for a specific context.

Now that we have basic understanding about the variations that an image can have, let's explore how they can be organized and used inside our iOS projects.

### Bundle Resource Images

This is basicaly plain image files. We call it "Bundle Resources" because they are copied to the application bundle. Adding this kind of image is much like adding any regular file to your project. For Xcode projects just drop your image into a group and ensure that its add to your target.

_Add image to represent adding the image to a project_




Bundle Resource Images exists since the first version of iOS (dubbed iPhoneOS at the time). They're basically image files in any of the supported formats that are copied directly to the application bundle (hence its name).

We can think of Bundle Resources as plain image files, but it doesn't mean that the UIKit hasn't some tricks to deal with this kind of resources. Remember all the discussion about the retina display and image density? When adding images to our app we need to account for the screen density of the supported devices and each image ideally will have 2 or more versions of iteself in different densitites.


Having to this version selection programatically would be very labourous and error prone, so let's delegate this to the UIKit. Enter file name suffixes!

#### File name suffixes

The UIKit engineers found that the best way of solving this versioning issue is to use conventions, so to have the correct version of images being loaded automatically its just a matter of naming then correctly. At first, Apple added the `@2x` and `@3x` suffixes that would identify images that are double and triple density versions. Overtime several others suffixes were added for different flavours of iPads and macOS support. They were all dropped in favor of Asset Catalogs so I won't get in details. But the former `@2x` and `@3x` are still in use nowadays, mostly when exchaging images between designers and developers.

The usage is pretty simple, let's take an example of a login screen where we want to put our application logo on the top part of the layout. For instance I will take MFractor logo. The layout is as follows:

![](img/login-layout.png)

Its far from being a design masterpiece but enough for our purpose. The Logo image at the top is a 250x297 **points** in size. As we've told before, points is a base measure that is automatically scaled upon the actual screen density. So for this image to be rendered in the most optmized way through all devices we should provide 3 versions of this same image with 3 different sizes:

* **250x297** -  this is the basic image size and suits iPhones prior to 4 and iPads prior to 2.
* **500x594** (`@2x`) - this suits the first generation of retina displays that came with iPhone 4 and above and most of the iPads
* **750x891** (`@3x`) - this fits most of the modern iPhones and was introduced with iPhone 6 Plus that had a very high density screen

>**Important**: Notice that the scale factor 1 refers to devices that are retired for almost a decade by now so in practice we don't use it anymore.

Using densities suffixes makes it a lot easier to organize and handle our files. For this specific scenario I've created the following files that has the sizes described earlier:

* `mfractor_logo.png`
* `mfractor_logo@2x.png`
* `mfractor_logo@3x.png`

Having the images named like that on your project is sufficient for UIKit to make the call on which image to load and render on the screen. It keeps track of the density of the device where your code is running and automatically select the preferred image.

### Asset Catalogs

The Asset Catalogs was introduced some time later to aid on organizing and browsing through those image assets. Catalogs are pretty much folders where files are organized in a specific way with some additional metadata and Xcode provides a special UI for managing the assets of that catalog that looks like the following:

![](img/asset-catalog-xcode.png)

There's a lot to learn from the screenshot above, let's check it out:

1. This navigation area lists all the assets on this catalog.
2. When an asset is selected we can edit its components on the main editor.
3. The Attribute Inspector allows us to edit all the characteristics of this particular asset.

In this example the selected asset is our logo image, identified as an **Image Set**. This distinction is important because catalogs supports several other types of assets as we can check on the Add menu:

![](img/asset-catalog-new.png)

Here we can see that catalogs is not just about images, but other kinds of assets like Colors and even Data Sets that are pretty much any kind of data file that you may wish to have organized on a catalog. But all those other types of items in the catalog is subject of another post, lets focus on the Image Sets.

Its important to note that an Image Set represents a **single image**, and in code we only reference it by the name of the set itself. Generally you don't ask for a specific image of the set, this is decided automatically based on the attributes and on the images available, so if you've setup your catalogs correctly you can expect it to work it _automagically_!

In the previous sections we've examined the density aspect of an image, but over time another kinds of variations has emerged and the Asset Catalog proven to be very useful to support those new capacities. Probably the most useful of them is the Dark and Light themes support. If you check on the Attributes Inspector (item 3 above) you can see a option for _Appearance_. The following options are available:

![](img/asset-catalog-theme.png)

Since iOS 13 users can choose between light and dark themes as an environment setting. Our apps are expected to respond to those changes and adapt the interface to include a dark appearance. Supporting dark themes greatly enhances your user experience because it allows users to adapt their usage to their lighting conditions. Dark themes are very confortable to use on low light environments.

For the developers this means that they must include versions a dark variant of most images to adapt or correctly contrast with the darker colors. Asset Catalogs makes this very convenient by allowing you to specify dark versions of the same image. On the _Appearance_ attribute select the `Any, Dark` option and a new row of boxes will appear for us to fill:

![](img/asset-catalog-theme-set.png)

Notice the added row of Dark Appearance images. They're equivalent to the top ones but they will be selected by UIKit once the user changes to Dark Theme system wide. Better than that, **all the images will be automatically reloaded to match the new theme**. This is the power that Asset Catalogs brings to us. But wait, there's more!

#### App Thining

Having multiple versions of the same image on a project introduced a new problem. The size of your app incresed substancially because it needed to support those multiple devices, but having a image that is never going to be used is a waste of storage and network time.

App Thining was introduced as a set of features designed to reduce your app size. It creates several variants of your App Package optimized for specific devices and delievers those 

When it comes to image assets _App Slicing_ is the one that has more interest to us. There's also _On Demand Resources_, which allows you to create sets of images that can be downloaded on demand, but I will skip talking about it for this article. 🙂

>The third feature of App Thining is **Bitcode**, which allows your app to be recompiled by Apple on the server to generated optimized versions of it. This is a interesting feature but is out of the scope of the subject of this article. Take a look at the docs for more information.






Having multiple versions of the same image on a project started to make the packages grow a lot. This added unnecessary weight to the download of an app fills the device storage quicker. Most of those images would never be used on a specific device so its a useless weight.

App Thining was introduced with iOS 9 to try to mitigate this issue. This is an umbrella term for a set of features that help to manage and distribute image assets in a more clever way. Basically App Store will download only the relevant assets for your specific devices. This means for example that if you're using an iPhone SE (3rd generation) which has a @2x density screen, a variant of your app containing only this version of the image will be downloaded to the user.



With this feature Apple would create several variants of your app on the App Store side containing only the images necessary to a specific device type. For example, an variant of your app 

#### PDF Image Assets

Apple introduced PDF Image Assets with Xcode 6 as an option to use vector images. The idea is that you can replace all the density versions with a single file. To use this, on the Asset Catalog select the image set that you want to use a PDF file and on the Attribute Inspector change the `Scales` property to `Single Scale`:

![](img/pdf-assets-config.png)

Notice that changing this the tool will only accept a single image input for each device that you may select:

![](img/pdf-assets-input.png)

Although this greatly simplifies file management, using PDF assets may be misleading. When introduced it was more of a Xcode tool than an UIKit feature. It works at compiled time by transforming the PDF into PNG versions of each supported scale (much like MFractor does with a base image and the Image Importer 🙂), which is not a bad thing but has it issues.

The thing is that PDF may mix Vectorial and Bitmap parts which leads to odd results when resizing. There issues with masks and gradients that should be observed too. There's a very interesting article named [Why I don't use PDF's for iOS assets](https://bjango.com/articles/idontusepdfs/) that is a must read if you're considering using PDF's.

Later on Apple added the `Preserve Vector Data` option to the Image Set with Xcode 9. With this option checked the actual PDF is bundled into the application package and this scaling is done at runtime. This allows us to benefit on vector for upscaling an image for example (by override its intrinsic size), but suffers from the same issues presented above.

Despite of those drawbacks PDF assets are an useful tool on your toolchain, so doesn't just drop it. Keep in mind the stuff above and it should be helpful.

#### Vector (SVG) Image assets

Well, this is the fancy name for SVG support. We have already talked about it on our discussions of image representations. SVG's are largely used on the industry. Browsers supports it natively (you can even embbed it into HTML) and Android has been using it for so long, so I don't understand why it took so long to have a native support within Apple platforms.

To use SVG's on your Asset Catalog is pretty much the same setup for PDF by selecting `Single Scale` for the `Scales` option, but instead you drag an SVG to the Image Set:

![](img/svg-assets.png)

Here we've added 2 new image sets for an email and password icons that we've got from the Material site (!!todo get links). We've just set it as Single Scale and dropped the SVG files on the catalog. This is pretty much what you need to do to use SVG's in your code.

SVG's are a very welcome addition to iOS but unfortunately its only available from iOS 13 and above (and only when using Xcode 12), which means that you may wish to stick with PDF's or plain images for some time if you need to support versions prior to that.

### SF Symbols

Apple introduced [**SF Symbols**](https://developer.apple.com/sf-symbols/) with iOS 13 as a set of built-in high quality icons on top of the San Francisco Font. Using SF Symbols to provide icons for your apps has several advantages:

* Symbols are high quality vector graphics that can scale to multiple sizes
* They are built into the operating system and doesn't add any overhead
* They don't need any extra setup, just reference the symbol by name and use it on your screen
* They are the same glyphs used throughout the operating system itself so using them provide a consistent experience to the user
* It's a very convenient for stand-alone developers that doesn't have much design resources

There are more than 2400 symbols to choose and they've also introduced some multicolor ones. You can download the ]SF Symbols App](https://developer.apple.com/sf-symbols/) to browse through the entire catalog and get the symbol names (that is what you use to load them on your code). It allows you to create custom collections for the icons that you use on your apps.

![](img/sf-symbols.png)

There's nothing much we can say against SF Symbols, except that its only available from iOS 13 and that new symbols are being added as each new major release is made. You may also want to avoid it if you need to create a consitent identity across platforms, since its not available to Android or other OS'ses.

## Using Image Assets in code

The iOS SDK makes it very easy and convenient for us developers to use our image assets in our code. Most of the time it is just a matter of referencing the asset from its name, so having good standards for naming your assets is a good help.

Loading images is mostly done through the [`UIImage`](https://developer.apple.com/documentation/uikit/uiimage/) class. It has several initializers that allows loading images in different ways from different sources, but the most common is the `init(named:)`, 


Here are some rules:

* **Bundle Image Resources**: use the name of the file without extension and **without the density suffix** (`@2x`, `@3x`, etc.), that way the variant that best fits will be automatically selected for you.
* **Images Inside Asset Catalogs**: use the name of the image set that you want to load.



Let's bring some examples on how you can do it using different SDK's.

### UIKit and Xamarin.iOS projects

The UIKit is the classical iOS interface development library. Images are loaded through the `UIImage` component and presented on the screen with the `UIImageView`. If you're using View Code here's a snippet for presenting an image in a Swift Playground:

```swift
let
```

If you're using 


### SwiftUI

If your project is using SwiftUI all you need is the `Image()` passing the name of the asset as of the rules we've set above. Here's a snippet from our sample app:

```swift
HStack {
    Image("ic_email")
    TextField("E-mail", text: $email)
}.padding()
```

This declares an icon to illustrate the purpose of the text directly beside it. Here's the full screenshot of this implementation:

![](img/with-swiftui.png)

The `Image()` component has a few overloads of its initializer that allows you to load images from different sources, but any further customization is done through the _modifiers_. Take a look on the code of the image that declares the _devices_ image:

```swift
Image("devices")
    .resizable()
    .scaledToFit()
    .frame(width: 200)
```

The `devices` asset is a PDF image that is very large (more than 600 points), so in order to make it fit better our purpose we have made resizable, used `scaleToFit` to make it resize proportionally and set its frame to 200 points, making it fit better on the actual screen.

Last but not least, suppose you want to replace the icons images with SF Symbols. You just use a different initializer with the `systemName` argument, such as:

```swift
HStack {
    Image(systemName: "envelope")
    TextField("E-mail", text: $email)
}.padding()

HStack {
    Image(systemName: "lock")
    SecureField("Password", text: $password)
}.padding()
```

Which results in the following appearance:

![](img/with-swiftui-sf.png)

### Xamarin.Forms

In Xamarin.Forms we present images with the `Image` component like so:

```xml
<Image Source="mfractor_logo" />
``` 

You can simply pass the name of the asset you want to load to the `Source` property as of the rules we've set above. This works because on the covers there's a `UIImageView`, so the Xamarin.Forms encapsulates the same calls on the UIKit section.

## MFractor Tools for Image Assets

As you have seen, managing images assets can become very dauting dependending on the complexity of your project and how your design team works. MFractor brings several tools to facilitate this management. The most known one is the Image Importer that assists you on importing images to all the projects of your solution in the correct sizes from a single file. Here's a peak of the of its dialog:


We're working on allow multiple images to be imported at once. 


## What about MAUI?


-----

Historically image assets where simply image files that we would add to a folder in our project, and then reference from an `UIImage`, but with the ever growing screen sizes and densities, using plain low resolution images is not enough.

. Every modern app, the crudiest its UI may be will have some sort of graphics to be presented elsewhere.

- SF Symbols

**Purpose**
To discuss the various different kinds of iOS assets and how they are stored.


References

https://www.avanderlee.com/xcode/svg-image-assets/
https://www.avanderlee.com/swift/sf-symbols-guide/
https://developer.apple.com/library/archive/documentation/2DDrawing/Conceptual/DrawingPrintingiOS/LoadingImages/LoadingImages.html