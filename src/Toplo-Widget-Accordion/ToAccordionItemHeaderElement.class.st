Class {
	#name : #ToAccordionItemHeaderElement,
	#superclass : #ToElement,
	#instVars : [
		'isCollapsed',
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

{ #category : #accessing }
ToAccordionItemHeaderElement >> content [ 

	^ content
]

{ #category : #accessing }
ToAccordionItemHeaderElement >> icon: aToImage [

	iconContainer removeChildren.
	iconContainer addChild: aToImage	
]

{ #category : #'as yet unclassified' }
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

{ #category : #accessing }
ToAccordionItemHeaderElement >> isCollapsed [ 
	
	^ isCollapsed 
]

{ #category : #accessing }
ToAccordionItemHeaderElement >> isCollapsed: aBoolean [

	isCollapsed := aBoolean
]

{ #category : #'as yet unclassified' }
ToAccordionItemHeaderElement >> newRawSkin [

	^ ToAccordionItemHeaderElementSkin new
]
