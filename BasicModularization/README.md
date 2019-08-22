# Basic Modularized App

The workspace found in this directory has been created as supplemental material for my talk  
"Modularize All The Things".
  
You can find the slides and recordings for this talk, as well as other talks I have done, on my website   [https://abgl.ca/talks](https://www.abbeyjackson.ca).
  
### **DO NOT USE THIS REPO FOR CODE SAMPLES**  
  
**The projects in this workspace were created to demonstrate  
modular app development using private internal frameworks. The  
code in this project has been written ONLY to silence Xcode  
warnings and enable the framework to compile in order to interact  
with the other frameworks within the larger workspace.**  
  
***  

## Description
  
This directory contains a workspace. Inside that workspace is an app and three modules. These modules are linked to the modularized app in such a way that changes in the modules will be picked up and shown in the app when the app is ran.

The modules demonstrate encapsulating features and passing data between modules using protocols. There are other methods you could use but protocols are usually the best choice for swift modules/projects. Another good method of sharing data between modules, which Apple uses extensively, is the delegate pattern. However that is not demonstrated.

This project is set up with the hopes to be as entry level as possible. For that reason storyboards and segues are used. I assume that if you develop without storyboards you should be at such a level that you can figure out what you need to do in order to use programmatic UI instead of storyboards. Additionally there is one use of Codable and also you will see dictionary parsing to mimic the good old fashioned json parsing we had to do before Codable. I originally was not going to use Codable at all because I wanted to be as entry level as possible and many people will not know how to use Codable yet however for time's savings I caved and used it in one location. If you are a new learning and you are confused please don't hesitate to reach out!

## How to Interact with Modules

In this project the `Database` (a class supplied by the `Persistence` module) stores objects that conform to a `DataObject` protocol. The `User` class is supplied by the `UserData` module. The `UserData` and `Persistence` modules do not know about each other. So how can we store user objects?

It's actually really straight forward: In our app itself we have an extension on `User` class and we use that extension to conform to the `DataObject` protocol. Voila!

You may be tempted to modify the `User` class directly inside the `UserData` module however doing that would negate everything you gain by modularization. The power of modularization is being able to develop features independent of each other (which allows for reusability and better testing). When you are trying to determine how to get modules to interact with each other try to think of ways to abstract those layers apart rather than having them communicate directly. This could be achieved with view models in your app or simply extensions - again, in your app. 

Think of your app as the place where everything is connected and with that in mind as yourself "what can I do to connect these?"

## Testing

In the  `UserData` test target there is a demonstration of how you can access internal functionality on unrelated modules. This demonstration is there as a warning. I absolutely _do not_ recommend doing this on purpose. Doing so would violate unit testing principles.

Additionally an aggregate target on the app has been added and named "Workspace Testing" and is there to demonstrate one way of setting up your test targets. Please read the comment in the runscript phase of that target for more information.
