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
ToPrimarySelectionModelTest >> testCopyWithSelectedIndexes [

	| s c |
	s := ToPrimarySelectionModel new.
	s selectIndex: 10.
	c := s copy.
	self assert: c selectedIndexes equals: #(10)
]

{ #category : #tests }
ToPrimarySelectionModelTest >> testDuplicate [

	| s sub dup |
	s := ToPrimarySelectionModel new.
	sub := ToSubSelectionModel new uniqueId: #sub.
	s recordSubSelectionModel: sub.
	s selectIndex: 10.
	sub selectIndex: 2.
	dup := s duplicate.
	self assert: dup selectedIndexes equals: #( 10 ).
	self assert: (dup subSelectionModelIndex at: #sub) equals: sub.
	self deny: (dup subSelectionModelIndex at: #sub) identicalTo: sub.
	self assert: ((dup subSelectionModelIndex at: #sub)) selectedIndexes equals: #( 2 )
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
	self assert: (s subSelectionModelIndex at: #sub) equals: sub.
	self assert: sub selectedIndexes equals: #( 2 )
]
