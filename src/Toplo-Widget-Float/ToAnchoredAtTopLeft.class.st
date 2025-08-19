Class {
	#name : #ToAnchoredAtTopLeft,
	#superclass : #ToAnchoredPlacement,
	#category : #'Toplo-Widget-Float'
}

{ #category : #configuration }
ToAnchoredAtTopLeft >> configure: anAnchored [

	anAnchored constraintsDo: [ :c |
			c anchors removeAll.
			c anchors add: (c anchors topLeftAnchor on:
					 c anchors parent topLeftAnchor - anAnchored offset) ]
]
