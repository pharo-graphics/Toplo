Class {
	#name : #ToNotebookHeaderOnLeft,
	#superclass : #ToNotebookHeaderPositioning,
	#category : 'Toplo-Incubator'
}

{ #category : #hook }
ToNotebookHeaderOnLeft >> applyOn: aNotebook [

	aNotebook beHorizontal.
	aNotebook beLeftToRight.
	aNotebook header beVertical.
	aNotebook header hFitContent.
	aNotebook header vMatchParent.
	aNotebook buttons do: [ :b | b geometry: self buttonGeometry ].
]

{ #category : #accessing }
ToNotebookHeaderOnLeft >> buttonGeometry [

	^ BlRoundedRectangleGeometry cornerRadii: (BlCornerRadii new
			   topLeft: 8;
			   topRight: 0;
			   bottomLeft: 8;
			   bottomRight: 0;
			   yourself)
]
