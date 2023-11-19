Class {
	#name : 'ToNotebookHeaderOnRight',
	#superclass : 'ToNotebookHeaderPositioning',
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'hook' }
ToNotebookHeaderOnRight >> applyOn: aNotebook [

	aNotebook beHorizontal.
	aNotebook beRightToLeft.
	aNotebook header beVertical.
	aNotebook header hFitContent.
	aNotebook header vMatchParent.
	aNotebook buttons do: [ :b | b geometry: self buttonGeometry ].
]

{ #category : 'accessing' }
ToNotebookHeaderOnRight >> buttonGeometry [

	^ BlRoundedRectangleGeometry cornerRadii: (BlCornerRadii new
			   topLeft: 0;
			   topRight: 8;
			   bottomLeft: 0;
			   bottomRight: 8;
			   yourself)
]
