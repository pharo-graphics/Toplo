Class {
	#name : #ToBadgeAtRight,
	#superclass : #ToBadgePlacement,
	#category : #'Toplo-Widget-Float'
}

{ #category : #configuration }
ToBadgeAtRight >> configureBadge: aBadge [

	aBadge constraintsDo: [ :c |
			c anchors removeAll.
			c anchors add:
				(c anchors rightAnchor on:
					 c anchors parent rightAnchor + aBadge offset x).
			c anchors add: (c anchors verticalCenterAnchor on:
					 c anchors parent verticalCenterAnchor + aBadge offset y) ]
]
