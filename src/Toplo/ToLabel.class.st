Class {
	#name : #ToLabel,
	#superclass : #ToBasicWidget,
	#traits : 'TBlAlignable + TOBlLayoutResizable',
	#classTraits : 'TBlAlignable classTrait + TOBlLayoutResizable classTrait',
	#instVars : [
		'textElement'
	],
	#category : #'Toplo-Widget-Label'
}

{ #category : #'private-editing' }
ToLabel >> addEditor [

	self lineMode addEditorIn: self
]

{ #category : #'private-editing' }
ToLabel >> addEditor: anEditor [

	| editorOverlay |
	self userData at: #editorOverlay ifPresent: [ ^ self ].
	self userData at: #editorOverlay put: (editorOverlay := BlOverlayElement new).
	self userData at: #editor put: anEditor.
	editorOverlay clipChildren: false.
	self previousElevation: self elevation.
	self elevation: (BlRelativeElevation elevation: 1000).
	editorOverlay attachTo: self textElement.
	editorOverlay addChild: anEditor.
	anEditor border: BlBorder empty.
	self previousClipping: self clipChildren.
	self previousVisibility: self textElement visibility.
	self previousTextElementClipping: self textElement clipChildren.
	self textElement visibility: BlVisibility hidden.
	self textElement clipChildren: false.
	self clipChildren: false.
	self addChild: editorOverlay.
	anEditor editorElement requestFocus
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
ToLabel >> defaulViewModel [

	^ ToLabelModel new.

]

{ #category : #initialization }
ToLabel >> defaultLayout [

	^ self lineMode ifNil: [ super defaultLayout ] ifNotNil: [ :lm | lm defaultLayout ]
]

{ #category : #initialization }
ToLabel >> defaultMargins [

	^ BlInsets all: 0
		  
]

{ #category : #initialization }
ToLabel >> defaultPaddings [

	^ BlInsets all: 3 
		  
]

{ #category : #accessing }
ToLabel >> defaultText [
	^ self viewModel defaultText
]

{ #category : #initialization }
ToLabel >> defaultTextElement [

	^ self lineMode newTextElement
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
ToLabel >> editorOverlay [

	^ self userData at: #editorOverlay 
]

{ #category : #accessing }
ToLabel >> horizontalAlignment [
	<return: #BlElementAlignment>

	^ self textElement constraints frame horizontal alignment
]

{ #category : #accessing }
ToLabel >> horizontalAlignment: aBlElementAlignment [
	self horizontalAlignment = aBlElementAlignment ifTrue: [ ^self ].
	self textElement constraintsDo: [ :c | c frame horizontal alignment: aBlElementAlignment].

]

{ #category : #initialization }
ToLabel >> initialize [
	
	self class initializeSlots: self.
	super initialize.
	
	self viewModel: self defaulViewModel.
	self layout: self defaultLayout.
	self padding: self defaultPaddings.
	self margin: self defaultMargins.
	self background: self defaultBackground.
	self hMatchParent.
	self vFitContent.
	textElement := self defaultTextElement.
	self addChild: textElement
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

	| ed |
	ed := ToAlbum new.
	"remove padding to ensure that the editor is exactly at the right position according to the label text"
	ed editorElement padding: BlInsets empty.
	"draw the border outside"
	ed editorElement outskirts: BlOutskirts outside.
	" do not clip children otherwise the editor may be invisible"
	ed clipChildren: false.
	ed text: self text copy.
	ed fitContent.
	^ ed
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
	textElement ifNotNil: [ 	self removeChild: textElement ].
	textElement := self defaultTextElement.
	currText ifNotNil: [textElement text: currText].
	self layout: self defaultLayout.
	self addChild: textElement
]

{ #category : #accessing }
ToLabel >> privateText [
	<return: #BlText>

	^ self textElement text
]

{ #category : #accessing }
ToLabel >> privateText: aText [

	self textElement text: aText
]

{ #category : #'private-editing' }
ToLabel >> removeEditor [

	| editorOverlay |
	self userData at: #editor ifAbsent: [ ^ self ].
	editorOverlay := self editorOverlay.
	self removeChild: editorOverlay.
	editorOverlay detach.
	editorOverlay removeChildren.
	self elevation: self previousElevation.
	self clipChildren: self previousClipping.
	self textElement clipChildren: self previousTextElementClipping.
	self textElement visibility: self previousVisibility.
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
ToLabel >> textElement [

	^ textElement
]

{ #category : #accessing }
ToLabel >> verticalAlignment [
	<return: #BlElementAlignment>
	
	^ self textElement constraints frame vertical alignment
]

{ #category : #accessing }
ToLabel >> verticalAlignment: aBlElementAlignment [
	self verticalAlignment = aBlElementAlignment ifTrue: [ ^self ].
	self textElement constraintsDo: [ :c | c frame vertical alignment: aBlElementAlignment].

]
