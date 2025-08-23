Class {
	#name : #ToAnchoredAtCenter,
	#superclass : #ToAnchoredPlacement,
	#category : #'Toplo-Widget-Float'
}

{ #category : #configuration }
ToAnchoredAtCenter >> configure: anAnchored [

	anAnchored constraintsDo: [ :c |
			c anchors removeAll.
			c anchors add: (c anchors centerAnchor on:
					 c anchors parent centerAnchor + anAnchored offset) ]
]
