Class {
	#name : #ToAnchoredAtRight,
	#superclass : #ToAnchoredPlacement,
	#category : #'Toplo-Widget-Float'
}

{ #category : #configuration }
ToAnchoredAtRight >> configure: anAnchored [

	anAnchored constraintsDo: [ :c |
			c anchors removeAll.
			c anchors add:
				(c anchors rightAnchor on:
					 c anchors parent rightAnchor + anAnchored offset x).
			c anchors add: (c anchors verticalCenterAnchor on:
					 c anchors parent verticalCenterAnchor + anAnchored offset y) ]
]
