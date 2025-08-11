Class {
	#name : #ToBadgeAtBottomRight,
	#superclass : #ToBadgePlacement,
	#category : #'Toplo-Widget-Float'
}

{ #category : #configuration }
ToBadgeAtBottomRight >> configureBadge: aBadge [

	aBadge constraintsDo: [ :c |
			c anchors removeAll.
			c anchors add: (c anchors bottomRightAnchor on:
					 c anchors parent bottomRightAnchor + aBadge offset) ]
]
