Class {
	#name : #ToLabel,
	#superclass : #ToBasicWidget,
	#traits : 'TBlAlignable + TOBlLayoutResizable',
	#classTraits : 'TBlAlignable classTrait + TOBlLayoutResizable classTrait',
	#instVars : [
		'textElement'
	],
	#category : #'Toplo-Widgets'
}

{ #category : #'private-label editing' }
ToLabel >> addEditor [

	| editor editorOverlay |
	self userData at: #editorOverlay put: (editorOverlay := BlOverlayElement new).
	editorOverlay
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ];
		clipChildren: false.
	self elevation: (BlRelativeElevation elevation: 1000).
	editorOverlay fitVertically: false.
	editor := self newEditor.
	editorOverlay attachTo: self.
	editorOverlay addChild: editor.
	self previousClipping: self clipChildren.
	self clipChildren: false.
	self addChild: editorOverlay.
	editor editorElement requestFocus
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

	^ BlInsets all: 5 
		  
]

{ #category : #accessing }
ToLabel >> defaultText [
	^ self viewModel defaultText
]

{ #category : #initialization }
ToLabel >> defaultTextElement [

	^ BlAttributedTextElement new
		  editorMeasurement;
		  yourself
]

{ #category : #'private-label editing' }
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

	super initialize.
	textElement := self defaultTextElement.
	self viewModel: self defaulViewModel.	
	self padding: self defaultPaddings.
	self background: self defaultBackground.
	self layout: self defaultLayout.
	self hMatchParent.
	self vFitContent.
	self addChild: textElement
]

{ #category : #'private-label editing' }
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

{ #category : #'private-label editing' }
ToLabel >> previousClipping [
	^ self userData at: #previousClipping 
]

{ #category : #'private-label editing' }
ToLabel >> previousClipping: aBoolean [
	self userData at: #previousClipping put: aBoolean
]

{ #category : #'private-label editing' }
ToLabel >> removeEditor [

	| editorOverlay |
	editorOverlay := self editorOverlay.
	self removeChild: editorOverlay.
	editorOverlay detach.
	editorOverlay removeChildren.
	self userData removeKey: #editorOverlay.
	self clipChildren: self previousClipping.
	self userData removeKey: #previousClipping.

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
ToLabel >> textChanged: aText [

	self textElement text: aText asRopedText
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
