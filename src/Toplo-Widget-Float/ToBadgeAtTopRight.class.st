Class {
	#name : #ToBadgeAtTopRight,
	#superclass : #ToBadgePlacement,
	#category : #'Toplo-Widget-Float'
}

{ #category : #configuration }
ToBadgeAtTopRight >> configureBadge: aBadge [

	aBadge constraintsDo: [ :c |
			c anchors removeAll.
			c anchors add: (c anchors topRightAnchor on:
					 c anchors parent topRightAnchor + aBadge offset) ]
]
