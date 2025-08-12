Class {
	#name : #ToFloatAtRight,
	#superclass : #ToFloatPlacement,
	#category : #'Toplo-Widget-Float'
}

{ #category : #configuration }
ToFloatAtRight >> configure: aFloat [

	aFloat constraintsDo: [ :c |
			c anchors removeAll.
			c anchors add:
				(c anchors rightAnchor on:
					 c anchors parent rightAnchor + aFloat offset x).
			c anchors add: (c anchors verticalCenterAnchor on:
					 c anchors parent verticalCenterAnchor + aFloat offset y) ]
]
