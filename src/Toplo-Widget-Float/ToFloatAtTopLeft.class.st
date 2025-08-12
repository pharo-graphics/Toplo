Class {
	#name : #ToFloatAtTopLeft,
	#superclass : #ToFloatPlacement,
	#category : #'Toplo-Widget-Float'
}

{ #category : #configuration }
ToFloatAtTopLeft >> configure: aFloat [

	aFloat constraintsDo: [ :c |
			c anchors removeAll.
			c anchors add: (c anchors topLeftAnchor on:
					 c anchors parent topLeftAnchor + aFloat offset) ]
]
