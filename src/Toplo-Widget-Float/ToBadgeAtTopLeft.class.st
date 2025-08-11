Class {
	#name : #ToBadgeAtTopLeft,
	#superclass : #ToBadgePlacement,
	#category : #'Toplo-Widget-Float'
}

{ #category : #configuration }
ToBadgeAtTopLeft >> configureBadge: aBadge [

	aBadge constraintsDo: [ :c |
			c anchors removeAll.
			c anchors add: (c anchors topLeftAnchor on:
					 c anchors parent topLeftAnchor + aBadge offset) ]
]
