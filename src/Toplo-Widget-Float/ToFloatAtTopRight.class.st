Class {
	#name : #ToFloatAtTopRight,
	#superclass : #ToFloatPlacement,
	#category : #'Toplo-Widget-Float'
}

{ #category : #configuration }
ToFloatAtTopRight >> configure: aFloat [

	aFloat constraintsDo: [ :c |
			c anchors removeAll.
			c anchors add: (c anchors topRightAnchor on:
					 c anchors parent topRightAnchor + aFloat offset) ]
]
