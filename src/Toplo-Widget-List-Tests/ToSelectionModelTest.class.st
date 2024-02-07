"
A ToSelectionModelTest is a test class for testing the behavior of ToSelectionModel
"
Class {
	#name : #ToSelectionModelTest,
	#superclass : #TestCase,
	#category : #'Toplo-Widget-List-Tests-Selection-Model'
}

{ #category : #accessing }
ToSelectionModelTest >> itemCount [

	^ 1000
]

{ #category : #tests }
ToSelectionModelTest >> testCheckEmptiness [

	| s |
	s := ToSelectionModel new.
	s checkEmptiness.
	self assert: (s underlyingModel isKindOf: ToEmptySelectionModel ).
	s ensureCompositeSelectionModel.
	self assert: (s underlyingModel isKindOf: ToCompositeSelectionModel ).
	s checkEmptiness.
	self assert: (s underlyingModel isKindOf: ToEmptySelectionModel ).
	s ensureCompositeSelectionModel.
	s underlyingModel selectIndex: 1.
	s checkEmptiness.
	self assert: (s underlyingModel isKindOf: ToCompositeSelectionModel ).
	s underlyingModel deselectIndex: 1.
	s checkEmptiness.
	self assert: (s underlyingModel isKindOf: ToEmptySelectionModel ).



]

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
ToSelectionModelTest >> testCopyCompositeModel [

	| s c |
	s := ToSelectionModel new.
	s ensureCompositeSelectionModel.
	c := s copy.
	self deny: s underlyingModel identicalTo: c underlyingModel.
	self assert: c equals: s
]

{ #category : #tests }
ToSelectionModelTest >> testCopyEmptyModel [

	| s c |
	s := ToSelectionModel new.
	c := s copy.
	self assert: s underlyingModel identicalTo: c underlyingModel.
	self assert: c equals: s
]

{ #category : #tests }
ToSelectionModelTest >> testCopyWholeModel [

	| s c |
	s := ToSelectionModel new.
	s ensureWholeSelectionModel.
	c := s copy.
	self assert: s underlyingModel identicalTo: c underlyingModel.
	self assert: c equals: s
]

{ #category : #tests }
ToSelectionModelTest >> testEnsureCompositeSelectionModel [

	| s |
	s := ToSelectionModel new.
	s ensureCompositeSelectionModel.
	self assert: (s underlyingModel isKindOf: ToCompositeSelectionModel )
]

{ #category : #tests }
ToSelectionModelTest >> testEnsureEmptySelectionModel [

	| s |
	s := ToSelectionModel new.
	s ensureEmptySelectionModel.
	self assert: (s underlyingModel isKindOf: ToEmptySelectionModel )
]

{ #category : #tests }
ToSelectionModelTest >> testEnsureWholeSelectionModel [

	| s |
	s := ToSelectionModel new.
	s ensureWholeSelectionModel.
	self assert: (s underlyingModel isKindOf: ToWholeSelectionModel )
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

{ #category : #tests }
ToSelectionModelTest >> testItemCount [

	| s |
	s := ToSelectionModel new onInstalledIn: self.
	self assert: s itemCount equals: self itemCount.
	s ensureCompositeSelectionModel.
	s underlyingModel selectIndex: 1.
	s assert: (s containsIndex: 1).
	s ensureWholeSelectionModel.
	s assert: (s containsIndex: 1).
]

{ #category : #tests }
ToSelectionModelTest >> testNewOperator [

	| s selecter |
	s := ToSelectionModel new.
	selecter := s newOperator
]

{ #category : #tests }
ToSelectionModelTest >> testOnInstalledIn [

	| s |
	s := ToSelectionModel new.
	s onInstalledIn: self.
	self assert: s itemCountGetter notNil.
	self assert: s itemCountGetter value equals: self itemCount 
]

{ #category : #tests }
ToSelectionModelTest >> testOnUninstalledIn [

	| s |
	s := ToSelectionModel new.
	s onInstalledIn: self.
	s onUninstalledIn: self.
	self assert: s itemCountGetter isNil.
	self assert: s itemCount isNil
]

{ #category : #tests }
ToSelectionModelTest >> testSelectedItemCount [

	| s |
	s := ToSelectionModel new onInstalledIn: self.
	self assert: s isEmptySelectionModel.
	self assert: s selectedIndexesCount equals: 0.
	s ensureCompositeSelectionModel.
	s underlyingModel selectIndex: 1.
	self assert: s selectedIndexesCount equals: 1.
	s ensureWholeSelectionModel.
	self assert: s selectedIndexesCount equals: self itemCount.
]

{ #category : #tests }
ToSelectionModelTest >> testUnderlyingModel [

	| s |
	s := ToSelectionModel new.
	self assert: (s underlyingModel isKindOf: ToEmptySelectionModel).
	s ensureCompositeSelectionModel.
	self assert: (s underlyingModel isKindOf: ToCompositeSelectionModel).
	s ensureWholeSelectionModel.
	self assert: (s underlyingModel isKindOf: ToWholeSelectionModel).
	s ensureEmptySelectionModel.
	self assert: (s underlyingModel isKindOf: ToEmptySelectionModel).



	
]

{ #category : #tests }
ToSelectionModelTest >> testselectedIndexes [

	| s |
	s := ToSelectionModel new.
	self assert: s selectedIndexes equals: #().
	s ensureCompositeSelectionModel.
	self assert: s selectedIndexes equals: #().
	s ensureWholeSelectionModel.
	self should: [s selectedIndexes] raise: ToInvalidCommand.
]
