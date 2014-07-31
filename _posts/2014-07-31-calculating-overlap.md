---
layout: post
title: Calculating the overlap of aerial photos
permalink: calculating-overlap
---

This post describes how to calculate the required distances between successive photos, given a required overlap between those photos. I then go on to calculate the required speed that a UAV should fly at to give this required overlap, given the time between successive photos.

<!--more-->

## Calculating inter-photo distance

\\[ d_{int} = 2h\\tan\\left(\\frac{\\alpha_y}{2}\\right) - \\mathrm{overlap} \\\\\\
= 2h\\tan\\left(\\frac{\\alpha_y}{2}\\right) - 2h\\omega\\tan\\left(\\frac{\\alpha_y}{2}\\right) \\\\\\
= 2h\\tan\\left(\\frac{\\alpha_y}{2}\\right)\\left[ 1 - \\omega \\right] \\]

## Calculating UAV speed

The speed that a UAV must fly at, \\( v_{UAV} \\), given the time interval between successive photos, \\( t_{int} \\), is then simply given by:

\\[ v = \\frac{d_{int}}{t_{int}} = \\]
