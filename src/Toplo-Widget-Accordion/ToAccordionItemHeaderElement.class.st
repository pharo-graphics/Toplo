Class {
	#name : #ToAccordionItemHeaderElement,
	#superclass : #ToElement,
	#traits : 'TToClickable',
	#classTraits : 'TToClickable classTrait',
	#instVars : [
		'builder',
		'clickHandler',
		'clickEventClass',
		'isCollapsed',
		'iconContainer',
		'content'
	],
	#category : #'Toplo-Widget-Accordion-Core'
}

{ #category : #examples }
ToAccordionItemHeaderElement class >> exampleWithLabel [

	<script>
	| inst |
	inst := self new.
	inst builder: [ :header | header addChild: (ToLabel text: 'header') ].
	inst openInSpace.
	^ inst
]

{ #category : #'as yet unclassified' }
ToAccordionItemHeaderElement >> builder: aValuable [
	"With an header as argument"
	
	aValuable value: content
]

{ #category : #'as yet unclassified' }
ToAccordionItemHeaderElement >> clickHandler [

	^ clickHandler 
]

{ #category : #'as yet unclassified' }
ToAccordionItemHeaderElement >> clickHandler: anHandler [

	clickHandler := anHandler
]

{ #category : #accessing }
ToAccordionItemHeaderElement >> content [ 

	^ content
]

{ #category : #'as yet unclassified' }
ToAccordionItemHeaderElement >> icon: aToImage [

	iconContainer removeChildren.
	iconContainer addChild: aToImage	
]

{ #category : #initialization }
ToAccordionItemHeaderElement >> initialize [

	super initialize.
	isCollapsed := true.
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

{ #category : #'as yet unclassified' }
ToAccordionItemHeaderElement >> isCollapsed [ 
	
	^ isCollapsed 
]

{ #category : #'as yet unclassified' }
ToAccordionItemHeaderElement >> isCollapsed: aBoolean [

	isCollapsed := aBoolean
]

{ #category : #skin }
ToAccordionItemHeaderElement >> newRawSkin [

	^ ToAccordionItemHeaderElementSkin new
]

{ #category : #'as yet unclassified' }
ToAccordionItemHeaderElement >> rawClickEventClass [

	^ clickEventClass
]

{ #category : #'as yet unclassified' }
ToAccordionItemHeaderElement >> rawClickEventClass: aClass [

	clickEventClass := aClass
]
