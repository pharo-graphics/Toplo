Class {
	#name : #ToLabelMonoLineMode,
	#superclass : #ToLabelLineMode,
	#category : #'Toplo-Widget-Label'
}

{ #category : #adding }
ToLabelMonoLineMode >> addEditorIn: aLabel [

	| editor |
	editor := aLabel newEditor.
	editor editorElement editor addEditorShortcut: (ToLabelEditorCarriageReturnShortcut new
			 label: aLabel;
			 yourself).
	editor editorElement editor addEditorShortcut: (ToLabelEditorEscapeShortcut new
			 label: aLabel;
			 yourself).
	aLabel addEditor: editor
]

{ #category : #initialization }
ToLabelMonoLineMode >> newTextElement [

	^ BlAttributedTextElement new
		  editorMeasurement;
		  yourself
]
