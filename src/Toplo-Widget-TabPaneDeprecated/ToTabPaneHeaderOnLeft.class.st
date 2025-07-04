Class {
	#name : #ToTabPaneHeaderOnLeft,
	#superclass : #ToTabPaneHeaderPositioning,
	#category : #'Toplo-Widget-TabPaneDeprecated-Internals'
}

{ #category : #hook }
ToTabPaneHeaderOnLeft >> applyOn: aTabPane [

	super applyOn: aTabPane.
	aTabPane beHorizontal.
	aTabPane beRightToLeft.
	aTabPane header beVertical.
	aTabPane header hFitContent.
	aTabPane header vMatchParent.
	aTabPane header tabRow beVertical.
	aTabPane header tabRowContainer hFitContent.
	aTabPane header tabRowContainer vMatchParent.
	aTabPane header tabRowContainer beVertical.
	aTabPane header tabRow constraintsDo: [ :c |
		c linear horizontal alignRight ].
	aTabPane header tabRowContainer constraintsDo: [ :c |
		c linear horizontal alignRight ].
	aTabPane tabs do: [ :b |
		b geometry: self tabGeometry.
		b constraintsDo: [ :c | c linear horizontal alignRight ] ]
]

{ #category : #accessing }
ToTabPaneHeaderOnLeft >> tabGeometry [

	^ BlRoundedRectangleGeometry cornerRadii: (BlCornerRadii new
			   topLeft: 8;
			   topRight: 0;
			   bottomLeft: 8;
			   bottomRight: 0;
			   yourself)
]
