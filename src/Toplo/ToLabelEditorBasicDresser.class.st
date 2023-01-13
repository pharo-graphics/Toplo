Class {
	#name : #ToLabelEditorBasicDresser,
	#superclass : #ToDresser,
	#category : #'Toplo-Widget-Label'
}

{ #category : #'api - hooks' }
ToLabelEditorBasicDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement innerElement geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	anElement innerElement outskirts: BlOutskirts outside.
	anElement innerElement fitContent.

]
