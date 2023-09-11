"
A ToPropertyDefinitionTest is a test class for testing the behavior of ToPropertyDefinition
"
Class {
	#name : #ToPropertyDefinitionTest,
	#superclass : #TestCase,
	#instVars : [
		'reader'
	],
	#category : #'Toplo-Theme-Tests-Look'
}

{ #category : #tests }
ToPropertyDefinitionTest >> testExplicitPropertyDefinition [

	| w prop  writer |
	w := ToElement new.
	prop := ToExplicitPropertyDefinition new.
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
ToPropertyDefinitionTest >> testInstVarPropertyDefinition [

	| w prop |
	w := ToElement new.
	prop := ToInstVarPropertyDefinition new.
	prop name: #background.
	self assert: prop name equals: #background.
	prop write: Color blue to: w.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color blue.
	self assert: (prop read: w) equals: w background
]

{ #category : #tests }
ToPropertyDefinitionTest >> testSlotPropertyDefinition [

	| w prop first |
	w := ToCheckLookTestElement new.
	prop := ToSlotPropertyDefinition new.
	prop name: #first.
	self assert: prop name equals: #first.
	first := BlElement new.
	prop write: first to: w.
	self assert: w first equals: first.
	self assert: (prop read: w) equals: first
]
