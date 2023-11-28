Class {
	#name : 'ToTabPaneHeaderOnLeft',
	#superclass : 'ToTabPaneHeaderPositioning',
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'hook' }
ToTabPaneHeaderOnLeft >> applyOn: aNotebook [

	aNotebook beHorizontal.
	aNotebook beLeftToRight.
	aNotebook header beVertical.
	aNotebook header hFitContent.
	aNotebook header vMatchParent.
	aNotebook tabs do: [ :b | b geometry: self tabGeometry ].
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
