"
A TToPropertyWriterHolderTest is a test class for testing the behavior of TToPropertyWriterHolder
"
Class {
	#name : #TToPropertyWritersHolderTest,
	#superclass : #TestCase,
	#category : 'Toplo-Tests-Core-StyleSheet'
}

{ #category : #tests }
TToPropertyWritersHolderTest >> testAddAllPropertyWriters [

	| e |
	e := ToPropertyWritersHolderElementForTest new.
	self assert: e propertyWriters size equals: 0.
	e addPropertyWriter: ToPropertyWriter new.
	self assert: e propertyWriters size equals: 1.
	e addAllPropertyWriters: { ToPropertyWriter new. ToPropertyWriter new }.
	self assert: e propertyWriters size equals: 3.

	
]

{ #category : #tests }
TToPropertyWritersHolderTest >> testAddPropertyWriter [

	| e |
	e := ToPropertyWritersHolderElementForTest new.
	self assert: e propertyWriters size equals: 0.
	e addPropertyWriter: ToPropertyWriter new.
	self assert: e propertyWriters size equals: 1
]

{ #category : #tests }
TToPropertyWritersHolderTest >> testPropertyWriters [

	| e |
	e := ToPropertyWritersHolderElementForTest new.
	self assert: e propertyWriters size equals: 0.

]

{ #category : #tests }
TToPropertyWritersHolderTest >> testRemoveAllPropertyWriters [

	| e |
	e := ToPropertyWritersHolderElementForTest new.
	self assert: e propertyWriters size equals: 0.
	e addAllPropertyWriters: { ToPropertyWriter new. ToPropertyWriter new }.
	self assert: e propertyWriters size equals: 2.
	e removeAllPropertyWriters: { e propertyWriters first }.
	self assert: e propertyWriters size equals: 1.
	e removeAllPropertyWriters: { ToPropertyWriter new }.
	self assert: e propertyWriters size equals: 1.



	
]
