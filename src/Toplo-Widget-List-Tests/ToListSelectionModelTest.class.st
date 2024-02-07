Class {
	#name : #ToListSelectionModelTest,
	#superclass : #TestCase,
	#instVars : [
		'holder',
		'operator'
	],
	#category : #'Toplo-Widget-List-Tests-Selection-Model'
}

{ #category : #running }
ToListSelectionModelTest >> setUp [ 

	super setUp.
	holder := ToListSelectionModelHolderForTest new.
	holder data addAll: (1 to: 1000).
	operator := holder operator
]

{ #category : #tests }
ToListSelectionModelTest >> testDeselectAll [

	operator selectIndex: 2.
	operator deselectAll.
	operator applyOn: holder.
	self assert: holder selectionModel isEmpty.
	operator selectAll.
	operator deselectAll.
	operator applyOn: holder.
	self assert: holder selectionModel isEmpty.


]

{ #category : #tests }
ToListSelectionModelTest >> testDispatchSelectionChanged [

	| selChangedEvent |
	self flag: 'To redo'.
	self skip.
	holder addEventHandler: (BlEventHandler
			 on: ToListSelectionChangedEvent
			 do: [ :event | selChangedEvent := event ]).

	operator selectAllIndexes: { 2. 6. 9 }.
	operator applyOn: holder.
	self assert: selChangedEvent notNil.
	self assert: holder selectionModel equals: holder selectionModel.

	selChangedEvent := nil.
	" no change "
	operator selectAllIndexes: { 2. 6. 9 }.
	operator applyOn: holder.
	self assert: selChangedEvent isNil.

	" incompatible mode "
	holder selectionCommandChecker: ToListNoneSelectionCommandChecker new.
	self
		should: [
			operator selectAllIndexes: { 2. 6. 9 }.
			operator applyOn: holder ]
		raise: ToIncompatibleMode.
	self assert: selChangedEvent isNil
]

{ #category : #tests }
ToListSelectionModelTest >> testIncompatibleMode [

	self flag: 'To redo'.
	self skip.
	holder selectionCommandChecker: ToListNoneSelectionCommandChecker new.
	self
		should: [
			operator selectAllIndexes: { 2. 6. 9 }.
			operator applyOn: holder ]
		raise: ToIncompatibleMode.
	self
		should: [
			operator deselectAllIndexes: { 2. 6. 9 }.
			operator applyOn: holder ]
		raise: ToIncompatibleMode.
	self
		should: [
			operator selectIndex: 2.
			operator applyOn: holder ]
		raise: ToIncompatibleMode.
	self
		should: [
			operator deselectIndex: 2.
			operator applyOn: holder ]
		raise: ToIncompatibleMode.
	self
		should: [
			operator selectAll.
			operator applyOn: holder ]
		raise: ToIncompatibleMode.
	self
		should: [
			operator deselectAll.
			operator applyOn: holder ]
		raise: ToIncompatibleMode
]

{ #category : #tests }
ToListSelectionModelTest >> testIncompatibleMode2 [

	self flag: 'To redo'.
	self skip.
	holder selectionCommandChecker:
		ToListSingleSelectionCommandChecker new.
	self
		should: [
			operator selectAllIndexes: { 2. 6. 9 }.
			operator applyOn: holder ]
		raise: ToIncompatibleMode.
	self
		should: [
			operator deselectAllIndexes: { 2. 6. 9 }.
			operator applyOn: holder ]
		raise: ToIncompatibleMode.
	operator selectIndex: 2.
	operator deselectIndex: 2.
	operator applyOn: holder.
	self
		should: [
			operator selectAll.
			operator applyOn: holder ]
		raise: ToIncompatibleMode.
	operator deselectAll.
	operator applyOn: holder
]

{ #category : #tests }
ToListSelectionModelTest >> testOnSelectionRequestError [

	self flag: 'To redo'.
	self skip.
	holder selectionCommandChecker:
		ToListSingleSelectionCommandChecker new.
	self
		should: [
			operator selectAllIndexes: { 2. 6. 9 }.
			operator applyOn: holder ]
		raise: ToIncompatibleMode
]

{ #category : #tests }
ToListSelectionModelTest >> testOnSelectionRequestSuccess [

	self flag: 'To redo'.
	self skip.
	operator selectAllIndexes: { 2. 6. 9 }.
	operator applyOn: holder.
	self assert: holder successfulCommand notNil.
	holder successfulCommand: nil.
	" no change "
	operator selectAllIndexes: { 2. 6. 9 }.
	operator applyOn: holder.
	self assert: holder successfulCommand isNil.

	holder selectionCommandChecker: ToListNoneSelectionCommandChecker new.
	holder successfulCommand: nil.
	self
		should: [
			operator selectAllIndexes: { 2. 6. 9 }.
			operator applyOn: holder ]
		raise: ToIncompatibleMode.
	self assert: holder successfulCommand isNil
]

{ #category : #tests }
ToListSelectionModelTest >> testSelectAll [

	self flag: 'To redo'.
	self skip.
	operator selectAll.
	operator applyOn: holder.
	self assert: holder selectionModel currentIndex equals: 0.
	self assert: holder selectionModel pivot isNil.
	self assert: holder selectionModel distance isNil.
	self assert: holder selectionModel isWholeSelectionModel
]

{ #category : #tests }
ToListSelectionModelTest >> testSelectIndex [

	self flag: 'To redo'.
	self skip.
	operator selectIndex: 2.
	operator applyOn: holder.
	self assert: holder selectionModel selectedIndexes first equals: 2.
	self assert: holder selectionModel currentIndex equals: 2.
	self assert: holder selectionModel pivot isNil.
	self assert: holder selectionModel distance isNil
]

{ #category : #tests }
ToListSelectionModelTest >> testSelectIndexTo [

	self flag: 'To redo'.
	self skip.
	operator selectIndex: 2 to: 10.
	operator applyOn: holder.
	self assert: holder selectionModel currentIndex equals: 10.
	self assert: holder selectionModel pivot isNil.
	self assert: holder selectionModel distance isNil
]

{ #category : #tests }
ToListSelectionModelTest >> testSelectNext [
self flag: 'To do'.
self skip.
	operator selectIndex: 2.
	operator applyOn: holder.
	self assert: holder selectionModel currentIndex equals: 2.
	self assert: holder selectionModel pivot isNil.
	self assert: holder selectionModel distance isNil.
	operator selectNext.
	operator applyOn: holder.
	self assert: holder selectionModel selectedIndexes asSet equals: #(3) asSet.
	self assert: holder selectionModel currentIndex equals: 3.
	self assert: holder selectionModel pivot isNil.
	self assert: holder selectionModel distance isNil.


]

{ #category : #tests }
ToListSelectionModelTest >> testSelectNextOnLastIndex [
self flag: 'To do'.
self skip.
	operator selectIndex: holder dataSource itemCount.
	operator applyOn: holder.
	self assert: holder selectionModel currentIndex equals: holder dataSource itemCount.
	operator selectNext.
	operator applyOn: holder.
	self
		assert: holder selectionModel selectedIndexes asSet
		equals: { 1 } asSet.
	self
		assert: holder selectionModel currentIndex
		equals: 1
]

{ #category : #tests }
ToListSelectionModelTest >> testSelectOrDeselectNext [
self flag: 'To do'.
self skip.
	operator deselectAll.
	operator selectIndex: 2.
	operator applyOn: holder.
	operator selectOrDeselectNext.
	operator applyOn: holder.
	self assert: holder selectionModel selectedIndexes equals: #( 2 3 ).
	self assert: holder selectionModel currentIndex equals: 3.
	self assert: holder selectionModel pivot isNil.
	self flag: 'The distance computation has to be more precisely tested'.
	"self assert: selecter selectionModel distance notNil."
	operator selectOrDeselectNext.
	operator applyOn: holder.
	self assert: holder selectionModel selectedIndexes equals: #( 2 3 4 ).
	self assert: holder selectionModel currentIndex equals: 4.
	self assert: holder selectionModel pivot isNil.
	"self assert: selecter selectionModel distance notNil."

]

{ #category : #tests }
ToListSelectionModelTest >> testSelectOrDeselectPrevious [

self flag: 'To do'.
self skip.
	operator deselectAll.
	operator selectIndex: 2.
	operator selectOrDeselectPrevious.
	operator applyOn: holder.
	self assert: holder selectionModel selectedIndexes equals: #( 1 2 ).
	self assert: holder selectionModel currentIndex equals: 1.
	self assert: holder selectionModel pivot isNil.
	"self assert: holder selectionModel distance equals: 1."
	operator selectOrDeselectPrevious.
	operator applyOn: holder.
	self assert: holder selectionModel selectedIndexes equals: #( 1 2 ).
	self assert: holder selectionModel currentIndex equals: 1.
	self assert: holder selectionModel pivot isNil.
	"self assert: holder selectionModel distance equals: 1."

]

{ #category : #tests }
ToListSelectionModelTest >> testSelectPrevious [
self flag: 'To do'.
self skip.
	operator selectIndex: 2.
	operator applyOn: holder.
	self assert: holder selectionModel currentIndex equals: 2.
	self assert: holder selectionModel pivot isNil.
	self assert: holder selectionModel distance isNil.
	operator selectPrevious.
	operator applyOn: holder.
	self assert: holder selectionModel selectedIndexes asSet equals: #(1) asSet.
	self assert: holder selectionModel currentIndex equals: 1.
	self assert: holder selectionModel pivot isNil.
	self assert: holder selectionModel distance isNil
]

{ #category : #tests }
ToListSelectionModelTest >> testSelectPreviousOnFirstIndex [
self flag: 'To do'.
self skip.
	operator selectIndex: 1.
	operator applyOn: holder.
	self assert: holder selectionModel currentIndex equals: 1.
	operator selectPrevious.
	operator applyOn: holder.
	self
		assert: holder selectionModel selectedIndexes asSet
		equals: { holder dataSource itemCount } asSet.
	self
		assert: holder selectionModel currentIndex
		equals: holder dataSource itemCount
]

{ #category : #tests }
ToListSelectionModelTest >> testSelectToIndex [
self flag: 'To do'.
self skip.
	operator selectIndex: 2.
	operator applyOn: holder.
	self assert: holder selectionModel selectedIndexes first equals: 2.
	self assert: holder selectionModel currentIndex equals: 2.
	self assert: holder selectionModel pivot isNil.
	self assert: holder selectionModel distance isNil.
	operator selectToIndex: 12.
	operator applyOn: holder.
	self assert: holder selectionModel selectedIndexes first equals: 2.
	self assert: holder selectionModel selectedIndexes last equals: 12.
	self assert: holder selectionModel currentIndex equals: 12.
	self flag: 'distance/pivot ???  !!!!'.
	"self assert: selecter selectionModel distance equals: 10."
	self assert: holder selectionModel pivot equals: 2.
	operator selectToIndex: 2.
	operator applyOn: holder.
	self assert: holder selectionModel selectedIndexes first equals: 2.
	self assert: holder selectionModel selectedIndexes last equals: 12.
	self assert: holder selectionModel currentIndex equals: 2.
	"self assert: selecter selectionModel distance equals: -10."
	self assert: holder selectionModel pivot equals: 12


]
