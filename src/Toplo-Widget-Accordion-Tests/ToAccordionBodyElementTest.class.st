"
I check how `ToAccordionBodyElement` builds, shows, hides and discards its content when it receives `switchExpanded` and `switchCollapsed`, with and without preserved content.
"
Class {
	#name : #ToAccordionBodyElementTest,
	#superclass : #TestCase,
	#category : #'Toplo-Widget-Accordion-Tests'
}

{ #category : #helpers }
ToAccordionBodyElementTest >> newBodyWithLabel: aString [

	^ ToAccordionBodyElement new
		  builder: [ :content | content addChild: (ToLabel text: aString) ];
		  yourself
]

{ #category : #tests }
ToAccordionBodyElementTest >> testContentIsEmptyAndHiddenBeforeExpansion [

	| body |
	body := self newBodyWithLabel: 'Body'.
	self assert: body content childrenCount equals: 0.
	self deny: body content visibility isVisible
]

{ #category : #tests }
ToAccordionBodyElementTest >> testNewBuilderIsUsedAtNextExpansion [

	| body |
	body := self newBodyWithLabel: 'First'.
	body switchExpanded.
	body switchCollapsed.
	body builder: [ :content | content addChild: (ToLabel text: 'Second') ].
	body switchExpanded.
	self assert: body content childrenCount equals: 1.
	self assert: body content firstChild text asString equals: 'Second'
]

{ #category : #tests }
ToAccordionBodyElementTest >> testSwitchCollapsedHidesAndKeepsPreservedContent [

	| body label |
	body := self newBodyWithLabel: 'Body'.
	body switchExpanded.
	label := body content firstChild.
	body switchCollapsed.
	self deny: body content visibility isVisible.
	body switchExpanded.
	self assert: body content firstChild identicalTo: label
]

{ #category : #tests }
ToAccordionBodyElementTest >> testSwitchCollapsedRemovesContentWhenNotPreserved [

	| body |
	body := self newBodyWithLabel: 'Body'.
	body preservedContent: false.
	body switchExpanded.
	body switchCollapsed.
	self assert: body content childrenCount equals: 0
]

{ #category : #tests }
ToAccordionBodyElementTest >> testSwitchExpandedBuildsAndShowsContent [

	| body |
	body := self newBodyWithLabel: 'Body'.
	body switchExpanded.
	self assert: body content childrenCount equals: 1.
	self assert: body content visibility isVisible
]
