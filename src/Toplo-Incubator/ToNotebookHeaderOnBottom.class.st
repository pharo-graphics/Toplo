Class {
	#name : 'ToNotebookHeaderOnBottom',
	#superclass : 'ToNotebookHeaderPositioning',
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'hook' }
ToNotebookHeaderOnBottom >> applyOn: aNotebook [

	aNotebook beVertical.
	aNotebook beRightToLeft.
	aNotebook header beHorizontal.
	aNotebook header hMatchParent.
	aNotebook header vFitContent.
	aNotebook buttons do: [ :b | b geometry: self buttonGeometry ].
]

{ #category : 'as yet unclassified' }
ToNotebookHeaderOnBottom >> buttonGeometry [

	^ BlRoundedRectangleGeometry cornerRadii: (BlCornerRadii new
			   topLeft: 0;
			   topRight: 0;
			   bottomLeft: 8;
			   bottomRight: 8;
			   yourself)
]
