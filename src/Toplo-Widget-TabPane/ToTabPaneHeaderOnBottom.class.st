Class {
	#name : #ToTabPaneHeaderOnBottom,
	#superclass : #ToTabPaneHeaderPositioning,
	#category : #'Toplo-Widget-TabPane-Internals'
}

{ #category : #hook }
ToTabPaneHeaderOnBottom >> applyOn: aTabPane [

	super applyOn: aTabPane.
	aTabPane beVertical.
	aTabPane beLeftToRight.
	aTabPane header beHorizontal.
	aTabPane header hMatchParent.
	aTabPane header vFitContent.
	aTabPane header tabRow beHorizontal.
	aTabPane header tabRowContainer vFitContent.
	aTabPane header tabRowContainer hMatchParent.
	aTabPane header tabRowContainer beHorizontal.
	aTabPane header tabRow constraintsDo: [ :c |
		c linear vertical alignTop ].
	aTabPane header tabRowContainer constraintsDo: [ :c |
		c linear vertical alignTop ].
	aTabPane tabs do: [ :b |
		b geometry: self tabGeometry.
		b constraintsDo: [ :c | c linear vertical alignTop ] ]
]

{ #category : #accessing }
ToTabPaneHeaderOnBottom >> tabGeometry [

	^ BlRoundedRectangleGeometry cornerRadii: (BlCornerRadii new
			   topLeft: 0;
			   topRight: 0;
			   bottomLeft: 8;
			   bottomRight: 8;
			   yourself)
]
