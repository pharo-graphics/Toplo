Class {
	#name : #ToAccordionItemElement,
	#superclass : #ToElement,
	#traits : 'TToItem',
	#classTraits : 'TToItem classTrait',
	#instVars : [
		'header',
		'body'
	],
	#category : #'Toplo-Widget-Accordion-Core'
}

{ #category : #examples }
ToAccordionItemElement class >> exampleSeveralInCheckableGroup [

	<script>
	| pane group |
	pane := ToPane new.
	pane layout: BlLinearLayout vertical.
	pane hMatchParent.
	group := ToCheckableGroup new.
	pane vFitContent.
	(1 to: 5) collect: [ :i |
		pane addChild: ((self itemWithLabelText: 'Header ' , i asString) isExpanded: false)].
	group registerAll: pane children.
	pane openInSpace.
	^ pane
]

{ #category : #examples }
ToAccordionItemElement class >> exampleSeveralInPaneWithLabel [

	<script>
	| pane |
	pane := ToPane new.
	pane layout: BlLinearLayout vertical.
	pane hMatchParent.
	pane vFitContent.
	(1 to: 5) collect: [ :i |
		pane addChild: ((self itemWithLabelText: 'Header ' , i asString) isExpanded: false)].
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
ToAccordionItemElement class >> exampleWithLabelChecked [

	<script>
	| inst |
	inst := self itemWithLabel.
	inst checked: true.
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
	inst
		vFitContent;
		hMatchParent.
	^ inst
]

{ #category : #accessing }
ToAccordionItemElement >> bodyBuilder: aValuable [
	"With a body content as argument"
	
	body builder: aValuable
]

{ #category : #accessing }
ToAccordionItemElement >> checked: aBoolean [

	header checked: aBoolean
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
ToAccordionItemElement >> group: aCheckableGroup [

	header group: aCheckableGroup
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
	header addEventHandlerOn: ToCheckableCheckEvent do: [ :event |
		self isExpanded
			ifTrue: [ self expand ]
			ifFalse: [ self collapse ] ]
]

{ #category : #initialization }
ToAccordionItemElement >> initializeBody [

	body := ToAccordionItemBodyElement new.
	body hMatchParent.
	body vFitContent.
	self addChild: body
]

{ #category : #initialization }
ToAccordionItemElement >> initializeHeader [

	header := ToAccordionItemHeaderElement new.
	self addChild: header
]

{ #category : #testing }
ToAccordionItemElement >> isChecked [ 
	
	^ header isChecked
]

{ #category : #testing }
ToAccordionItemElement >> isCollapsed [ 
	
	^ header isCollapsed
]

{ #category : #accessing }
ToAccordionItemElement >> isCollapsed: aBoolean [

	header isCollapsed: aBoolean
]

{ #category : #testing }
ToAccordionItemElement >> isExpanded [
	
	^ self isCollapsed not
]

{ #category : #accessing }
ToAccordionItemElement >> isExpanded: aBoolean [
	
	header isExpanded: aBoolean
]

{ #category : #'t - item' }
ToAccordionItemElement >> itemConstraintsClass [

	^ ToAccordionConstraints 
]

{ #category : #skin }
ToAccordionItemElement >> newRawSkin [

	^ ToAccordionItemElementSkin new
]

{ #category : #accessing }
ToAccordionItemElement >> preserveBody: aBoolean [

	body preservedContent: aBoolean
]

{ #category : #'checking protocol' }
ToAccordionItemElement >> privateChecked: aBoolean [

	header privateChecked: aBoolean
]

{ #category : #'t - checkable - group' }
ToAccordionItemElement >> registerInGroup: aGroup [

	header registerInGroup: aGroup
]

{ #category : #'t - checkable - group' }
ToAccordionItemElement >> unregisterFromGroup [

	header unregisterFromGroup
]
