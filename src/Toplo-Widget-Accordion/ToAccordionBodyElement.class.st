Class {
	#name : #ToAccordionBodyElement,
	#superclass : #ToElement,
	#instVars : [
		'builder',
		'content',
		'preservedContent',
		'isBuilt'
	],
	#category : #'Toplo-Widget-Accordion-Core'
}

{ #category : #accessing }
ToAccordionBodyElement >> builder: aValuable [
	"With content as argument"

	isBuilt := false.
	builder := aValuable 
]

{ #category : #accessing }
ToAccordionBodyElement >> content [ 

	^ content
]

{ #category : #initialization }
ToAccordionBodyElement >> defaultLayout [ 

	^ BlLinearLayout vertical
]

{ #category : #initialization }
ToAccordionBodyElement >> initialize [ 

	super initialize.
	isBuilt := false.
	preservedContent := true.
	self initializeContent
]

{ #category : #initialization }
ToAccordionBodyElement >> initializeContent [

	content := ToElement new
		           withNullSkin;
		           background: BlBackground transparent;
		           layout: BlLinearLayout vertical;
		           constraintsDo: [ :c |
			           c vertical fitContent.
			           c horizontal matchParent.
			           c linear vertical alignCenter ];
		           yourself.
	content visibility: BlVisibility gone.
	self addChild: content.
]

{ #category : #'instance creation' }
ToAccordionBodyElement >> newRawSkin [ 

	^ ToAccordionBodyElementSkin new
]

{ #category : #accessing }
ToAccordionBodyElement >> preservedContent: aBoolean [

	preservedContent := aBoolean
]

{ #category : #'expanding-collapsing' }
ToAccordionBodyElement >> switchCollapsed [

	preservedContent ifFalse: [ content removeChildren ].
	content visibility: BlVisibility gone
]

{ #category : #'expanding-collapsing' }
ToAccordionBodyElement >> switchExpanded [

	(isBuilt and: [ preservedContent ]) ifFalse: [
		content removeChildren.
		builder ifNotNil: [ builder value: content ].
		isBuilt := true ].
	content visibility: BlVisibility visible
]
