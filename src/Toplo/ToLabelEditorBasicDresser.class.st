Class {
	#name : #ToLabelEditorBasicDresser,
	#superclass : #ToDresser,
	#category : #'Toplo-Widget-Label'
}

{ #category : #'api - hooks' }
ToLabelEditorBasicDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	
	anElement elevation: (BlRelativeElevation elevation: SmallInteger maxVal).

	anElement innerElement geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	"remove padding to ensure that the editor is exactly at the right position according to the label text"
	anElement innerElement padding: BlInsets empty.
	anElement innerElement margin: BlInsets empty.
	anElement padding: BlInsets empty.
	anElement margin: BlInsets empty.
	"draw the border outside"
	anElement innerElement outskirts: BlOutskirts outside.
	anElement innerElement fitContent.
	" do not clip children otherwise the editor may be invisible"
	anElement clipChildren: false
]
