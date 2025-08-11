Class {
	#name : #ToBadgeAtLeft,
	#superclass : #ToBadgePlacement,
	#category : #'Toplo-Widget-Float'
}

{ #category : #configuration }
ToBadgeAtLeft >> configureBadge: aBadge [

	aBadge constraintsDo: [ :c |
			c anchors removeAll.
			c anchors add:
				(c anchors leftAnchor on:
					 c anchors parent leftAnchor + aBadge offset x).
			c anchors add: (c anchors verticalCenterAnchor on:
					 c anchors parent verticalCenterAnchor + aBadge offset y) ]
]
