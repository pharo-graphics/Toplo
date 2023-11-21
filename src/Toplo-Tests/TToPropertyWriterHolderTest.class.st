"
A TToPropertyWriterHolderTest is a test class for testing the behavior of TToPropertyWriterHolder
"
Class {
	#name : 'TToPropertyWriterHolderTest',
	#superclass : 'TestCase',
	#category : 'Toplo-Tests-Core-StyleSheet',
	#package : 'Toplo-Tests',
	#tag : 'Core-StyleSheet'
}

{ #category : 'tests' }
TToPropertyWriterHolderTest >> testAddAllWriters [

	| e |
	e := ToPropertyWriterHolderElementForTest new.
	self assert: e writers size equals: 0.
	e addWriter: ToPropertyWriter new.
	self assert: e writers size equals: 1.
	e addAllWriters: { ToPropertyWriter new. ToPropertyWriter new }.
	self assert: e writers size equals: 3.

	
]

{ #category : 'tests' }
TToPropertyWriterHolderTest >> testAddWriter [

	| e |
	e := ToPropertyWriterHolderElementForTest new.
	self assert: e writers size equals: 0.
	e addWriter: ToPropertyWriter new.
	self assert: e writers size equals: 1
]

{ #category : 'tests' }
TToPropertyWriterHolderTest >> testRemoveAllWriters [

	| e |
	e := ToPropertyWriterHolderElementForTest new.
	self assert: e writers size equals: 0.
	e addAllWriters: { ToPropertyWriter new. ToPropertyWriter new }.
	self assert: e writers size equals: 2.
	e removeAllWriters: { e writers first }.
	self assert: e writers size equals: 1.
	e removeAllWriters: { ToPropertyWriter new }.
	self assert: e writers size equals: 1.



	
]

{ #category : 'tests' }
TToPropertyWriterHolderTest >> testWriters [

	| e |
	e := ToPropertyWriterHolderElementForTest new.
	self assert: e writers size equals: 0.

]
