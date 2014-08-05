---
layout: post
title: Calculating the overlap of aerial photos
permalink: calculating-overlap
---

The setup is as follows: you have a camera attached to a UAV which is taking pictures regularly every five seconds, and you need at least 80% overlap between the photos in order to properly stitch them together into a Digital Elevation Model (DEM). What do you do? How far apart should each photo be? How fast do you need to fly your UAV in order to achieve this?

This post demonstrates how to go about calculating the required maximum distance between successive photos in order to ensure a certain percentage overlap between those photos, as a function of the required overlap, the angle of view of the camera and your height above the ground.

I then go on to show how to simply work out how fast you need to fly your UAV to achieve this overlap, given the time between successive photographs.

<!--more-->

## Calculating inter-photo distance

The geometry of the situation is shown below:

![geometry of overlap](/public/media/calculating-overlap/overlap.svg)

Let's call the inter-photo distance \\( d\_{int} \\), the angle of view \\( \\alpha\_y \\), the height \\( h \\) and the required overlap fraction \\( \\omega \\) (i.e. if we want 80% overlap, then \\( \\omega = 0.8 \\)).

\\[ d_{int} = 2h\\tan\\left(\\frac{\\alpha_y}{2}\\right) - \\mathrm{overlap} \\\\\\
= 2h\\tan\\left(\\frac{\\alpha_y}{2}\\right) - 2h\\omega\\tan\\left(\\frac{\\alpha_y}{2}\\right) \\\\\\
= 2h\\tan\\left(\\frac{\\alpha_y}{2}\\right)\\left[ 1 - \\omega \\right] \\]

## Calculating UAV speed

The speed that a UAV must fly at, \\( v\_{UAV} \\) , given the time interval between successive photos, \\( t_{int} \\), is then simply given by:

\\[ v\_{UAV} = \\frac{d\_{int}}{t\_{int}} = \\]
