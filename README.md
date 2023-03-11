#  My Framework

Backbone to easily write simple apps using the powerfull Flutter Widgets to design UIs and fast and flexible SQFLite to store data. More features will be added in the future.
This is the juice I got sqeezing the code collected in the last 3 years while I was learning Flutter e developing different apps.
I don't have too much time to make a good documentation of the Library yet, but for sure it is a work in progress and it will be refined.
Obviously not all the code or the ideas in this framework are mine, some might :).

It's highly modular and works on a [View & ViewModel - Service] frame to keep UI dart code, Business logic and Storage/APIs interfaces separated.
This frame lays on general [Models] that contains common objects definitions and implementations.

| Feature | Android | iOS | Linux | macOS |
| :--- | :---: | :---: | :---: | :---: |
| Examples for (View - ViewModel) | ✔️ | ✔️ | ✔️ | ✔️ |
| SQFLite support | ✔️ | ✔️ | ✔️ | ✔️ |
| Firebase Firestore support | ❌️ | ❌️ | ❌️ | ❌️ |
| Notifications | ✔️ | ❌ | ❌ | ❌️ |
| Device Storage | ✔️ | ❌ | ✔️ | ❌️ |
| CSV support | ✔️ | ❌ | ✔️ | ❌️ |
| Peer to Peer | ❌ | ❌ | ❌️ | ❌️ |


## DevOps

### Create App

> - go to the folder where you want to create the app and run:
> 
>       $ flutter create --org=hdjdox.com --platform=<platforms> --description="This is my latest app" --project-name <pname> <fname>
> -  set mypack as a dependency in pubspec.yaml
> -  copy lib/[main, routes, locator, view, model, widgets] from mypack/example
> -  create files with scripts and fill them with snippets

### Create Section

> - app
> - routes
> - locator
> - view
> - model
> - widgets
> - README.md
> - [apis](#create-tableapi)
> - [views](#create-cview)

### Create TableApi

> T -> TEntry, TFields -> ITApi, DumbTApi -> TApi, TTable

### Create CView

> CView -> CViewModel -> cWidgets, cViewModels


Dependencies: see ./pubspec.yaml

[Dev](lib/README.md)
