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

{ #category : #'event management' }
ToEditorElement >> dispatchEvent: anEvent [
	super dispatchEvent: anEvent
]

{ #category : #accessing }
ToEditorElement >> editor [
	<return: #BrTextEditor>

	^ self dataSource
]

{ #category : #accessing }
ToEditorElement >> editor: aBrTextEditor [
	self editor removeEventHandler: textStyleHandler.
	self dataSource: aBrTextEditor.
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
