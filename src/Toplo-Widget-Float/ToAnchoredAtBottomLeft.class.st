Class {
	#name : #ToAnchoredAtBottomLeft,
	#superclass : #ToAnchoredPlacement,
	#category : #'Toplo-Widget-Float'
}

{ #category : #configuration }
ToAnchoredAtBottomLeft >> configure: anAnchored [

	anAnchored constraintsDo: [ :c |
			c anchors removeAll.
			c anchors add: (c anchors bottomLeftAnchor on:
					 c anchors parent bottomLeftAnchor + (anAnchored offset x negated @ anAnchored offset y) ) ]
]
