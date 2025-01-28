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
	w := ToLabel  new.
	prop := ToSlotProperty new.
	prop name: #currentText.
	self assert: (w class hasSlotNamed: #currentText).
	self assert: prop name equals: #currentText.

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
	w := ToLabel new.
	prop := ToSlotProperty new.
	prop name: #currentText.
	self assert: (w class hasSlotNamed: #currentText).
	self assert: (prop read: w) asString equals: ''.
	self assert: (w readSlotNamed: #currentText) asString equals: ''
]

{ #category : #tests }
ToSlotPropertyTest >> testWrite [

	| w prop |
	w := ToLabel new text: 'test'.
	prop := ToSlotProperty new.
	prop name: #currentText.
	self assert: (w class hasSlotNamed: #currentText).
	self assert: (prop read: w) asString equals: 'test'.
	prop write: 'TEST' to: w.
	self assert: (prop read: w) asString equals: 'TEST'
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
