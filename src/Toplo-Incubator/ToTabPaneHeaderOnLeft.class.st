Class {
	#name : 'ToTabPaneHeaderOnLeft',
	#superclass : 'ToTabPaneHeaderPositioning',
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'hook' }
ToTabPaneHeaderOnLeft >> applyOn: aTabPane [

	super applyOn: aTabPane.
	aTabPane beHorizontal.
	aTabPane beRightToLeft.
	aTabPane header beVertical.
	aTabPane header hFitContent.
	aTabPane header vMatchParent.
	aTabPane header tabsContainer beVertical.
	aTabPane tabs do: [ :b | b geometry: self tabGeometry ].
]

{ #category : 'accessing' }
ToTabPaneHeaderOnLeft >> tabGeometry [

	^ BlRoundedRectangleGeometry cornerRadii: (BlCornerRadii new
			   topLeft: 8;
			   topRight: 0;
			   bottomLeft: 8;
			   bottomRight: 0;
			   yourself)
]
