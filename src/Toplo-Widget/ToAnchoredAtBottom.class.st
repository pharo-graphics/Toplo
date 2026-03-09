Class {
	#name : #ToAnchoredAtBottom,
	#superclass : #ToAnchoredPlacement,
	#category : #'Toplo-Widget-Float'
}

{ #category : #configuration }
ToAnchoredAtBottom >> configure: anAnchored [

	anAnchored constraintsDo: [ :c |
			c anchors removeAll.
			c anchors add:
				(c anchors bottomAnchor on:
					 c anchors parent bottomAnchor + anAnchored offset y).
			c anchors add: (c anchors horizontalCenterAnchor on:
					 c anchors parent horizontalCenterAnchor + anAnchored offset x) ]
]
