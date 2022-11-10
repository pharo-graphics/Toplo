Class {
	#name : #ToLabel,
	#superclass : #ToWidget,
	#traits : 'TBlAlignable + TOBlLayoutResizable',
	#classTraits : 'TBlAlignable classTrait + TOBlLayoutResizable classTrait',
	#instVars : [
		'textReplacedHandler',
		'innerElement'
	],
	#category : #'Toplo-Widget-Labels'
}

{ #category : #'private-editing' }
ToLabel >> addEditor [

	| editor |
	editor := self innerElement newEditorIn: self.
	self addEditor: editor
]

{ #category : #'private-editing' }
ToLabel >> addEditor: anEditor [

	| editorOverlay |
	self userData at: #editorOverlay ifPresent: [ ^ self ].
	self userData at: #editorOverlay put: (editorOverlay := BlOverlayElement new).
	self userData at: #editor put: anEditor.
	anEditor innerElement margin: self innerElement margin.
	editorOverlay clipChildren: false.
	self previousElevation: self elevation.
	self elevation: (BlRelativeElevation elevation: 1000).
	editorOverlay attachTo: self innerElement.
	editorOverlay addChild: anEditor.
	anEditor border: BlBorder empty.
	self previousClipping: self clipChildren.
	self previousVisibility: self innerElement visibility.
	self previousTextElementClipping: self innerElement clipChildren.
	self innerElement visibility: BlVisibility hidden.
	self innerElement clipChildren: false.
	self clipChildren: false.
	self addChild: editorOverlay.
	anEditor text: self text copy.
	anEditor innerElement requestFocus.
	anEditor innerElement selecter all; apply
	
]

{ #category : #initialization }
ToLabel >> beEditable [

	self editable: true
]

{ #category : #initialization }
ToLabel >> beMonoLine [

	self lineMode: ToLabelMultiLineMode new
]

{ #category : #initialization }
ToLabel >> beMultiLine [

	self lineMode: ToLabelMultiLineMode new
]

{ #category : #initialization }
ToLabel >> beReadOnly [

	self editable: false
]

{ #category : #initialization }
ToLabel >> defaultPaddings [

	^ BlInsets empty
		  
]

{ #category : #initialization }
ToLabel >> defaultTextElement [

	^ self lineMode newTextElementIn: self
]

{ #category : #initialization }
ToLabel >> defaultViewModel [

	^ ToLabelModel new.

]

{ #category : #accessing }
ToLabel >> editable [

	^ self viewModel editable
]

{ #category : #private }
ToLabel >> editable: aBoolean [

	self viewModel editable: aBoolean
]

{ #category : #'private-editing' }
ToLabel >> editor [

	^ self userData at: #editor
]

{ #category : #'private-editing' }
ToLabel >> editorOverlay [

	^ self userData at: #editorOverlay 
]

{ #category : #accessing }
ToLabel >> horizontalAlignment [
	<return: #BlElementAlignment>

	^ self layout horizontalAlignment 
]

{ #category : #accessing }
ToLabel >> horizontalAlignment: aBlElementAlignment [

	self horizontalAlignment = aBlElementAlignment ifTrue: [ ^self ].
	self layout horizontalAlignment: aBlElementAlignment.

]

{ #category : #initialization }
ToLabel >> initialize [

	self class initializeSlots: self.
	super initialize.
	self constraintsDo: [ :c | 
		c vertical fitContent.
		c horizontal fitContent ]
]

{ #category : #accessing }
ToLabel >> innerElement [

	^ innerElement
]

{ #category : #accessing }
ToLabel >> lineMode [

	^ self viewModel ifNotNil: [:vm | vm lineMode]
]

{ #category : #accessing }
ToLabel >> lineMode: aLineMode [

	self viewModel lineMode: aLineMode
]

{ #category : #'private-editing' }
ToLabel >> newEditor [

	^ self innerElement newEditor
]

{ #category : #'private-editing' }
ToLabel >> previousClipping [
	^ self userData at: #previousClipping 
]

{ #category : #'private-editing' }
ToLabel >> previousClipping: aBoolean [
	self userData at: #previousClipping put: aBoolean
]

{ #category : #'private-editing' }
ToLabel >> previousElevation [

	^ self userData at: #previousElevation
]

{ #category : #'private-editing' }
ToLabel >> previousElevation: aBlElevation [

	self userData at: #previousElevation put: aBlElevation
]

{ #category : #'private-editing' }
ToLabel >> previousTextElementClipping [
	^ self userData at: #previousTextElementClipping 
]

{ #category : #'private-editing' }
ToLabel >> previousTextElementClipping: aBoolean [
	self userData at: #previousTextElementClipping put: aBoolean
]

{ #category : #'private-editing' }
ToLabel >> previousVisibility [

	^ self userData at: #previousVisibility
]

{ #category : #'private-editing' }
ToLabel >> previousVisibility: aBlVisibility [

	self userData at: #previousVisibility put: aBlVisibility
]

{ #category : #'private-change' }
ToLabel >> privateLineModeChanged: aLineMode [
	| currText |
	currText := self text.
	self removeChildren.
	self privateReplaceTextElement.
	currText ifNotNil: [innerElement text: currText].
	self layout: self defaultLayout.
	self addChild: innerElement
]

{ #category : #'private-change' }
ToLabel >> privateReplaceTextElement [

	innerElement ifNotNil: [ 
		innerElement removeEventHandler: textReplacedHandler ].
	innerElement := self defaultTextElement.
	textReplacedHandler := BlEventHandler
		                       on: ToTextReplacedEvent
		                       do: [ :evt | self text: evt text ].
	innerElement addEventHandler: textReplacedHandler
]

{ #category : #private }
ToLabel >> privateText [
	<return: #BlText>

	^ self innerElement text
]

{ #category : #private }
ToLabel >> privateText: aText [

	self innerElement text: aText
]

{ #category : #'private-editing' }
ToLabel >> removeEditor [

	| editorOverlay |
	self userData at: #editor ifAbsent: [ ^ self ].
	editorOverlay := self editorOverlay.
	editorOverlay detach.
	editorOverlay removeChildren.
	self removeChild: editorOverlay.
	self elevation: self previousElevation.
	self clipChildren: self previousClipping.
	self innerElement clipChildren: self previousTextElementClipping.
	self innerElement visibility: self previousVisibility.
	self userData removeKey: #previousElevation.
	self userData removeKey: #editorOverlay.
	self userData removeKey: #editor.
	self userData removeKey: #previousClipping.
	self userData removeKey: #previousTextElementClipping.

]

{ #category : #accessing }
ToLabel >> text [
	<return: #BlText>

	^ self viewModel text
]

{ #category : #accessing }
ToLabel >> text: aStringOrBlText [

	self viewModel text: aStringOrBlText
]

{ #category : #accessing }
ToLabel >> verticalAlignment [
	<return: #BlElementAlignment>
	
	^ self layout verticalAlignment 
]

{ #category : #accessing }
ToLabel >> verticalAlignment: aBlElementAlignment [

	self verticalAlignment = aBlElementAlignment ifTrue: [ ^self ].
	self layout verticalAlignment: aBlElementAlignment

]
