Class {
	#name : #ToFloatAtBottom,
	#superclass : #ToFloatPlacement,
	#category : #'Toplo-Widget-Float'
}

{ #category : #configuration }
ToFloatAtBottom >> configure: aFloat [

	aFloat constraintsDo: [ :c |
			c anchors removeAll.
			c anchors add:
				(c anchors bottomAnchor on:
					 c anchors parent bottomAnchor + aFloat offset y).
			c anchors add: (c anchors horizontalCenterAnchor on:
					 c anchors parent horizontalCenterAnchor + aFloat offset x) ]
]
