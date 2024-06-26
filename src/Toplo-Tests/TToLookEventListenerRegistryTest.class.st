"
A TToPropertyWriterHolderTest is a test class for testing the behavior of TToPropertyWriterHolder
"
Class {
	#name : #TToLookEventListenerRegistryTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Core-StyleSheet'
}

{ #category : #tests }
TToLookEventListenerRegistryTest >> testAddAllSkinEventListeners [

	| e |
	e := ToPropertyWritersHolderElementForTest new.
	self assert: e skinEventListeners size equals: 0.
	e addSkinEventListener: ToPropertyWriter new.
	self assert: e skinEventListeners size equals: 1.
	e addAllSkinEventListeners: { ToPropertyWriter new. ToPropertyWriter new }.
	self assert: e skinEventListeners size equals: 3.

	
]

{ #category : #tests }
TToLookEventListenerRegistryTest >> testAddSkinEventListener [

	| e |
	e := ToPropertyWritersHolderElementForTest new.
	self assert: e skinEventListeners size equals: 0.
	e addSkinEventListener: ToPropertyWriter new.
	self assert: e skinEventListeners size equals: 1
]

{ #category : #tests }
TToLookEventListenerRegistryTest >> testRemoveAllSkinEventListeners [

	| e |
	e := ToPropertyWritersHolderElementForTest new.
	self assert: e skinEventListeners size equals: 0.
	e addAllSkinEventListeners: { ToPropertyWriter new . ToPropertyWriter new }.
	self assert: e skinEventListeners size equals: 2.
	e removeAllSkinEventListeners: { e skinEventListeners first }.
	self assert: e skinEventListeners size equals: 1.
	self should: [ e removeAllSkinEventListeners: { ToPropertyWriter new } ] raise: NotFound.
	self assert: e skinEventListeners size equals: 1.



	
]

{ #category : #tests }
TToLookEventListenerRegistryTest >> testRemoveSkinEventListener [

	| e first second |
	e := ToPropertyWritersHolderElementForTest new.
	self assert: e skinEventListeners size equals: 0.
	e addAllSkinEventListeners: { first := ToPropertyWriter new . second := ToPropertyWriter new }.
	self assert: e skinEventListeners size equals: 2.
	e removeSkinEventListener: first.
	self assert: e skinEventListeners size equals: 1.
	e removeSkinEventListener: second.
	self assert: e skinEventListeners size equals: 0.
	self should: [ e removeSkinEventListener: first ] raise: NotFound.
	self assert: e skinEventListeners size equals: 0.



	
]

{ #category : #tests }
TToLookEventListenerRegistryTest >> testSkinEventListenerIndex [

	| e |
	e := ToPropertyWritersHolderElementForTest new.
	self assert: e skinEventListeners notNil.
	self assert: e skinEventListeners size equals: 0
]

{ #category : #tests }
TToLookEventListenerRegistryTest >> testSkinEventListeners [

	| e |
	e := ToPropertyWritersHolderElementForTest new.
	self assert: e skinEventListeners size equals: 0.

]
