Class {
	#name : #ToListSelectionModelOperatorTest,
	#superclass : #TestCase,
	#instVars : [
		'holder',
		'selecter'
	],
	#category : #'Toplo-Widget-List-Tests-Selection-Command'
}

{ #category : #running }
ToListSelectionModelOperatorTest >> setUp [ 

	| data |
	super setUp.
	data := ToObservableCollection new.
	holder := ToListSelectionModelHolderForTest new.
	holder dataSource: ToInfiniteObservableCollectionDataSource new.
	holder dataSource data: data.
	data addAll: (1 to: 1000).
	selecter := holder selecter
]

{ #category : #tests }
ToListSelectionModelOperatorTest >> testDeselectAll [

	selecter selectIndex: 2.
	selecter deselectAll.
	self assert: selecter selectionModel currentIndex equals: 0.
	self assert: selecter selectionModel pivot isNil.
	self assert: selecter selectionModel distance isNil.
	self assert: selecter selectionModel isEmpty.
	selecter selectAll.
	selecter deselectAll.
	self assert: selecter selectionModel currentIndex equals: 0.
	self assert: selecter selectionModel pivot isNil.
	self assert: selecter selectionModel distance isNil.
	self assert: selecter selectionModel isEmpty.


]

{ #category : #tests }
ToListSelectionModelOperatorTest >> testSelectAll [

	selecter selectAll.
	self assert: selecter selectionModel currentIndex equals: 0.
	self assert: selecter selectionModel pivot isNil.
	self assert: selecter selectionModel distance isNil.
	self assert: selecter selectionModel isWholeSelectionModel
]

{ #category : #tests }
ToListSelectionModelOperatorTest >> testSelectIndex [

	selecter selectIndex: 2.
	self assert: selecter selectionModel indices first equals: 2.
	self assert: selecter selectionModel currentIndex equals: 2.
	self assert: selecter selectionModel pivot isNil.
	self assert: selecter selectionModel distance isNil
]

{ #category : #tests }
ToListSelectionModelOperatorTest >> testSelectIndexTo [

	selecter selectIndex: 2 to: 10.
	self assert: selecter selectionModel currentIndex equals: 10.
	self assert: selecter selectionModel pivot isNil.
	self assert: selecter selectionModel distance isNil
]

{ #category : #tests }
ToListSelectionModelOperatorTest >> testSelectNext [

	selecter selectIndex: 2.
	self assert: selecter selectionModel currentIndex equals: 2.
	self assert: selecter selectionModel pivot isNil.
	self assert: selecter selectionModel distance isNil.
	selecter selectNext.
	self assert: selecter selectionModel indices asSet equals: #(3) asSet.
	self assert: selecter selectionModel currentIndex equals: 3.
	self assert: selecter selectionModel pivot isNil.
	self assert: selecter selectionModel distance isNil.


]

{ #category : #tests }
ToListSelectionModelOperatorTest >> testSelectNextOnLastIndex [

	selecter selectIndex: holder dataSource itemCount.
	self assert: selecter selectionModel currentIndex equals: holder dataSource itemCount.
	selecter selectNext.
	self
		assert: selecter selectionModel indices asSet
		equals: { 1 } asSet.
	self
		assert: selecter selectionModel currentIndex
		equals: 1
]

{ #category : #tests }
ToListSelectionModelOperatorTest >> testSelectOrDeselectNext [

	selecter deselectAll.
	selecter selectIndex: 2.
	selecter selectOrDeselectNext.
	self assert: selecter selectionModel indices equals: #( 2 3 ).
	self assert: selecter selectionModel currentIndex equals: 3.
	self assert: selecter selectionModel pivot isNil.
	self assert: selecter selectionModel distance isNil.
	selecter selectOrDeselectNext.
	self assert: selecter selectionModel indices equals: #( 2 3 4 ).
	self assert: selecter selectionModel currentIndex equals: 4.
	self assert: selecter selectionModel pivot isNil.
	self assert: selecter selectionModel distance isNil.

]

{ #category : #tests }
ToListSelectionModelOperatorTest >> testSelectOrDeselectPrevious [

	selecter deselectAll.
	selecter selectIndex: 2.
	selecter selectOrDeselectPrevious.
	self assert: selecter selectionModel indices equals: #( 1 2 ).
	self assert: selecter selectionModel currentIndex equals: 1.
	self assert: selecter selectionModel pivot isNil.
	self assert: selecter selectionModel distance isNil.
	selecter selectOrDeselectPrevious.
	self assert: selecter selectionModel indices equals: #( 1 2 ).
	self assert: selecter selectionModel currentIndex equals: 1.
	self assert: selecter selectionModel pivot isNil.
	self assert: selecter selectionModel distance isNil.

]

{ #category : #tests }
ToListSelectionModelOperatorTest >> testSelectPrevious [

	selecter selectIndex: 2.
	self assert: selecter selectionModel currentIndex equals: 2.
	self assert: selecter selectionModel pivot isNil.
	self assert: selecter selectionModel distance isNil.
	selecter selectPrevious.
	self assert: selecter selectionModel indices asSet equals: #(1) asSet.
	self assert: selecter selectionModel currentIndex equals: 1.
	self assert: selecter selectionModel pivot isNil.
	self assert: selecter selectionModel distance isNil
]

{ #category : #tests }
ToListSelectionModelOperatorTest >> testSelectPreviousOnFirstIndex [

	selecter selectIndex: 1.
	self assert: selecter selectionModel currentIndex equals: 1.
	selecter selectPrevious.
	self
		assert: selecter selectionModel indices asSet
		equals: { holder dataSource itemCount } asSet.
	self
		assert: selecter selectionModel currentIndex
		equals: holder dataSource itemCount
]

{ #category : #tests }
ToListSelectionModelOperatorTest >> testSelectToIndex [

	selecter selectIndex: 2.
	self assert: selecter selectionModel indices first equals: 2.
	self assert: selecter selectionModel currentIndex equals: 2.
	self assert: selecter selectionModel pivot isNil.
	self assert: selecter selectionModel distance isNil.
	selecter selectToIndex: 12.
	self assert: selecter selectionModel indices first equals: 2.
	self assert: selecter selectionModel indices last equals: 12.
	self assert: selecter selectionModel currentIndex equals: 12.
	self assert: selecter selectionModel distance equals: 10.
	self assert: selecter selectionModel pivot equals: 2.
	selecter selectToIndex: 2.
	self assert: selecter selectionModel indices first equals: 2.
	self assert: selecter selectionModel indices last equals: 12.
	self assert: selecter selectionModel currentIndex equals: 2.
	self assert: selecter selectionModel distance equals: -10.
	self assert: selecter selectionModel pivot equals: 12


]
