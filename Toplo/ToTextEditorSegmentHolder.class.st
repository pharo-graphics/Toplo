Class {
	#name : #ToTextEditorSegmentHolder,
	#superclass : #ToEditorSegmentHolder,
	#category : #'Toplo-Editor-Model - Segment'
}

{ #category : #updating }
ToTextEditorSegmentHolder >> onCursorChanged [
	"Is sent when text editor's cursor changes.
	Segment holder should update text elements accordingly"
	
	self subclassResponsibility
]

{ #category : #updating }
ToTextEditorSegmentHolder >> onFocusChanged: aBoolean [
	"Is sent when text editor's focus state changes.
	Segment holder should update text elements accordingly"

	self subclassResponsibility
]

{ #category : #updating }
ToTextEditorSegmentHolder >> onSelectionChanged [
	"Is sent when text editor's selection changes.
	Segment holder should update text elements accordingly"
	
	self subclassResponsibility
]

{ #category : #updating }
ToTextEditorSegmentHolder >> onTextChanged [
	"Is sent when text changed in the editor (for example style attributes).
	Segment holder should update text elements accordingly"
	
	self subclassResponsibility
]
