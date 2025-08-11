Class {
	#name : #ToBadgeAtBottomLeft,
	#superclass : #ToBadgePlacement,
	#category : #'Toplo-Widget-Float'
}

{ #category : #configuration }
ToBadgeAtBottomLeft >> configureBadge: aBadge [

	aBadge constraintsDo: [ :c |
			c anchors removeAll.
			c anchors add: (c anchors bottomLeftAnchor on:
					 c anchors parent bottomLeftAnchor + aBadge offset) ]
]
