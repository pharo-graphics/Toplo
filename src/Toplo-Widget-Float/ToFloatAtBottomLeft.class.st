Class {
	#name : #ToFloatAtBottomLeft,
	#superclass : #ToFloatPlacement,
	#category : #'Toplo-Widget-Float'
}

{ #category : #configuration }
ToFloatAtBottomLeft >> configure: aFloat [

	aFloat constraintsDo: [ :c |
			c anchors removeAll.
			c anchors add: (c anchors bottomLeftAnchor on:
					 c anchors parent bottomLeftAnchor + aFloat offset) ]
]
