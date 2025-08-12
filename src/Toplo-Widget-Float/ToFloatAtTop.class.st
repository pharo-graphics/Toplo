Class {
	#name : #ToFloatAtTop,
	#superclass : #ToFloatPlacement,
	#category : #'Toplo-Widget-Float'
}

{ #category : #configuration }
ToFloatAtTop >> configure: aFloat [

	aFloat constraintsDo: [ :c |
			c anchors removeAll.
			c anchors add:
				(c anchors topAnchor on:
					 c anchors parent topAnchor + aFloat offset y).
			c anchors add: (c anchors horizontalCenterAnchor on:
					 c anchors parent horizontalCenterAnchor + aFloat offset x) ]
]
