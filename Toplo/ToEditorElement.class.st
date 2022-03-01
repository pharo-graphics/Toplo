Class {
	#name : #ToEditorElement,
	#superclass : #BlInfiniteElement,
	#instVars : [
		'hasFocus',
		'textStyleHandler'
	],
	#category : #'Toplo-Widgets-Editor'
}

{ #category : #conversion }
ToEditorElement >> asScrollableElement [
	^ self
]

{ #category : #initialization }
ToEditorElement >> defaultLayout [
	^ BlInfiniteLinearLayout vertical
]

{ #category : #accessing }
ToEditorElement >> editor [
	<return: #ToTextEditor>

	^ self dataSource
]

{ #category : #accessing }
ToEditorElement >> editor: aTextEditor [
	self editor removeEventHandler: textStyleHandler.
	self dataSource: aTextEditor.
	self editor addEventHandler: textStyleHandler.
]

{ #category : #'focus testing' }
ToEditorElement >> hasFocus [
	^ hasFocus or: [ self isFocused ]
]

{ #category : #initialization }
ToEditorElement >> initialize [
	super initialize.

	hasFocus := false.
	self when: BlFocusInEvent do: [ hasFocus := true ].
	self when: BlFocusOutEvent do: [ hasFocus := false ].
	
	textStyleHandler := BlEventHandler
		on: BrTextEditorTextStyleRequested
		do: [ :anEvent | self editor stylerStrategy styleTextInEditorElement: self thenDo: anEvent afterAction ]
]

{ #category : #scrolling }
ToEditorElement >> scrollToLast [
	"Scroll instantly to the last segment"
	
	self scrollToPosition: self editor segmentCollector computedSegmentsCount
]
