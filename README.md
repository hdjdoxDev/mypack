#  My Framework
Backbone to easily write simple apps using the powerfull **Flutter Widgets** to design UIs and fast and flexible **APIs** to store data and use common services. Many features are still being added.

This is the juice I got sqeezing the code collected while learning Flutter e developing different apps.
It's a work in progress, so it's not perfect and it's not meant to be used in production, but it's a good starting point for a new project.
Obviously not all the code or the ideas in this framework are mine, some might :).

It's highly modular and works on a [View & ViewModel - Service] frame to keep UI dart code, business logic and 
API managment separated.
This frame lays on general [Models] that contains abstract objects definitions and implementations.

<!-- 
| Feature | Android | iOS | Linux | macOS |
| :--- | :---: | :---: | :---: | :---: |
| Examples for (View - ViewModel) | ✔️ | ✔️ | ✔️ | ✔️ |
| SQFLite support | ✔️ | ✔️ | ✔️ | ✔️ |
| Firebase Firestore support | ❌️ | ❌️ | ❌️ | ❌️ |
| Notifications | ✔️ | ❌ | ❌ | ❌️ |
| Device Storage | ✔️ | ❌ | ✔️ | ❌️ |
| CSV support | ✔️ | ❌ | ✔️ | ❌️ |
| Peer to Peer | ❌ | ❌ | ❌️ | ❌️ | -->

## Content
- [/lib](lib/README.md#content) - the framework
- [/snippets](snippets/README.md#list) - snippets for VSCode
- [/example](example/README.md#content) - example app
- [/fonts](fonts/README.md#content) - fonts
- pubspec.yaml - dependencies

## Todo

- [ ] [Snippets](snippets/README.md#list)
- [ ] [Lib](lib/README.md#todo)

## Willdo

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
