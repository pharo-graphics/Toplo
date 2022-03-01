Class {
	#name : #ToEditor,
	#superclass : #ToEditorElement,
	#traits : 'TBrLayoutResizable',
	#classTraits : 'TBrLayoutResizable classTrait',
	#instVars : [
		'textReplacedHandler'
	],
	#category : #'Toplo-Widgets-Editor'
}

{ #category : #'api - editor' }
ToEditor >> addEditorShortcut: aBrTextEditorInteraction [
	self editor addEditorShortcut: aBrTextEditorInteraction
]

{ #category : #'api - editor' }
ToEditor >> beEditable [
	self beMode: BrTextEditorEditableMode new
]

{ #category : #'api - editor' }
ToEditor >> beMode: aTextEditorMode [
	self viewModel mode: aTextEditorMode
]

{ #category : #'api - editor' }
ToEditor >> beReadOnlyWithSelection [
	self beMode: BrTextEditorReadonlyWithSelectionMode new
]

{ #category : #'api - editor' }
ToEditor >> beReadOnlyWithoutSelection [
	self beMode: BrTextEditorReadonlyWithoutSelectionMode new
]

{ #category : #'editor - accessing' }
ToEditor >> cursors [
	<return: #BrTextEditorCursor>
	^ self editor cursors
]

{ #category : #'editor - operations' }
ToEditor >> deleter [
	<return: #BrTextEditorDeleter>

	^ self editor deleter
]

{ #category : #'editor - operations' }
ToEditor >> deselecter [
	<return: #BrTextEditorDeselecter>

	^ self editor deselecter
]

{ #category : #accessing }
ToEditor >> editor: aBrTextEditor [
	self editor removeEventHandler: textReplacedHandler.

	super editor: aBrTextEditor.

	aBrTextEditor addEventHandler: textReplacedHandler
]

{ #category : #initialization }
ToEditor >> initialize [
	super initialize.
	
	self matchParent.

	textReplacedHandler := BlEventHandler
		on: BrTextEditorTextReplacedEvent
		"we intentionally set text directly to the viewModel
		to prevent any possible #asRopedText convertion"
		do: [ :anEvent | self viewModel text: anEvent text ].

	self editor: BrTextEditor new.
	self padding: (BlInsets all: 5).
	
	self viewModel: BrEditorModel new
]

{ #category : #'api - editor' }
ToEditor >> inputFilter: aBrTextEditorInputFilter [
	self editor inputFilter: aBrTextEditorInputFilter
]

{ #category : #'editor - operations' }
ToEditor >> inserter [
	<return: #BrTextEditorInserter>

	^ self editor inserter
]

{ #category : #'api - editor' }
ToEditor >> isEditable [
	<return: #Boolean>

	^ self viewModel mode isEditable
]

{ #category : #'api - editor' }
ToEditor >> isReadOnly [
	<return: #Boolean>

	^ self viewModel mode isReadOnly
]

{ #category : #'editor - operations' }
ToEditor >> navigator [
	<return: #BrTextEditorNavigator>

	^ self editor navigator
]

{ #category : #'editor - operations' }
ToEditor >> selecter [
	<return: #BrTextEditorSelecter>

	^ self editor selecter
]

{ #category : #'editor - accessing' }
ToEditor >> selection [
	<return: #BlSelection>

	^ self editor selection
]

{ #category : #'editor - accessing' }
ToEditor >> styler [
	^ self viewModel styler
]

{ #category : #'editor - accessing' }
ToEditor >> styler: aStyler [
	self viewModel styler: aStyler
]

{ #category : #'editor - accessing' }
ToEditor >> text [
	"Return a text I work with. All modifications to a text must be done from UI thread"
	<return: #BlText>

	^ self viewModel text
]

{ #category : #'editor - accessing' }
ToEditor >> text: aBlText [
	self viewModel text: aBlText asRopedText
]
