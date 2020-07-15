## Introduction

In Xamarin.Forms, one of the most powerful tools at our disposal is **Data Binding**. Data-binding allows use to *connect* properties between our views and view models, having changes in one area automatically apply onto the other.

This is accomplished using the `Binding` expression in XAML to specify the relationship and using the `INotifyPropertyChanged` interface.

This article will dive into the usage of `INotifyPropertyChanged` and how we can then simplify it with Fody.

## An Overview Of INotifyPropertyChanged

The `INotifyPropertyChanged` interface is a part of the .NET runtime that we use to expose a `PropertyChanged` event that can notify that a particular property changed on a class.

To use `INotifyPropertyChanged`, we implement the interface and then trigger the `PropertyChanged`.

An interface that adds behavoiur to notify that a classes property value changes.

At a rudimentary level, we implement property change

## Using INotifyPropertyChanged

To use `INotifyPropertyChanged`, first we must implement the interface on a

Implement the interface, add event and trigger the event on property changed.

Trigger property changed events.

A helper method to trigger property changed.

Triggering multiple prope

Sample code and GIF demonstrating property changed.

## Simplifying Property Changed With Fody

While powerful, one drawback of `INotifyPropertyChanged` is that we need to manually fire the property changed notifications ourselves.

This can lead a few issues:

 * It is possible we can forget to fire the PropertyChanged event and accidentally create bugs.
 * Properties that fire `PropertyChanged` require a backing field,
 * If we want to trigger other property changed events for a property, we must also manage that code in our

In short, implementing `INotifyPropertyChanged` creates maintainence issues

To solve this maintainability cost, we can instead use Fody to automatically inject property changed events for our properties.

Instead of using backing fields and triggering property events, we write normal properties and Fody automatically adds the changed events through a build process known as weaving. At a high level, Fody introduces a build task to post-process specified assemblies, modify their IL (the binary instructions in a .net DLL) to fire

basically, with a dab of magic we now get property changed

The concept of re-weaving is beyond the scope of this article

**Fody requires a patron sponsorship to receive support. Please sponsor Fody to support the development of this incredible technology.**

### Notifying Dependent Properties
Say we have defined two properties, `Password` and `HasPassword`, where `HasPassword` is a null or empty check on `Password`.

When `Password` is changed, we need a property changed event to be raised for `HasPassword` to implement this behaviour.

This is where the real magic begins for Fody.

How to use property changed?
Simplifying property changed notifications by using Fody
Brief outline of the core attributes of Fody property changed

Call to action to sponsor Fody.

## Summary
