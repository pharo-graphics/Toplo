Class {
	#name : #ToLabelEditorBasicDresser,
	#superclass : #ToAlbumBasicDresser,
	#category : #'Toplo-Widget-Label'
}

{ #category : #'api - hooks' }
ToLabelEditorBasicDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.

	anElement editorElement geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	"remove padding to ensure that the editor is exactly at the right position according to the label text"
	anElement editorElement padding: BlInsets empty.
	"draw the border outside"
	anElement editorElement outskirts: BlOutskirts outside.
	anElement editorElement fitContent.
	" do not clip children otherwise the editor may be invisible"
	anElement clipChildren: false
]
