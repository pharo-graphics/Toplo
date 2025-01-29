Class {
	#name : #ToAccordionItemBodyElement,
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
ToAccordionItemBodyElement >> builder: aValuable [
	"With content as argument"

	isBuilt := false.
	builder := aValuable 
]

{ #category : #accessing }
ToAccordionItemBodyElement >> content [ 

	^ content
]

{ #category : #initialization }
ToAccordionItemBodyElement >> initialize [ 

	super initialize.
	isBuilt := false.
	preservedContent := true.
	self initializeContent
]

{ #category : #initialization }
ToAccordionItemBodyElement >> initializeContent [

	content := ToElement new
		           withNullSkin;
		           background: BlBackground transparent;
		           layout: BlLinearLayout vertical;
		           constraintsDo: [ :c |
			           c vertical fitContent.
			           c horizontal matchParent ];
		           yourself.
	self addChild: content
]

{ #category : #accessing }
ToAccordionItemBodyElement >> preservedContent: aBoolean [

	preservedContent := aBoolean
]

{ #category : #'expanding-collapsing' }
ToAccordionItemBodyElement >> switchCollapsed [

	preservedContent ifFalse: [ content removeChildren ].
	content visibility: BlVisibility gone
]

{ #category : #'expanding-collapsing' }
ToAccordionItemBodyElement >> switchExpanded [

	(isBuilt and: [ preservedContent ]) ifFalse: [
		content removeChildren.
		builder ifNotNil: [ builder value: content ].
		isBuilt := true ].
	content visibility: BlVisibility visible
]
