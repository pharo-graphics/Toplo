Class {
	#name : #ToAccordionHeaderElement,
	#superclass : #ToElement,
	#instVars : [
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

{ #category : #accessing }
ToAccordionHeaderElement >> builder: aValuable [
	"With an header as argument"
	
	aValuable value: content
]

{ #category : #accessing }
ToAccordionHeaderElement >> content [ 

	^ content
]

{ #category : #accessing }
ToAccordionHeaderElement >> icon: aToImage [

	iconContainer removeChildren.
	iconContainer addChild: aToImage	
]

{ #category : #initialization }
ToAccordionHeaderElement >> initialize [

	super initialize. 
	self layout: BlLinearLayout horizontal.
	self hMatchParent.
	self vFitContent.
	content := ToElement new.
	content layout: BlLinearLayout horizontal.
	content hMatchParent.
	content vFitContent.

	iconContainer := ToElement new.
	iconContainer fitContent.
	iconContainer constraintsDo: [ :c | c linear vertical alignCenter ].
	self constraintsDo: [ :c | c linear vertical alignCenter ].
	self addChild: iconContainer.
	self addChild: content
]

{ #category : #testing }
ToAccordionHeaderElement >> isExpanded [

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToAccordionHeaderElement >> newRawSkin [

	^ ToAccordionHeaderElementSkin new
]
