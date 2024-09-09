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
	prop name: #props.
	self assert: (w class hasSlotNamed: #props).
	self assert: prop name equals: #props.

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
	w := ToLabeledIcon new.
	prop := ToSlotProperty new.
	prop name: #props.
	self assert: (w class hasSlotNamed: #props).
	self assert: (prop read: w) equals: w properties.
	self assert: (w readSlotNamed: #props) equals: w props
]

{ #category : #tests }
ToSlotPropertyTest >> testWrite [

	| w prop |
	w := ToLabel new.
	prop := ToSlotProperty new.
	prop name: #isEditable.
	self assert: (w class hasSlotNamed: #isEditable).
	self assert: (prop read: w) equals: w isEditable.
	prop write: true to: w.
	self assert: (prop read: w) equals: true.
	prop write: false to: w.
	self assert: (prop read: w) equals: false
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
