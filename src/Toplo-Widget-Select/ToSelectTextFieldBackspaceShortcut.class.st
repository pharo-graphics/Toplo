Class {
	#name : #ToSelectTextFieldBackspaceShortcut,
	#superclass : #AlbEditorDeleteOneLetterBeforeCursorShortcut,
	#category : #'Toplo-Widget-Select-Filter-TextField'
}

{ #category : #evaluation }
ToSelectTextFieldBackspaceShortcut >> performOnEditor: aTextEditor element: anEditorElement dueTo: aShortcutEvent [

	anEditorElement text ifEmpty: [
		anEditorElement rootAlbumElement nodeBeforeDo: [ :node |
			node removeFromBar.
			^ self ] ].
	super
		performOnEditor: aTextEditor
		element: anEditorElement
		dueTo: aShortcutEvent
]
