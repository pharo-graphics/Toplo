Class {
	#name : #ToAccordionHeaderElement,
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
ToAccordionHeaderElement class >> exampleWithLabel [

	<script>
	| inst |
	inst := self new.
	inst builder: [ :header | header addChild: (ToLabel text: 'header') ].
	inst openInSpace.
	^ inst
]

{ #category : #'as yet unclassified' }
ToAccordionHeaderElement >> builder: aValuable [
	"With an header as argument"
	
	aValuable value: content
]

{ #category : #'as yet unclassified' }
ToAccordionHeaderElement >> clickHandler [

	^ clickHandler 
]

{ #category : #'as yet unclassified' }
ToAccordionHeaderElement >> clickHandler: anHandler [

	clickHandler := anHandler
]

{ #category : #accessing }
ToAccordionHeaderElement >> content [ 

	^ content
]

{ #category : #'as yet unclassified' }
ToAccordionHeaderElement >> icon: aToImage [

	iconContainer removeChildren.
	iconContainer addChild: aToImage	
]

{ #category : #initialization }
ToAccordionHeaderElement >> initialize [

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
ToAccordionHeaderElement >> isCollapsed [ 
	
	^ isCollapsed 
]

{ #category : #'as yet unclassified' }
ToAccordionHeaderElement >> isCollapsed: aBoolean [

	isCollapsed := aBoolean
]

{ #category : #skin }
ToAccordionHeaderElement >> newRawSkin [

	^ ToAccordionHeaderElementSkin new
]

{ #category : #'as yet unclassified' }
ToAccordionHeaderElement >> rawClickEventClass [

	^ clickEventClass
]

{ #category : #'as yet unclassified' }
ToAccordionHeaderElement >> rawClickEventClass: aClass [

	clickEventClass := aClass
]
