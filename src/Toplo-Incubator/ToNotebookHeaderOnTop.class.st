Class {
	#name : 'ToNotebookHeaderOnTop',
	#superclass : 'ToNotebookHeaderPositioning',
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'hook' }
ToNotebookHeaderOnTop >> applyOn: aNotebook [

	aNotebook beVertical.
	aNotebook beLeftToRight.
	aNotebook header beHorizontal.
	aNotebook header hMatchParent.
	aNotebook header vFitContent.
	aNotebook buttons do: [ :b | b geometry: self buttonGeometry ].
]

{ #category : 'accessing' }
ToNotebookHeaderOnTop >> buttonGeometry [

	^ BlRoundedRectangleGeometry cornerRadii: (BlCornerRadii new
			   topLeft: 8;
			   topRight: 8;
			   bottomLeft: 0;
			   bottomRight: 0;
			   yourself)
]
