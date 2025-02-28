Class {
	#name : #ToAccordionHeaderElement,
	#superclass : #ToElement,
	#instVars : [
		'iconContainer',
		'content',
		'expandIconAtStart',
		'triplet',
		'extraContainer'
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

	content removeChildren.
	aValuable value: content
]

{ #category : #accessing }
ToAccordionHeaderElement >> content [ 

	^ content
]

{ #category : #accessing }
ToAccordionHeaderElement >> expandIconAtStart: aBoolean [

	expandIconAtStart = aBoolean ifTrue: [ ^ self ].
	expandIconAtStart := aBoolean.
	expandIconAtStart
		ifTrue: [
			triplet startElement: iconContainer.
			triplet endElement: extraContainer ]
		ifFalse: [
			| end |
			triplet startElement: nil.
			triplet endElement: nil.
			end := ToElement new
				       fitContent;
				       layout: BlLinearLayout horizontal;
				       yourself.
			end addChild: extraContainer.
			end addChild: iconContainer.
			end layout cellSpacing: 5.
			triplet endElement: end ]
]

{ #category : #accessing }
ToAccordionHeaderElement >> headerExtraBuilder: aValuable [

	
	aValuable value: extraContainer
]

{ #category : #accessing }
ToAccordionHeaderElement >> icon: aToImage [

	iconContainer removeChildren.
	iconContainer addChild: aToImage	
]

{ #category : #initialization }
ToAccordionHeaderElement >> initialize [

	super initialize.
	self applySkinInstallerOnFirstRequest: false.
	self layout: BlLinearLayout horizontal.
	self hMatchParent.
	self vFitContent.
	triplet := ToTripletElement new
		           hMatchParent;
		           vFitContent;
		           yourself.
	content := ToElement new.
	content layout: BlLinearLayout horizontal.
	content fitContent.
	triplet middleElement: content.
	triplet startFlexible: false.
	triplet endFlexible: true.

	iconContainer := ToElement new.
	iconContainer fitContent.
	iconContainer constraintsDo: [ :c | c linear vertical alignCenter ].
	extraContainer := ToElement new.
	extraContainer fitContent.
	extraContainer constraintsDo: [ :c | c linear vertical alignCenter ].
	self constraintsDo: [ :c | c linear vertical alignCenter ].
	self addChild: triplet.
	self expandIconAtStart: true
]

{ #category : #testing }
ToAccordionHeaderElement >> isExpanded [

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToAccordionHeaderElement >> newRawSkin [

	^ ToAccordionHeaderElementSkin new
]
