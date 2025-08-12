Class {
	#name : #ToFloatAtBottomRight,
	#superclass : #ToFloatPlacement,
	#category : #'Toplo-Widget-Float'
}

{ #category : #configuration }
ToFloatAtBottomRight >> configure: aFloat [

	aFloat constraintsDo: [ :c |
			c anchors removeAll.
			c anchors add: (c anchors bottomRightAnchor on:
					 c anchors parent bottomRightAnchor + aFloat offset) ]
]
