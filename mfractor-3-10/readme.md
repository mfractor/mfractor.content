#


Building mobile apps is asset-heavy and image resources are one of the backbones of development. One of the difficulties when working with images is locating the correct resource.

Often we are trying to lookup images by name and do not have a visual preview of that image. Without being able to see the image, there is no easy way to verify it's the right asset.

In MFractor 3.10, we've introduced iamge tooltips to solve this problem. Image tooltips are support in XAML, C# and in iOS and Android projects.

Let's dive into each feature.

#
MFractor 3.10 is now available and this release we've added image tooltips across the board.

 Re-enabled image tooltips to make it much easier to work with images.

 This allows you to visually preview images in XAML, making it easier to lcoate

 * Hover in XAML and C#
 * For XAML Intellisense completions

 When applying an image to an `ImageSource`, our image intellisense in XAML now also shows you a preview

 Also supported for Android drawables.

# Image Tooltips for Android


# Image Tooltips for C#

MFractor supports image tooltips for Android projects in C# for Resources lookups.

Hover over a Resources.Drawable.imageName to see a previews.

When attaching an image to an activity (EG: Using Icon="@drawable/myImage"), MFractor shows a preview.

 To use, hover over a color.

# Color Tooltips

 * Hover in XAML
 * XAML intellisense previews

# Static Resource actions

# Additional Features in 3.10

 * Color tooltis for XAML
 *

Full release notes can be found


To get full access to our image tooltips, purchase 
