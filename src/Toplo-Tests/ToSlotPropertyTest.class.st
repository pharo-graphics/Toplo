"
A ToSlotPropertyTest is a test class for testing the behavior of ToSlotProperty
"
Class {
	#name : #ToSlotPropertyTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Core-Properties'
}

{ #category : #tests }
ToSlotPropertyTest >> testName [

	| w prop |
	w := ToLabeledIcon  new.
	prop := ToSlotProperty new.
	prop name: #middleElement.
	self assert: (w class hasSlotNamed: #middleElement).
	self assert: prop name equals: #middleElement.

]

{ #category : #tests }
ToSlotPropertyTest >> testNew [

	| w prop |
	w := Object new.
	prop := ToSlotProperty new.
	self should: [ prop read: w ] raise: Error
]

{ #category : #tests }
ToSlotPropertyTest >> testRead [

	| w prop |
	w := ToLabeledIcon  new.
	prop := ToSlotProperty new.
	prop name: #middleElement.
	self assert: (w class hasSlotNamed: #middleElement).
	self assert: (prop read: w) equals: w label.
	self assert: (w readSlotNamed: #middleElement) equals: w label
]

{ #category : #tests }
ToSlotPropertyTest >> testWrite [

	| w prop |
	w := ToLabeledIcon  new.
	prop := ToSlotProperty new.
	prop name: #middleElement.
	self assert: (w class hasSlotNamed: #middleElement).
	self assert: (prop read: w) equals: w label.
	prop write: (ToLabel text: 'Hello') to: w.
	self assert: (prop read: w) text asString equals: 'Hello'
]

{ #category : #tests }
ToSlotPropertyTest >> testWrongDefinition [

	| w prop |
	w := ToLabeledIcon new.
	prop := ToSlotProperty new.
	prop name: #label2.
	self deny: (w class hasSlotNamed: #label2).
	self should: [ prop read: w ] raise: SlotNotFound
]
