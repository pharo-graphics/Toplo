Class {
	#name : 'ToTabPaneHeaderOnTop',
	#superclass : 'ToTabPaneHeaderPositioning',
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'hook' }
ToTabPaneHeaderOnTop >> applyOn: aNotebook [

	aNotebook beVertical.
	aNotebook beLeftToRight.
	aNotebook header beHorizontal.
	aNotebook header hMatchParent.
	aNotebook header vFitContent.
	aNotebook tabs do: [ :b | b geometry: self tabGeometry ].
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
