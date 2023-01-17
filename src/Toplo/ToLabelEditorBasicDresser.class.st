Class {
	#name : #ToLabelEditorBasicDresser,
	#superclass : #ToDresser,
	#category : #'Toplo-Widget-Label'
}

{ #category : #'api - hooks' }
ToLabelEditorBasicDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	"anElement infinite geometry: (BlRoundedRectangleGeometry cornerRadius: 4)."
	"anElement infinite border: (BlBorder paint: anElement selectionColor).
	anElement infinite outskirts: BlOutskirts outside."
	anElement fitContent.
	anElement next fitContent.
	anElement infinite fitContent.
	"anElement next elevation: ((BlRelativeElevation elevation: SmallInteger maxVal))."
	"anElement infinite background: Color veryLightGray."
	anElement clipChildren: false.
	"anElement next clipChildren: false."


]
