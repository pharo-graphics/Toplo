Class {
	#name : #ToBadgeAtBottom,
	#superclass : #ToBadgePlacement,
	#category : #'Toplo-Widget-Float'
}

{ #category : #configuration }
ToBadgeAtBottom >> configureBadge: aBadge [

	aBadge constraintsDo: [ :c |
			c anchors removeAll.
			c anchors add:
				(c anchors bottomAnchor on:
					 c anchors parent bottomAnchor + aBadge offset y).
			c anchors add: (c anchors horizontalCenterAnchor on:
					 c anchors parent horizontalCenterAnchor + aBadge offset x) ]
]
