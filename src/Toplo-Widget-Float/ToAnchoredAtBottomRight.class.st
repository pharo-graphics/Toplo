Class {
	#name : #ToAnchoredAtBottomRight,
	#superclass : #ToAnchoredPlacement,
	#category : #'Toplo-Widget-Float'
}

{ #category : #configuration }
ToAnchoredAtBottomRight >> configure: anAnchored [

	anAnchored constraintsDo: [ :c |
			c anchors removeAll.
			c anchors add: (c anchors bottomRightAnchor on:
					 c anchors parent bottomRightAnchor + anAnchored offset) ]
]
