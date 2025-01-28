Class {
	#name : #ToAccordionElement,
	#superclass : #ToElement,
	#instVars : [
		'header',
		'body',
		'headerBuilder',
		'bodyBuilder'
	],
	#category : #'Toplo-Widget-Accordion-Core'
}

{ #category : #examples }
ToAccordionElement class >> exampleWithLabel [

	<script>
	| inst |
	inst := self new.
	inst headerBuilder: [ :header |
		header addChild: (ToLabel text: 'Header') ].
	inst bodyBuilder: [ :body |
		body addChild:
			(ToLabel new text: 'Body with random background color').
		body
			hMatchParent;
			height: 100;
			background: Color random ].
	inst openInSpace.
	^ inst
]

{ #category : #'as yet unclassified' }
ToAccordionElement class >> exampleWithLabelAndAlbumInBody [

	<script>
	| inst |
	inst := self new.
	inst headerBuilder: [ :header |
		header addChild: (ToLabel text: 'Header') ].
	inst bodyBuilder: [ :body |
		| album |
		album := ToAlbum new
			         withSaveCapability;
			         whenSaveRequestedDo: [ :saveRequested |
				         saveRequested accepted: true ];
			         whenCancelRequestedDo: [ :cancelRequested |
				         cancelRequested editorElement text: '' ];
			         yourself.
		album hMatchParent.
		album vFitContent.
		album next vFitContent.
		album infinite vFitContent.
		album text: 'AAAAAAAA'.
		body addChild: album ].
	inst openInSpace.
	^ inst
]

{ #category : #accessing }
ToAccordionElement >> bodyBuilder: aValuable [
	"With a body as argument"
	
	bodyBuilder := aValuable
]

{ #category : #'expanding-collapsing' }
ToAccordionElement >> collapse [

	body removeChildren.
	body removeFromParent
]

{ #category : #'expanding-collapsing' }
ToAccordionElement >> expand [

	bodyBuilder ifNil: [ ^ self ].
	bodyBuilder value: body.
	self addChild: body
]

{ #category : #accessing }
ToAccordionElement >> headerBuilder: aValuable [
	"With an header as argument"
	
	header builder: aValuable
]

{ #category : #initialization }
ToAccordionElement >> initialize [

	super initialize.
	self layout: BlLinearLayout vertical.
	self hMatchParent.
	self vFitContent.
	self initializeHeader.
	self initializeClick.
	self initializeBody.

]

{ #category : #initialization }
ToAccordionElement >> initializeBody [

	body := ToElement new
		        constraintsDo: [ :c |
			        c vertical fitContent.
			        c horizontal matchParent ];
		        border: (BlBorder paint: Color veryLightGray width: 1);
		        yourself
]

{ #category : #initialization }
ToAccordionElement >> initializeClick [

	header whenClickedDo: [ :e |
		e consume.
		header isCollapsed: header isCollapsed not.
		header isCollapsed
			ifFalse: [ self expand ]
			ifTrue: [ self collapse ] ]
]

{ #category : #initialization }
ToAccordionElement >> initializeHeader [

	header := ToAccordionHeaderElement new.
	self addChild: header
]

{ #category : #testing }
ToAccordionElement >> isCollapsed [ 
	
	^ header isCollapsed 
]

{ #category : #accessing }
ToAccordionElement >> isCollapsed: aBoolean [
	
	header isCollapsed: aBoolean
]

{ #category : #skin }
ToAccordionElement >> newRawSkin [

	^ ToAccordionElementSkin new
]
