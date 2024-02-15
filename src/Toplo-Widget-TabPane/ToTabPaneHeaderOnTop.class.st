Class {
	#name : #ToTabPaneHeaderOnTop,
	#superclass : #ToTabPaneHeaderPositioning,
	#category : 'Toplo-Widget-TabPane'
}

{ #category : #hook }
ToTabPaneHeaderOnTop >> applyOn: aTabPane [

	super applyOn: aTabPane.
	aTabPane beVertical.
	aTabPane beRightToLeft.
	aTabPane header beHorizontal.
	aTabPane header hMatchParent.
	aTabPane header vFitContent.
	aTabPane header tabRow beHorizontal.
	aTabPane header tabRowContainer vFitContent.
	aTabPane header tabRowContainer hMatchParent.
	aTabPane header tabRowContainer beHorizontal.
	aTabPane header tabRow constraintsDo: [ :c |
		c linear vertical alignBottom ].
	aTabPane header tabRowContainer constraintsDo: [ :c |
		c linear vertical alignBottom ].
	aTabPane tabs do: [ :b |
		b geometry: self tabGeometry.
		b constraintsDo: [ :c | c linear vertical alignBottom ] ]
]

{ #category : #accessing }
ToTabPaneHeaderOnTop >> tabGeometry [

	^ BlRoundedRectangleGeometry cornerRadii: (BlCornerRadii new
			   topLeft: 8;
			   topRight: 8;
			   bottomLeft: 0;
			   bottomRight: 0;
			   yourself)
]
