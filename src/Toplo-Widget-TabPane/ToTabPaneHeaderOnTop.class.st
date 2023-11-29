Class {
	#name : 'ToTabPaneHeaderOnTop',
	#superclass : 'ToTabPaneHeaderPositioning',
	#category : 'Toplo-Widget-TabPane',
	#package : 'Toplo-Widget-TabPane'
}

{ #category : 'hook' }
ToTabPaneHeaderOnTop >> applyOn: aTabPane [

	super applyOn: aTabPane.
	aTabPane beVertical.
	aTabPane beRightToLeft.
	aTabPane header beHorizontal.
	aTabPane header hMatchParent.
	aTabPane header vFitContent.
	aTabPane tabs do: [ :b | b geometry: self tabGeometry ].
]

{ #category : 'accessing' }
ToTabPaneHeaderOnTop >> tabGeometry [

	^ BlRoundedRectangleGeometry cornerRadii: (BlCornerRadii new
			   topLeft: 8;
			   topRight: 8;
			   bottomLeft: 0;
			   bottomRight: 0;
			   yourself)
]
