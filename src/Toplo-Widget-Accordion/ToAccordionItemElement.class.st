Class {
	#name : #ToAccordionItemElement,
	#superclass : #ToElement,
	#instVars : [
		'header',
		'body'
	],
	#category : #'Toplo-Widget-Accordion-Core'
}

{ #category : #examples }
ToAccordionItemElement class >> exampleSeveralInPaneWithLabel [

	<script>
	| pane |
	pane := ToPane new.
	pane layout: BlLinearLayout vertical.
	pane hMatchParent.
	pane vFitContent.
	(1 to: 5) collect: [ :i |
		pane addChild: ((self itemWithLabelText: 'Header ' , i asString) isExpanded: true)].
	pane openInSpace.
	^ pane
]

{ #category : #examples }
ToAccordionItemElement class >> exampleWithLabel [

	<script>
	| inst |
	inst := self itemWithLabel.
	inst openInSpace.
	^ inst
]

{ #category : #examples }
ToAccordionItemElement class >> exampleWithLabelAndAlbumInBody [

	<script>
	| inst |
	inst := self itemWithLabelAndAlbumInBody.
	inst openInSpace.
	^ inst
]

{ #category : #examples }
ToAccordionItemElement class >> exampleWithLabelExpanded [

	<script>
	| inst |
	inst := self itemWithLabel.
	inst isExpanded: true.
	inst openInSpace.
	^ inst
]

{ #category : #examples }
ToAccordionItemElement class >> exampleWithLabelNotPreservingBody [

	<script>
	| inst |
	inst := self itemWithLabel.
	inst preserveBody: false.
	inst openInSpace.
	^ inst
]

{ #category : #examples }
ToAccordionItemElement class >> exampleWithLabelNotPreservingBodyAndExpanded [

	<script>
	| inst |
	inst := self itemWithLabel.
	inst preserveBody: false.
	inst isExpanded: true.
	inst openInSpace.
	^ inst
]

{ #category : #examples }
ToAccordionItemElement class >> itemWithLabel [

	^ self itemWithLabelText: 'Header'
]

{ #category : #examples }
ToAccordionItemElement class >> itemWithLabelAndAlbumInBody [

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
		album next constraintsDo: [ :c |
			c vertical fitContent.
			c horizontal matchParent ].
		album infinite constraintsDo: [ :c |
			c vertical fitContent.
			c horizontal matchParent ].
		album minHeight: 50.
		album text: 'AAAAAAAA'.
		body addChild: album ].
	^ inst
]

{ #category : #examples }
ToAccordionItemElement class >> itemWithLabelText: aString [

	| inst |
	inst := self new.
	inst headerBuilder: [ :header |
		header addChild: (ToLabel text: aString) ].
	inst bodyBuilder: [ :body |
		body addChild:
			(ToLabel new text: 'Body with random background color').
		body
			hMatchParent;
			height: 100;
			background: Color random ].
	inst vFitContent; hMatchParent.
	^ inst
]

{ #category : #accessing }
ToAccordionItemElement >> bodyBuilder: aValuable [
	"With a body content as argument"
	
	body builder: aValuable
]

{ #category : #'expanding-collapsing' }
ToAccordionItemElement >> collapse [

	body switchCollapsed
]

{ #category : #'expanding-collapsing' }
ToAccordionItemElement >> expand [

	body switchExpanded 

]

{ #category : #accessing }
ToAccordionItemElement >> headerBuilder: aValuable [
	"With an header as argument"
	
	header builder: aValuable
]

{ #category : #initialization }
ToAccordionItemElement >> initialize [

	super initialize.
	self layout: BlLinearLayout vertical.
	self hMatchParent.
	self vFitContent.
	self initializeHeader.
	self initializeBody.
	self initializeClick
]

{ #category : #initialization }
ToAccordionItemElement >> initializeBody [

	body := ToAccordionItemBodyElement new.
	body hMatchParent.
	body vFitContent.
	self addChild: body
]

{ #category : #initialization }
ToAccordionItemElement >> initializeClick [

	header whenClickedDo: [ :e |
		"e consume."
		header isCollapsed: header isCollapsed not.
		header isCollapsed
			ifFalse: [ self expand ]
			ifTrue: [ self collapse ] ]
]

{ #category : #initialization }
ToAccordionItemElement >> initializeHeader [

	header := ToAccordionItemHeaderElement new.
	self addChild: header
]

{ #category : #testing }
ToAccordionItemElement >> isCollapsed [ 
	
	^ header isCollapsed 
]

{ #category : #accessing }
ToAccordionItemElement >> isCollapsed: aBoolean [
	
	header isCollapsed: aBoolean
]

{ #category : #accessing }
ToAccordionItemElement >> isExpanded [
	
	^ self isCollapsed not
]

{ #category : #accessing }
ToAccordionItemElement >> isExpanded: aBoolean [
	
	self isCollapsed: aBoolean not
]

{ #category : #skin }
ToAccordionItemElement >> newRawSkin [

	^ ToAccordionItemElementSkin new
]

{ #category : #'hooks - children' }
ToAccordionItemElement >> onAddedToSceneGraph [

	self isCollapsed ifFalse: [ self expand ].
	super onAddedToSceneGraph
]

{ #category : #accessing }
ToAccordionItemElement >> preserveBody: aBoolean [

	body preservedContent: aBoolean
]
