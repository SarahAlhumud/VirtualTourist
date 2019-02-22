# VirtualTourist
VirtualTourist is the final project for iOS Developer Nanodegree Program in Udacity.

[![Swift Version](https://img.shields.io/badge/Swift-4.2-success.svg)](https://swift.org)
[![Xcode Version](https://img.shields.io/badge/Xcode-10.1-success.svg)](https://swift.org)
[![Platform](https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat)](https://swift.org)

## Overview 
The Virtual Tourist app downloads and stores images from Flickr. The app allows users to drop pins on a map, as if they were stops on a tour. Users will then be able to download pictures for the location and persist both the pictures, and the association of the pictures with the pin.

## Features

- [x] Persisting state on the device.
- [x] Downloading data from network resources -Flickr API.
- [x] Building polished user interfaces with UIKit components.
- [x] Using MapKit.

## Requirements

- iOS 12.1+
- Xcode 10.1

## Installation
1. Download and unzip ```VirtualTourist.zip```.  
2. Congratulations! 

## How to use this app
1. After run VirtualTourist and to add pin, Press the favourite place on the map that you want to see Flickr pictures in that place.
2. When a pin is tapped, the app transitions to the photo album associated with the pin.
3. Click on any picture to delete it.
4. The Photo Album view has the `New Collection` button that initiates the download of a new album, replacing the images in the photo album with a new set from Flickr. The new set should contain different images (if available) from the ones previously displayed.
5. After quit VirtualTourist, the pins and pictures are saved.


## To Do:
1. Add favourite tab.
2. Add favourite picture in specific place to that tab.
