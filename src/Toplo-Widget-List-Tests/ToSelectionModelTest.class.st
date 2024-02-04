"
A ToSelectionModelTest is a test class for testing the behavior of ToSelectionModel
"
Class {
	#name : #ToSelectionModelTest,
	#superclass : #TestCase,
	#category : #'Toplo-Widget-List-Tests-Selection-Model'
}

{ #category : #tests }
ToSelectionModelTest >> testContainsIndex [

	| s |
	s := ToSelectionModel new.
	self deny: (s containsIndex: 1).
	s ensureCompositeSelectionModel.
	s underlyingModel selectIndex: 1.
	s assert: (s containsIndex: 1).
	s ensureWholeSelectionModel.
	s assert: (s containsIndex: 1).
]

{ #category : #tests }
ToSelectionModelTest >> testEquals [

	| s |
	s := ToSelectionModel new.
	self assert: s equals: ToSelectionModel new.
	s ensureCompositeSelectionModel.
	self deny: s equals: ToSelectionModel new.
	s ensureEmptySelectionModel.
	self assert: s equals: ToSelectionModel new.
	s ensureWholeSelectionModel.
	self deny: s equals: ToSelectionModel new.

]

{ #category : #tests }
ToSelectionModelTest >> testIndices [

	| s |
	s := ToSelectionModel new.
	self assert: s indices equals: #().
	s ensureCompositeSelectionModel.
	self assert: s indices equals: #().
	s ensureWholeSelectionModel.
	self should: [s indices] raise: ToInvalidCommand.
]

{ #category : #tests }
ToSelectionModelTest >> testInitialize [ 

	| s |
	s := ToSelectionModel new.
	self assert: s isEmptySelectionModel.
	self assert: (s underlyingModel isKindOf: ToEmptySelectionModel).
]

{ #category : #tests }
ToSelectionModelTest >> testIsEmpty [

	| s |
	s := ToSelectionModel new.
	self assert: s isEmptySelectionModel.
	self assert: s isEmpty.
	s ensureCompositeSelectionModel.
	self deny: s isEmptySelectionModel.	
	self assert: s isEmpty.
	s ensureWholeSelectionModel.
	self deny: s isEmptySelectionModel.
	self deny: s isEmpty.


]
