# IPtProxy

Lyrebird/Obfs4proxy and Snowflake Pluggable Transports for iOS, MacOS and Android

[![JitPack](https://jitpack.io/v/tladesignz/IPtProxy.svg)](https://jitpack.io/#tladesignz/IPtProxy)
[![Maven Central](https://img.shields.io/maven-central/v/com.netzarchitekten/IPtProxy.svg?label=Maven%20Central)](https://search.maven.org/search?q=g:%22com.netzarchitekten%22%20AND%20a:%22IPtProxy%22)
[![Version](https://img.shields.io/cocoapods/v/IPtProxy.svg?style=flat)](https://cocoapods.org/pods/IPtProxy)
[![License](https://img.shields.io/cocoapods/l/IPtProxy.svg?style=flat)](https://cocoapods.org/pods/IPtProxy)
[![Platform](https://img.shields.io/cocoapods/p/IPtProxy.svg?style=flat)](https://cocoapods.org/pods/IPtProxy)

| Transport | Version |
|-----------|---------|
| Lyrebird  | 0.2.0   |
| Snowflake | 2.9.2   |

Both Lyrebird/Obfs4proxy and Snowflake Pluggable Transports are written in Go, which
is a little annoying to use on iOS and Android.
This project encapsulates all the machinations to make it work and provides an
easy to install binary including a wrapper around both.

Problems solved in particular are:

- One cannot compile `main` packages with `gomobile`. Both PTs are patched
  to avoid this.
- Both PTs are gathered under one roof here, since you cannot have two
  `gomobile` frameworks as dependencies, since there are some common Go
  runtime functions exported, which would create a name clash.
- Environment variable changes during runtime will not be recognized by
  `goptlib` when done from within Swift/Objective-C. Therefore, sensible
  values are hardcoded in the Go wrapper.
- Snowflake and Lyrebird/Obfs4proxy are patched to accept all configuration parameters
  directly.
- Free ports to be used are automatically found by this library and returned to the
  consuming app. You can use the initial values for premature configuration, which
  is just fine in situations, where you can be pretty sure, they're going to be 
  available (typically on iOS). 
  When that's not the case (e.g. multiple instances of your app on a multi-user
  Android), you should first start the transports and then use the returned ports
  for configuration of other components (e.g. Tor). 

## iOS/macOS

### Installation

IPtProxy is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your `Podfile`:

```ruby
pod 'IPtProxy', '~> 3.8'
```

### Getting Started

Before using IPtProxy you need to specify a place on disk for the transports 
to store their state information and log files.

**From version 2.0.0 onwards, there's no default anymore!**
This is out of security concerns, esp. on Android.

You will need to provide `StateLocation` *before* use of any transport:

```swift
let fm = FileManager.default

// Good choice for apps where IPtProxy runs inside an extension:

if let ptDir = fm
    .containerURL(forSecurityApplicationGroupIdentifier: "group.com.example.app")? 
    .appendingPathComponent("pt_state")?
    .path
{
    IPtProxy.setStateLocation(ptDir)
}

// For normal apps which run IPtProxy inline:

if let ptDir = fm.urls(for: .documentDirectory, in: .userDomainMask)
    .first?
    .appendingPathComponent("pt_state")
    .path 
{
    IPtProxy.setStateLocation(ptDir)
}
```

There's a companion library [IPtProxyUI](https://github.com/tladesignz/IPtProxyUI-ios)
which explains the use of IPtProxy and provides all the necessary UI and additional 
information to use this library in a Tor context.

For a headache-free start into the world of Tor on iOS and macOS, check out
the new [`TorManager` project](https://github.com/tladesignz/TorManager).


## Android 

### Installation

From version 1.9.0 onward, IPtProxy is available through 
[Maven Central](https://central.sonatype.com/artifact/com.netzarchitekten/IPtProxy). 
To install it, simply add the following line to your `build.gradle` file:

```groovy
implementation 'com.netzarchitekten:IPtProxy:3.8.1'
```

It is also available through [JitPack](https://jitpack.io). To install
it from there, add the following line to your `build.gradle` file:

```groovy
implementation 'com.github.tladesignz:IPtProxy:3.8.1'
```

And add this to your root `build.gradle` at the end of repositories:

```groovy
allprojects {
  repositories {
    // ...
    maven {
      url 'https://jitpack.io'
      content {
        includeModule('com.github.tladesignz', 'IPtProxy')
      }
    }
  }
}
```

For newer Android Studio projects created in 
[Android Studio Bumblebee | 2021.1.1](https://developer.android.com/studio/preview/features?hl=hu#settings-gradle) 
or newer, the JitPack repository needs to be added into the root level file `settings.gradle` 
instead of `build.gradle`:

```groovy
dependencyResolutionManagement {
  repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
  repositories {
    // ...
    maven {
      url 'https://jitpack.io'
      content {
        includeModule('com.github.tladesignz', 'IPtProxy')
      }
    }
  }
}
```

#### Security Concerns:

Since it is relatively easy in the Java/Android ecosystem to inject malicious
packages into projects by leveraging the order of repositories and release malicious
versions of packages on repositories which come *before* the original one in the
search order, the only way to keep yourself safe is to explicitly define, which 
packages should be loaded from which repository, when you use multiple repositories:

https://docs.gradle.org/5.1/userguide/declaring_repositories.html#sec::matching_repositories_to_dependencies


### Getting Started

If you are building a new Android application be sure to declare that it uses the
`INTERNET` permission in your Android Manifest:

```xml
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="my.test.app">

    <uses-permission android:name="android.permission.INTERNET"/>
    <application ...

```

Before using IPtProxy you need to specify a place on disk for the transports
to store their state information and log files.

**From version 2.0.0 onwards, there's no default anymore!**
This is out of security concerns, esp. on Android.

You will need to provide `StateLocation` *before* use of any transport.

`Context#getCacheDir()`, `Context#getFilesDir()` or `Context#getNoBackupFilesDir()` 
are good choices for this.

**Do not use a directory outside the app's private storage!**

```java
File ptDir = new File(getCacheDir(), "pt_state");

IPtProxy.setStateLocation(ptDir.getAbsolutePath());
```


## Build

### Requirements

This repository contains a precompiled iOS and Android version of IPtProxy.
If you want to compile it yourself, you'll need Go 1.21 as a prerequisite.

You will also need Xcode installed when compiling for iOS and an Android NDK
when compiling for Android.

The build script needs the gomobile binary and will install it, if not available, yet.
However, you'll still need to make it accessible in your `$PATH`.

So, if it's not already, add `$GOPATH/bin` to `$PATH`. The default location 
for `$GOPATH` is `$HOME/go`: 

```shell
export PATH=$HOME/go/bin/:$PATH` 
```

### iOS

Make sure Xcode and Xcode's command line tools are installed. Then run

```shell
rm -rf IPtProxy.xcframework && ./build.sh
```

This will create an `IPtProxy.xcframework`, which you can directly drop in your app,
if you don't want to rely on CocoaPods.

### Android

Make sure that `javac` is in your `$PATH`. If you do not have a JDK instance, on Debian systems you can install it with: 

```shell
apt install default-jdk 
````

If they aren't already, make sure the `$ANDROID_HOME` and `$ANDROID_NDK_HOME` 
environment variables are set:

```shell
export ANDROID_HOME=~/Android/Sdk
export ANDROID_NDK_HOME=$ANDROID_HOME/ndk/$NDK_VERSION

rm -rf IPtProxy.aar IPtProxy-sources.jar && ./build.sh android
```

This will create an `IPtProxy.aar` file, which you can directly drop in your app, 
if you don't want to rely on Maven Central or JitPack.

On certain CPU architectures `gobind` might fail with this error due to setting
a flag that is no longer supported by Go since version 1.16:

```
go tool compile: exit status 1
unsupported setting GO386=387. Consider using GO386=softfloat instead.
gomobile: go build -v -buildmode=c-shared -o=/tmp/gomobile-work-855414073/android/src/main/jniLibs/x86/libgojni.so ./gobind failed: exit status 1
```

If this is the case, you will need to set this flag to build IPtProxy:

```shell
export GO386=sse2
```

## Release

### Update go.mod

If `Lyrebird` or `Snowflake` was updated, you might need to update the dependencies:

- Check, that `go.mod` mentions the right versions of `Lyrebird` and `Snowflake`.
- Then, do the following:

```shell
cd IPtProxy.go
go mod tidy
go get golang.org/x/mobile/cmd/gomobile@latest
```

A release commit needs the following:

### Append [CHANGELOG](CHANGELOG.md).

### Update IPtProxy and dependencies' version numbers in 

  - [Podspec](IPtProxy.podspec)
  - [README](README.md)
  - [JitPack](jitpack.yml)
  - [pom](pom.xml)

### Do fresh builds

```shell
rm -rf IPtProxy.xcframework && ./build.sh
rm -f IPtProxy.aar IPtProxy-sources.jar && ./build-android.sh
```

### Tag and push changes 

```shell
git add .
git commit -m Release version <tag>.
git tag <tag>
git push
git push --tags
```

### CocoaPods

```shell
pod trunk push --skip-import-validation
```

### Maven Central

- Run `bundle.sh` like this:

```shell
./bundle.sh <version> [<GPG signing key ID>] 
```

If you don't define your signing key, the first available will be used.
If no keys, no signing will be done. Maven Central will reject unsigned artifacts.

To see your available keys, run this:

```shell
gpg --list-secret-keys
```

- Go to https://s01.oss.sonatype.org/#staging-upload.
- Select upload mode "Artifact Bundle".
- Upload bundle and release.

See also: https://gitlab.com/-/snippets/2482490


## Further reading

https://tordev.guardianproject.info


## Authors

- Benjamin Erhart, berhart@netzarchitekten.com
- Nathan Freitas
- Bim

for the Guardian Project https://guardianproject.info


## License

IPtProxy is available under the MIT license. See the [LICENSE](LICENSE) file for more info.