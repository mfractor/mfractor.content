# Creating Custom Renderers

Creating a compelling user interface is a must when it comes to mobile development.  What works for iOS may not be acceptable in Android and vice versa. In order to accommodate the various platform expectations, we must be able to customize and create controls as needed. Renderers allows us this flexibility.

For this article, let’s extend an existing control such as a button and add features that currently don’t exist. I would like the background of a button to accommodate gradients rather than just a solid color. For those using MFractor, I will demonstrate how to do this using their toolset as well as how to navigate to existing renderers.  I also intend to share my experience with file nesting and how it has helped me organize my projects.

## Custom Controls
Let’s first begin by extending the button class and adding properties that currently don’t exist like gradient start and end colors. If you are unfamiliar with bindable properties, read our article on [creating bindable properties](https://www.mfractor.com/blogs/news/using-bindable-properties-in-xamarin-forms).

```
    public class CoreButton: Button
    {
        /// <summary>
        /// Start color for the gradient (top) color
        /// </summary>
        public static readonly BindableProperty StartColorProperty =
            BindableProperty.Create("StartColor",
                                    typeof(Color),
                                    typeof(CoreButton),
                                    Color.Black);
        public Color StartColor
        {
            get { return (Color)this.GetValue(StartColorProperty); }
            set { this.SetValue(StartColorProperty, value); }
        }

        /// <summary>
        /// End color for the gradient (bottom) color
        /// </summary>
        public static readonly BindableProperty EndColorProperty =
            BindableProperty.Create("EndColor",
                                    typeof(Color),
                                    typeof(CoreButton),
                                    Color.Black);
        public Color EndColor
        {
            get { return (Color)this.GetValue(EndColorProperty); }
            set { this.SetValue(EndColorProperty, value); }
        }
    }
```

## Custom Renderers
Now let’s create renderers that will utilize the new bindable properties based on a specific platform.  We will create a class for each platform that inherits from ButtonRenderer and attach the ExportRender attribute so that Xamarin will use it instead of the default renderer. There are two ways to do this. We can use MFractor toolset or do this manually.

### MFractor
Click Alt+Return on the custom controls name and select ‘Generate custom renderers…’. A folder named Renderers will be created in each platform project with the control’s renderer class.

![Drag Racing]( https://user-images.githubusercontent.com/4968267/72367779-0988d200-36ba-11ea-85f3-ce593c1b3341.png=550x)

The generated file should look something like this.

```
[assembly: ExportRenderer (typeof(CoreButton), typeof(CoreButtonRenderer))]

	namespace RendererExample.Droid.Renderers
	{
	    public class CoreButtonRenderer : ButtonRenderer
	    {
	        public CoreButtonRenderer(Context context) : base(context)
	        {
	        }

	        protected override void OnElementChanged(ElementChangedEventArgs<Xamarin.Forms.Button> e)
	        {
	            base.OnElementChanged(e);
	        }

	        protected override void OnElementPropertyChanged(object sender, PropertyChangedEventArgs e)
	        {
	            base.OnElementPropertyChanged(sender, e);
	        }
	    }

	}
```

In the future, you can easily locate your custom renderer in MFractor by right clicking on the name of the class and selecting [`Find Custom Renderers`](https://docs.mfractor.com/xamarin-forms/custom-renderers/find-custom-renderers/).

### Manually

Creating these classes manually really isn’t that difficult but having a tool that makes the step easier and quicker is very nice.  As mentioned before, I would like to share a couple of tips from coding large projects.  It’s great that MFractor provides an easy way to navigate to renderers but I also like to keep my code organized in the same project.  This is possible is you use shared projects.  Another advantage is that your code is always compiled to the same SDK level of the deploying project.

Let’s begin by ensuring we can nest files.  In order to enable this is Visual Studio Mac, install the file nesting extension

![Drag Racing](https://user-images.githubusercontent.com/4968267/72367651-ce869e80-36b9-11ea-8181-87d2e7806612.png=550x)

Now in your shared project, create a folder called ‘CustomControls’ and add the new control file we created at the beginning.  In the same folder create a class called ‘CoreButtonRenderer.Droid.cs’ and ‘CoreButtonRenderer.iOS.cs’.  I annotate the file name with the platform so that is visually easy to differentiate and as well as prevent duplicate name conflicts.  Now, right click on the file and select ‘File Nesting’ and place it under the custom control.

![Drag Racing](https://user-images.githubusercontent.com/4968267/72367540-98491f00-36b9-11ea-9c41-4b40bad8bfed.png=550x)

The project should look like this now and visually it is easy to find the renderers without jumping around to different projects.

![Drag Racing](https://user-images.githubusercontent.com/4968267/72363249-bf9bee00-36b1-11ea-8ecf-249fdd6eba8e.png=250x)

One last thing we need to do is allow disparate platform specific code within the same project.  This is accomplished using compiler directives.  Surround the entire code with the appropriate directive as shown below.

![Drag Racing](https://user-images.githubusercontent.com/4968267/72367628-bf075580-36b9-11ea-905a-1ad48cf77c88.png=550x)

![Drag Racing](https://user-images.githubusercontent.com/4968267/72367574-ab5bef00-36b9-11ea-8f3c-e48e4cf2370c.png=550x)

## Renderer Implementation
In our renderers we need to create a gradient layer that can be placed in the background of the control. The code base provided is very simple and production code should accommodate for property changes as well as give the user a visual indication that the button has been clicked.

### iOS
In iOS we will use the CAGradientLayer and insert it as the first layer of the control.  It is always a good idea to check if the instance has any null values before trying to perform any action. iOS is also finicky on sizing so we are overriding the LayoutSubviews method and ensuring the new layer fits properly under the control.

```
    public class CoreButtonRenderer : ButtonRenderer
    {
        private CAGradientLayer gradient;
        public CoreButton caller;
        protected override void OnElementChanged(ElementChangedEventArgs<Xamarin.Forms.Button> e)
        {
            base.OnElementChanged(e);
            if (e.OldElement == null && Control!=null)
            {
                caller = e.NewElement as CoreButton;
                gradient = new CAGradientLayer();
                gradient.Frame = Control.Bounds;
                gradient.CornerRadius = Control.Layer.CornerRadius = caller.CornerRadius;

                gradient.Colors = new CGColor[]
                {
                    caller.StartColor.ToCGColor(),
                    caller.EndColor.ToCGColor(),
                };

                Control?.Layer.InsertSublayer(gradient, 0);
            }
        }

        protected override void OnElementPropertyChanged(object sender, PropertyChangedEventArgs e)
        {
            base.OnElementPropertyChanged(sender, e);
        }

        public override void LayoutSubviews()
        {
            if (Control != null)
            {
                foreach (var layer in Control.Layer.Sublayers.Where(layer => layer is CAGradientLayer))
                {
                    layer.Frame = new CGRect(0, 0, caller.Bounds.Width, caller.Bounds.Height);
                }
            }
            base.LayoutSubviews();
        }
    }
```

### Android
Android is similar in that we create a GradientDrawable but instead of inserting as an additional layer, it becomes the new background of the control.  A helper extension is provided to shape the corners of the gradient based on the appropriate display metrics.

```
    public class CoreButtonRenderer : ButtonRenderer
    {
        private Context _context;
        public CoreButtonRenderer(Context context) : base(context)
        {
            _context = context;
        }

        protected override void OnElementChanged(ElementChangedEventArgs<Xamarin.Forms.Button> e)
        {
            base.OnElementChanged(e);
            if (Control != null)
            {
                var caller = e.NewElement as CoreButton;
                var gradient = new GradientDrawable(GradientDrawable.Orientation.TopBottom, new[] {
                    caller.StartColor.ToAndroid().ToArgb(),
                    caller.EndColor.ToAndroid().ToArgb()
                });

                gradient.SetCornerRadius(caller.CornerRadius.ToDevicePixels(_context));
                Control.SetBackground(gradient);
                var num = caller.IsEnabled ? 105f : 100f;
                Control.Elevation = num;
                Control.TranslationZ = num;
            }
        }

        protected override void OnElementPropertyChanged(object sender, PropertyChangedEventArgs e)
        {
            base.OnElementPropertyChanged(sender, e);
        }
    }

    public static class HelperExtension
    {
        public static float ToDevicePixels(this int number, Context ctx)
        {
            var displayMetrics = ctx.Resources.DisplayMetrics;
            return (float)System.Math.Round(number * (displayMetrics.Xdpi / (float)Util.DisplayMetricsDensity.Default));
        }
    }
```

Now it is time to use our new control and see how it looks and behaves. Here is the code.

```
    public class PageOne: ContentPage
    {
        public PageOne()
        {
            Content = new StackLayout()
            {
                Children =
                {
                    new CoreButton()
                    {
                        Margin=new Thickness(40,100,40,100),
                        CornerRadius=5,
                        StartColor = Color.LightGreen,
                        EndColor = Color.DarkGreen,
                        TextColor = Color.White,
                        Text = "Perform Action"
                    }
                }
            };
        }
    }
```

Here is the result!

![Drag Racing](https://user-images.githubusercontent.com/4968267/72618232-e6e3fc80-38f7-11ea-847d-2e92361f0835.png=250x)

The entire code base can be found on [Github](https://github.com/azdevelopnet/MFactor/tree/master/RendererExample). Enjoy the incredible tools provided by MFractor and try file nesting to see if it cleans up your project files and organization.
