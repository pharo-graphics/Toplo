"
I check that `ToAccordionHeaderElement` fills its content as soon as it receives a builder, and that it has no icon until its skin gives it one.
"
Class {
	#name : #ToAccordionHeaderElementTest,
	#superclass : #TestCase,
	#category : #'Toplo-Widget-Accordion-Tests'
}

{ #category : #tests }
ToAccordionHeaderElementTest >> testBuilderFillsContentImmediately [

	| header |
	header := ToAccordionHeaderElement new.
	header builder: [ :content | content addChild: (ToLabel text: 'Header') ].
	self assert: header content childrenCount equals: 1
]

{ #category : #tests }
ToAccordionHeaderElementTest >> testBuilderReplacesPreviousContent [

	| header |
	header := ToAccordionHeaderElement new.
	header builder: [ :content | content addChild: (ToLabel text: 'First') ].
	header builder: [ :content | content addChild: (ToLabel text: 'Second') ].
	self assert: header content childrenCount equals: 1.
	self assert: header content firstChild text asString equals: 'Second'
]

{ #category : #'tests - errors' }
ToAccordionHeaderElementTest >> testIconBeforeSkinInstallationRaisesError [

	self should: [ ToAccordionHeaderElement new icon ] raise: Error
]
