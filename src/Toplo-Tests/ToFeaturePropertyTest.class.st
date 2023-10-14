"
A ToFeaturePropertyTest is a test class for testing the behavior of ToFeatureProperty
"
Class {
	#name : 'ToFeaturePropertyTest',
	#superclass : 'TestCase',
	#category : 'Toplo-Tests-Core-Properties',
	#package : 'Toplo-Tests',
	#tag : 'Core-Properties'
}

{ #category : 'tests' }
ToFeaturePropertyTest >> testName [

	| prop |
	prop := ToFeatureProperty new.
	prop name: #background.
	self assert: prop name equals: #background
]

{ #category : 'tests' }
ToFeaturePropertyTest >> testRead [

	| w prop r |
	w := ToElement new.
	prop := ToFeatureProperty new.
	self assert: (w respondsTo: #background).
	prop name: #background.
	self assert: (prop read: w) equals: w background.
	self assert: prop name equals: #background.
	prop write: Color blue to: w.
	self assert: (prop read: w) equals: w background.
	r := prop read: w.
	self assert: (r isKindOf: BlPaintBackground).
	self assert: r  paint color equals: Color blue.
	self assert: (prop read: w) equals: w background.
	prop write: Color red to: w.
	r := prop read: w.
	self assert: r  paint color equals: Color red.
	self assert: (prop read: w) equals: w background
]

{ #category : 'tests' }
ToFeaturePropertyTest >> testWriteTo [

	| w prop |
	w := ToElement new.
	prop := ToFeatureProperty new.
	prop name: #background.
	self assert: (w respondsTo: #background:).
	prop write: Color blue to: w.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color blue.
	self assert: (prop read: w) equals: w background
]

{ #category : 'tests' }
ToFeaturePropertyTest >> testWrongDefinition [

	| w prop |
	w := ToElement new.
	prop := ToFeatureProperty new.
	self assert: (w respondsTo: #background2) not.
	self assert: (w respondsTo: #background2:) not.
	prop name: #background2.
	self should: [ prop read ] raise: Error.
	self should: [ prop write: Color blue to: w] raise: Error.

]
