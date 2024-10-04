"
A ToPrimarySelectionModelTest is a test class for testing the behavior of ToPrimarySelectionModel
"
Class {
	#name : #ToPrimarySelectionModelTest,
	#superclass : #TestCase,
	#category : #'Toplo-Widget-List-Tests-Selection-Model'
}

{ #category : #tests }
ToPrimarySelectionModelTest >> testCopy [

	| s c |
	s := ToPrimarySelectionModel new.
	c := s copy.
	self deny: s underlyingModel identicalTo: c underlyingModel.
	self assert: c equals: s
]

{ #category : #tests }
ToPrimarySelectionModelTest >> testCopySelectionFrom [

	| s sub dup |
	s := ToPrimarySelectionModel new.
	sub := ToSubSelectionModel new uniqueId: #sub.
	s recordSubSelectionModel: sub.
	s selectIndex: 10.
	sub selectIndex: 2.
	dup := ToPrimarySelectionModel new.
	dup copySelectionFrom: s.
	self assert: (dup containsIndex: 10).
	self assert: (dup subSelectionModelWithId: #sub) notNil.
	self deny: (dup subSelectionModelWithId: #sub) identicalTo: sub
]

{ #category : #tests }
ToPrimarySelectionModelTest >> testCopyWithSelectedIndexes [

	| s c |
	s := ToPrimarySelectionModel new.
	s selectIndex: 10.
	c := s copy.
	self assert: c selectedIndexes equals: #(10)
]

{ #category : #tests }
ToPrimarySelectionModelTest >> testCopyWithSubs [

	| s sub dup |
	s := ToPrimarySelectionModel new.
	sub := ToSubSelectionModel new uniqueId: #sub.
	s recordSubSelectionModel: sub.
	s selectIndex: 10.
	sub selectIndex: 2.
	dup := s copy.
	self assert: dup selectedIndexes equals: #( 10 ).
	self assert: (dup subSelectionModelIndex subSelectionModelWithId: #sub) equals: sub.
	self deny: (dup subSelectionModelIndex subSelectionModelWithId: #sub) identicalTo: sub.
	self assert: ((dup subSelectionModelIndex subSelectionModelWithId: #sub)) selectedIndexes equals: #( 2 )
]

{ #category : #tests }
ToPrimarySelectionModelTest >> testRecordSubSelectionModel [

	| s sub |
	s := ToPrimarySelectionModel new.
	sub := ToSubSelectionModel new uniqueId: #sub.
	s recordSubSelectionModel: sub.
	s selectIndex: 10.
	sub selectIndex: 2.
	self assert: s selectedIndexes equals: #( 10 ).
	self assert: (s subSelectionModelIndex subSelectionModelWithId: #sub) equals: sub.
	self assert: sub selectedIndexes equals: #( 2 )
]
