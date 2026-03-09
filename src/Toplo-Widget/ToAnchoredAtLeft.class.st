Class {
	#name : #ToAnchoredAtLeft,
	#superclass : #ToAnchoredPlacement,
	#category : #'Toplo-Widget-Float'
}

{ #category : #configuration }
ToAnchoredAtLeft >> configure: anAnchored [

	anAnchored constraintsDo: [ :c |
			c anchors removeAll.
			c anchors add:
				(c anchors leftAnchor on:
					 c anchors parent leftAnchor - anAnchored offset x).
			c anchors add: (c anchors verticalCenterAnchor on:
					 c anchors parent verticalCenterAnchor + anAnchored offset y) ]
]
