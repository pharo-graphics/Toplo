Class {
	#name : #ToAnchoredAtTop,
	#superclass : #ToAnchoredPlacement,
	#category : #'Toplo-Widget-Float'
}

{ #category : #configuration }
ToAnchoredAtTop >> configure: anAnchored [

	anAnchored constraintsDo: [ :c |
			c anchors removeAll.
			c anchors add:
				(c anchors topAnchor on:
					 c anchors parent topAnchor - anAnchored offset y).
			c anchors add: (c anchors horizontalCenterAnchor on:
					 c anchors parent horizontalCenterAnchor + anAnchored offset x) ]
]
