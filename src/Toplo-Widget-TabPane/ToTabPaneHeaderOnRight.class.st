Class {
	#name : 'ToTabPaneHeaderOnRight',
	#superclass : 'ToTabPaneHeaderPositioning',
	#category : 'Toplo-Widget-TabPane',
	#package : 'Toplo-Widget-TabPane'
}

{ #category : 'hook' }
ToTabPaneHeaderOnRight >> applyOn: aTabPane [

	super applyOn: aTabPane.
	aTabPane beHorizontal.
	aTabPane beLeftToRight.
	aTabPane header beVertical.
	aTabPane header hFitContent.
	aTabPane header vMatchParent.
	aTabPane header tabRow beVertical.
	aTabPane header tabRowContainer hFitContent.
	aTabPane header tabRowContainer vMatchParent.
	aTabPane header tabRowContainer beVertical.
	aTabPane header startContainer hMatchParent; vFitContent.
	aTabPane header endContainer hMatchParent; vFitContent.
	aTabPane tabs do: [ :b | b geometry: self tabGeometry ].
]

{ #category : 'accessing' }
ToTabPaneHeaderOnRight >> tabGeometry [

	^ BlRoundedRectangleGeometry cornerRadii: (BlCornerRadii new
			   topLeft: 0;
			   topRight: 8;
			   bottomLeft: 0;
			   bottomRight: 8;
			   yourself)
]
