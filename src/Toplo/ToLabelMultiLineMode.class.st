Class {
	#name : #ToLabelMultiLineMode,
	#superclass : #ToLabelLineMode,
	#category : #'Toplo-Widget-Label'
}

{ #category : #adding }
ToLabelMultiLineMode >> addEditorIn: aLabel [

	| editor |
	editor := aLabel newEditor.
	editor editorElement editor addEditorShortcut: (ToLabelEditorCarriageReturnShortcut new
			 combination: BlKeyCombination primaryReturn;
			 label: aLabel;
			 yourself).
	editor editorElement editor addEditorShortcut: (ToLabelEditorEscapeShortcut new
			 label: aLabel;
			 yourself).
	aLabel addEditor: editor
]

{ #category : #layout }
ToLabelMultiLineMode >> defaultLayout [

	^ BlFlowLayout new.
]

{ #category : #initialization }
ToLabelMultiLineMode >> newTextElement [

	^ ToMultiLineTextElement  new
]
