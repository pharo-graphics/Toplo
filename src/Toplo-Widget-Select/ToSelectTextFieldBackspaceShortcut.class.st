Class {
	#name : #ToSelectTextFieldBackspaceShortcut,
	#superclass : #AlbEditorDeleteOneLetterBeforeCursorShortcut,
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #evaluation }
ToSelectTextFieldBackspaceShortcut >> performOnEditor: aTextEditor element: anEditorElement dueTo: aShortcutEvent [

	anEditorElement text ifEmpty: [
		anEditorElement rootAlbumElement nodeBeforeDo: [ :node |
			node isRemovable ifTrue: [
				node removeFromSelect.
				^ self ] ] ].
	super
		performOnEditor: aTextEditor
		element: anEditorElement
		dueTo: aShortcutEvent
]
