Class {
	#name : 'ToTabPaneHeaderOnRight',
	#superclass : 'ToTabPaneHeaderPositioning',
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'hook' }
ToTabPaneHeaderOnRight >> applyOn: aNotebook [

	aNotebook beHorizontal.
	aNotebook beRightToLeft.
	aNotebook header beVertical.
	aNotebook header hFitContent.
	aNotebook header vMatchParent.
	aNotebook tabs do: [ :b | b geometry: self tabGeometry ].
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
