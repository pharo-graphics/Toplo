Class {
	#name : 'ToPabPaneHeaderOnBottom',
	#superclass : 'ToTabPaneHeaderPositioning',
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'hook' }
ToPabPaneHeaderOnBottom >> applyOn: aNotebook [

	aNotebook beVertical.
	aNotebook beRightToLeft.
	aNotebook header beHorizontal.
	aNotebook header hMatchParent.
	aNotebook header vFitContent.
	aNotebook tabs do: [ :b | b geometry: self tabGeometry ].
]

{ #category : 'as yet unclassified' }
ToPabPaneHeaderOnBottom >> tabGeometry [

	^ BlRoundedRectangleGeometry cornerRadii: (BlCornerRadii new
			   topLeft: 0;
			   topRight: 0;
			   bottomLeft: 8;
			   bottomRight: 8;
			   yourself)
]
