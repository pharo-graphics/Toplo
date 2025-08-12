Class {
	#name : #ToFloatAtLeft,
	#superclass : #ToFloatPlacement,
	#category : #'Toplo-Widget-Float'
}

{ #category : #configuration }
ToFloatAtLeft >> configure: aFloat [

	aFloat constraintsDo: [ :c |
			c anchors removeAll.
			c anchors add:
				(c anchors leftAnchor on:
					 c anchors parent leftAnchor + aFloat offset x).
			c anchors add: (c anchors verticalCenterAnchor on:
					 c anchors parent verticalCenterAnchor + aFloat offset y) ]
]
