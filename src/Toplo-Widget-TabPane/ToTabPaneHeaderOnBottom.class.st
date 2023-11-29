Class {
	#name : 'ToTabPaneHeaderOnBottom',
	#superclass : 'ToTabPaneHeaderPositioning',
	#category : 'Toplo-Widget-TabPane',
	#package : 'Toplo-Widget-TabPane'
}

{ #category : 'hook' }
ToTabPaneHeaderOnBottom >> applyOn: aTabPane [

	super applyOn: aTabPane.
	aTabPane beVertical.
	aTabPane beLeftToRight.
	aTabPane header beHorizontal.
	aTabPane header hMatchParent.
	aTabPane header vFitContent.
	aTabPane tabs do: [ :b | b geometry: self tabGeometry ].
]

{ #category : 'accessing' }
ToTabPaneHeaderOnBottom >> tabGeometry [

	^ BlRoundedRectangleGeometry cornerRadii: (BlCornerRadii new
			   topLeft: 0;
			   topRight: 0;
			   bottomLeft: 8;
			   bottomRight: 8;
			   yourself)
]
