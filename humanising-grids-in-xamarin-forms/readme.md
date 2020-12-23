# Humanising Grids In Xamarin.Forms

Specifying grid locations by name in Xamarin.Forms for more human XAML code.

## Introduction

It's an open secret that here at MFractor we have a crush on Grids. They are one of the most powerful layouts in Xamarin.Forms, allowing us to build beautiful user interfaces with pixel perfect precision.

However, after working with them for several years, there are one or two things that we feel could be improved.

This blog is part thought experiment, part proposal with the goal of making grids easier to work with by "humanising" their syntax.

So firstly, what do I mean by "humanising"? To me, this is the process of structuring code/syntax so that it is significantly easier to understand. I should be able to look at a piece of code and read it like a sentence, doing minimal translation in my head.

Consider the `is not null` syntax introduced in C# 9:

 * `if (value is not null)` vs `if (value != null)`.

The `value is not null` uses human language instead of operators and reads like a normal sentence.

Another example is the `foreach` keyword in C#:

 * `foreach (var item in Items)` vs `for (var i = 0; i < Items.Count; ++i) { var item = Items[i]; }`.

The `foreach` syntax is significantly easier to understand.

Before we dive into a potential solution to humanise the syntax of grid, let's explore an example that outlines the difficulties grids pose.

## The Problem With Grids In Xamarin.Forms

Grids, while a powerful and fast layout, have a fundamental drawback; we place controls using numbers and zero based indices to represent locations.

Zero based indices take a translation step in our heads (well, at least in mine!) to understand what the source

Let's consider the following code:

```
<Grid>
    <Grid.RowDefinitions>
        <RowDefinition Height="Auto"/>
        <RowDefinition Height="2"/>
        <RowDefinition Height="*"/>
    </Grid.RowDefinitions>

    <Label Grid.Row="0" /> <!-- Title label -->
    <ContentView Grid.Row="1" /> <!-- Content Divider-->
    <StackLayout Grid.Row="2"/> <!-- Content -->
    <ActivityIndicator Grid.RowSpan="3" /> <!-- Loading Indicator that covers all rows -->

</Grid>
```

Each time we place a control in the grid, we do so using a 0-based location. This has a few problems:

 1. We can accidentally use an index not declared in the `RowDefinitions/ColumnDefinitions` of the grid, creating a rendering bug.
 2. If we add or remove a row/column, we need to update the `RowDefinitions/ColumnDefinitions` and all affected indices in the grid. This adds a significant cost
 3. It is difficult to tell if we have correctly placed our control in the grid when looking at syntax such as `Grid.Row="1"`. There is a significant amount of thinking required to validate this location.

Given these issues, our goal is to replace the use of indices with names, making the code self-documenting and clearer to read.

## Making Grids Easier To Use

To humanise the syntax for grids, I've created two prototype markup extensions that allow grid locations to be referenced by name:

 * [`GridLocation`](https://github.com/matthewrdev/Xamarin.Forms.GridLocationExtension/blob/main/GridLocationMarkupExtension/GridLocationExtension.cs) can lookup the index of a named row or column in XAML: `Grid.Row={local:GridLocation namedRow}`.
 * [`GridSpan`](https://github.com/matthewrdev/Xamarin.Forms.GridLocationExtension/blob/main/GridLocationMarkupExtension/GridSpanExtension.cs) can calculate the span between two named rows or columns in XAML: `Grid.Row={local:GridSpan From=startRow, To=endRow}`.

These extensions require that each row and column definition include an `x:Name` attribute to expose it to the extension. For example: `<RowDefinition x:Name="contentRow" Height=Auto/>`.

This is an example of `GridLocation` and `GridSpan` applied to the previous code sample:

```
<Grid>
    <Grid.RowDefinitions>
        <RowDefinition x:Name="titleRow"  Height="Auto"/>
        <RowDefinition x:Name="dividerRow" Height="2"/>
        <RowDefinition x:Name="contentRow" Height="*"/>
    </Grid.RowDefinitions>

    <Label Grid.Row="{local:GridLocation titleRow}" /> <!-- Title label -->
    <ContentView Grid.Row="{local:GridLocation dividerRow}" /> <!-- Content Divider-->
    <StackLayout Grid.Row="{local:GridLocation contentRow}"/> <!-- Content -->
    <ActivityIndicator Grid.RowSpan="{local:GridSpan From=titleRow, To=contentRow}" /> <!-- Loading Indicator that covers all rows -->

</Grid>
```

There are a few benefits here:

 * The desired row/column of an element is described clearly through the `{local:GridLocation dividerRow}` syntax.
 * As rows/columns are resolved at runtime via the `GridLocation` extension, we can freely move and delete rows/columns without needing to readjust indices and spans.
 * We can use the `From` and `To` properties on `GridSpan`to calculate the correct spans through names. This reduces code complexity and makes it clear what the intended behaviour of a span should be.
* Each row/column definition are now documented via the `x:Name` attribute.

Immediately this code is more readable; a developer can look at it and clearly understand the intended location of a view in the UI. We are more likely to spot errors while building our UIs and code-reviewers can more easily understand the intent of our UIs.

Additionally, our XAML is now resilient to refactoring. Need to remove a row? No problem! Delete it and as rows are resolved by name, there is no need to update indices and spans.

## Disclaimer

While stable, tested and working, these extensions should be considered experimental. I wouldn't recommend using them in yours apps just yet for the following reasons:

 * The extensions execute a Xamarin.Forms internal API through reflection. Unless Xamarin.Forms [exposes the relevant APIs](https://github.com/xamarin/Xamarin.Forms/blob/release-4.8.0-sr6/Xamarin.Forms.Core/IProvideParentValues.cs), this methodology could break at any point in the future. **Xamarin.Forms Team: Please expose this API so I can do this properly 😅**
 * These extensions do not have API documentation.
 * These extensions do not have thorough error logging to assist you in diagnosing runtime issues.
 * These extensions use reflection to perform the location and span calculations. This may have adverse runtime performance impacts.
 * Finally, these extensions do not have code completion or design time analysis to assist in development. (But this could be added to MFractor pretty easily 😉).

## Summary

To recap, while grids are a powerful layout that gives pixel perfect control, they can be difficult to maintain. By replacing the use of 0-based indices with names, our code become more readable and more resilient to refactoring.

The full source code for the GridLocation and GridSpan extensions, as well as a working example of them, [can be found here](https://github.com/matthewrdev/Xamarin.Forms.GridLocationExtension).

🤙 Matthew Robbins - Founder of [www.mfractor.com](https://www.mfractor.com)
