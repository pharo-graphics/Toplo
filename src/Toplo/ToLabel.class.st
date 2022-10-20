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
	editorOverlay
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ];
		clipChildren: false.
	self elevation: (BlRelativeElevation elevation: 1000).
	editorOverlay fitVertically: false.
	editorOverlay attachTo: self.
	editorOverlay addChild: anEditor.
	self previousClipping: self clipChildren.
	self previousVisibility: self textElement visibility.
	self clipChildren: false.
	self textElement visibility: BlVisibility gone.
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

	^ AlbLineFlowLayout new 
]

{ #category : #initialization }
ToLabel >> defaultPaddings [

	^ BlInsets all: 4 
		  
]

{ #category : #accessing }
ToLabel >> defaultText [
	^ self viewModel defaultText
]

{ #category : #initialization }
ToLabel >> defaultTextElement [

	^ self lineMode newTextElement
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
	self padding: self defaultPaddings.
	self background: self defaultBackground.
	self layout: self defaultLayout.
	self hMatchParent.
	self vFitContent.
	textElement := self defaultTextElement.
	self addChild: textElement
]

{ #category : #accessing }
ToLabel >> lineMode [

	^ self viewModel lineMode
]

{ #category : #accessing }
ToLabel >> lineMode: aLineMode [

	self viewModel lineMode: aLineMode
]

{ #category : #'private-editing' }
ToLabel >> newEditor [

	| ed |
	ed := ToAlbum new.
	ed clipChildren: false.
	ed editorElement constraintsDo: [ :c | 
		c vertical fitContent ].
	ed editorElement padding: self padding.
	ed text: self text copy.
	ed matchParent.

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
ToLabel >> previousVisibility [

	^ self userData at: #previousVisibility
]

{ #category : #'private-editing' }
ToLabel >> previousVisibility: aBlVisibility [

	self userData at: #previousVisibility put: aBlVisibility
]

{ #category : #'private-change' }
ToLabel >> privateLineMode: aLineMode [
	| currText |
	currText := self text.
	textElement ifNotNil: [ 	self removeChild: textElement ].
	textElement := self defaultTextElement.
	currText ifNotNil: [textElement text: currText].
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
	self userData removeKey: #editorOverlay.
	self userData removeKey: #editor.
	self clipChildren: self previousClipping.
	self userData removeKey: #previousClipping.
	self textElement visibility: self previousVisibility 

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
