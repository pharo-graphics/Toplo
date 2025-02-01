Class {
	#name : #ToAccordionItemHeaderElement,
	#superclass : #ToElement,
	#traits : 'TToCheckable',
	#classTraits : 'TToCheckable classTrait',
	#instVars : [
		'iconContainer',
		'content'
	],
	#category : #'Toplo-Widget-Accordion-Core'
}

{ #category : #'as yet unclassified' }
ToAccordionItemHeaderElement class >> exampleWithLabel [

	<script>
	| inst |
	inst := self new.
	inst builder: [ :header | header addChild: (ToLabel text: 'header') ].
	inst openInSpace.
	^ inst
]

{ #category : #accessing }
ToAccordionItemHeaderElement >> builder: aValuable [
	"With an header as argument"
	
	aValuable value: content
]

{ #category : #'t - checkable  - protocol' }
ToAccordionItemHeaderElement >> checkableEventHandlerClass [

	^ ToAccordionItemHeaderEventHandler
]

{ #category : #accessing }
ToAccordionItemHeaderElement >> content [ 

	^ content
]

{ #category : #accessing }
ToAccordionItemHeaderElement >> icon: aToImage [

	iconContainer removeChildren.
	iconContainer addChild: aToImage	
]

{ #category : #initialization }
ToAccordionItemHeaderElement >> initialize [

	super initialize.
	self initializeAsCheckable.

	self layout: BlLinearLayout horizontal.
	self hMatchParent.
	self vFitContent.
	content := ToElement new.
	content layout: BlLinearLayout horizontal.
	content hMatchParent.
	content vFitContent.

	iconContainer := ToElement new.
	iconContainer fitContent.
	self addChild: iconContainer.
	self addChild: content
]

{ #category : #accessing }
ToAccordionItemHeaderElement >> isCollapsed [ 
	
	^ self isExpanded not 
]

{ #category : #accessing }
ToAccordionItemHeaderElement >> isCollapsed: aBoolean [

	self isExpanded: aBoolean not
]

{ #category : #accessing }
ToAccordionItemHeaderElement >> isExpanded [
	
	^ self isChecked 
]

{ #category : #accessing }
ToAccordionItemHeaderElement >> isExpanded: aBoolean [

	self checked: aBoolean
]

{ #category : #initialization }
ToAccordionItemHeaderElement >> newRawSkin [

	^ ToAccordionItemHeaderElementSkin new
]
