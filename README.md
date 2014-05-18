iOS-SOAP-Handler
================

A simple SOAP web service handler utility for iOS development

When I was in need to call SOAP web service via my iOS app I got fed up searching in Google for a proper way of doing it.
So I thought to make a small utility to use when I need SOAP web services so that I dont need to rewrite the code again.
I made this some time back and today I thought to make this public.
It has a delegate which will be called back to a successfull responce.

In your app if you need to add SOAP service calls just add the below three classes to your project and make your webservice calling class the delegate.

classes you need to drag into your project
SOAPServiceDelegate.h, 
SOAPServices.h, 
SOAPServices.m

ViewController.m has a sample SOAP service call done using the utility classes, for clairity.

Hope this will make your work easy!
