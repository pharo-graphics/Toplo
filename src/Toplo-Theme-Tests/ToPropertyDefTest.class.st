"
A ToPropertyDefinitionTest is a test class for testing the behavior of ToPropertyDefinition
"
Class {
	#name : #ToPropertyDefTest,
	#superclass : #TestCase,
	#instVars : [
		'reader'
	],
	#category : #'Toplo-Theme-Tests-LookUpdater'
}

{ #category : #tests }
ToPropertyDefTest >> testExplicitPropertyDefinition [

	| w prop  writer |
	w := ToElement new.
	prop := ToExplicitPropertyDef new.
	writer := [ :e :v | e background: v ].
	reader := [ :e | e background ].
	prop writer: writer.
	prop reader: reader.
	prop name: #background.
	self assert: prop writer equals: writer.
	self assert: prop reader equals: reader.
	self assert: prop name equals: #background.
	prop write: Color blue to: w.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color blue.
	self assert: (prop read: w) equals: w background
]

{ #category : #tests }
ToPropertyDefTest >> testInstVarPropertyDefinition [

	| w prop |
	w := ToElement new.
	prop := ToInstVarPropertyDef new.
	prop name: #background.
	self assert: prop name equals: #background.
	prop write: Color blue to: w.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color blue.
	self assert: (prop read: w) equals: w background
]

{ #category : #tests }
ToPropertyDefTest >> testInstVarPropertyDefinition2 [

	| w prop |
	w := ToElement new.
	prop := #background asInstVarPropertyDef.
	self assert: prop name equals: #background.
	prop write: Color blue to: w.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color blue.
	self assert: (prop read: w) equals: w background
]

{ #category : #tests }
ToPropertyDefTest >> testSlotPropertyDefinition [

	| w prop first |
	w := ToCheckLookTestElement new.
	prop := ToSlotPropertyDef new.
	prop name: #first.
	self assert: prop name equals: #first.
	first := BlElement new.
	prop write: first to: w.
	self assert: w first equals: first.
	self assert: (prop read: w) equals: first
]

{ #category : #tests }
ToPropertyDefTest >> testSlotPropertyDefinition2 [

	| w prop first |
	w := ToCheckLookTestElement new.
	prop := #first asSlotPropertyDef.
	self assert: prop name equals: #first.
	first := BlElement new.
	prop write: first to: w.
	self assert: w first equals: first.
	self assert: (prop read: w) equals: first
]
