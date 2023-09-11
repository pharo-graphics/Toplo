"
A ToPropertyDefinitionTest is a test class for testing the behavior of ToPropertyDefinition
"
Class {
	#name : #ToPropertyDefinitionTest,
	#superclass : #TestCase,
	#category : #'Toplo-Theme-Tests-Look'
}

{ #category : #tests }
ToPropertyDefinitionTest >> testBackgroundProperty [

	| w prop  valuable |
	w := ToElement new.
	prop := ToPropertyDefinition new.
	valuable := [ :e :v | e background: v ].
	prop writer: valuable.
	prop name: #background.
	self assert: prop writer equals: valuable.
	self assert: prop name equals: #background.
	prop write: Color blue to: w.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color blue
]
