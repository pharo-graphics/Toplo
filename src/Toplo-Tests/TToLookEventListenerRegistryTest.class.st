"
A TToPropertyWriterHolderTest is a test class for testing the behavior of TToPropertyWriterHolder
"
Class {
	#name : 'TToLookEventListenerRegistryTest',
	#superclass : 'TestCase',
	#category : 'Toplo-Tests-Core-StyleSheet',
	#package : 'Toplo-Tests',
	#tag : 'Core-StyleSheet'
}

{ #category : 'tests' }
TToLookEventListenerRegistryTest >> testAddAllLookEventListeners [

	| e |
	e := ToPropertyWritersHolderElementForTest new.
	self assert: e lookEventListeners size equals: 0.
	e addLookEventListener: ToPropertyWriter new.
	self assert: e lookEventListeners size equals: 1.
	e addAllLookEventListeners: { ToPropertyWriter new. ToPropertyWriter new }.
	self assert: e lookEventListeners size equals: 3.

	
]

{ #category : 'tests' }
TToLookEventListenerRegistryTest >> testAddLookEventListener [

	| e |
	e := ToPropertyWritersHolderElementForTest new.
	self assert: e lookEventListeners size equals: 0.
	e addLookEventListener: ToPropertyWriter new.
	self assert: e lookEventListeners size equals: 1
]

{ #category : 'tests' }
TToLookEventListenerRegistryTest >> testLookEventListeners [

	| e |
	e := ToPropertyWritersHolderElementForTest new.
	self assert: e lookEventListeners size equals: 0.

]

{ #category : 'tests' }
TToLookEventListenerRegistryTest >> testRemoveAllLookEventListeners [

	| e |
	e := ToPropertyWritersHolderElementForTest new.
	self assert: e lookEventListeners size equals: 0.
	e addAllLookEventListeners: { ToPropertyWriter new . ToPropertyWriter new }.
	self assert: e lookEventListeners size equals: 2.
	e removeAllLookEventListeners: { e lookEventListeners first }.
	self assert: e lookEventListeners size equals: 1.
	self should: [ e removeAllLookEventListeners: { ToPropertyWriter new } ] raise: NotFound.
	self assert: e lookEventListeners size equals: 1.



	
]

{ #category : 'tests' }
TToLookEventListenerRegistryTest >> testRemoveLookEventListener [

	| e first second |
	e := ToPropertyWritersHolderElementForTest new.
	self assert: e lookEventListeners size equals: 0.
	e addAllLookEventListeners: { first := ToPropertyWriter new . second := ToPropertyWriter new }.
	self assert: e lookEventListeners size equals: 2.
	e removeLookEventListener: first.
	self assert: e lookEventListeners size equals: 1.
	e removeLookEventListener: second.
	self assert: e lookEventListeners size equals: 0.
	self should: [ e removeLookEventListener: first ] raise: NotFound.
	self assert: e lookEventListeners size equals: 0.



	
]

{ #category : 'tests' }
TToLookEventListenerRegistryTest >> testlookEventListenerIndex [

	| e |
	e := ToPropertyWritersHolderElementForTest new.
	self assert: e lookEventListeners notNil.
	self assert: e lookEventListeners size equals: 0
]
