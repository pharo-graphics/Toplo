Class {
	#name : #ToLabelEditorBasicDresser,
	#superclass : #ToDresser,
	#category : #'Toplo-Widget-Label'
}

{ #category : #'api - hooks' }
ToLabelEditorBasicDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement next geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	anElement next outskirts: BlOutskirts outside.
	anElement next fitContent.

]
