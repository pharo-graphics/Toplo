Class {
	#name : #ToBadgeAtTop,
	#superclass : #ToBadgePlacement,
	#category : #'Toplo-Widget-Float'
}

{ #category : #configuration }
ToBadgeAtTop >> configureBadge: aBadge [

	aBadge constraintsDo: [ :c |
			c anchors removeAll.
			c anchors add:
				(c anchors topAnchor on:
					 c anchors parent topAnchor + aBadge offset y).
			c anchors add: (c anchors horizontalCenterAnchor on:
					 c anchors parent horizontalCenterAnchor + aBadge offset x) ]
]
