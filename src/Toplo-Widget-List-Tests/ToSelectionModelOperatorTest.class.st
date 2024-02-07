Class {
	#name : #ToSelectionModelOperatorTest,
	#superclass : #TestCase,
	#instVars : [
		'holder',
		'selectionChanged',
		'operator'
	],
	#category : #'Toplo-Widget-List-Tests-Selection-Updater'
}

{ #category : #running }
ToSelectionModelOperatorTest >> setUp [

	super setUp.
	selectionChanged := false.
	holder := ToSelectionModelHolderForTest new.
	holder data addAll: (1 to: 1000).
	holder addEventHandler: (BlEventHandler
			 on: ToListSelectionChangedEvent
			 do: [ :event | selectionChanged := true ]).
	operator := holder operator
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testDeselectAll [

	operator selectAllIndexes: {2. 6. 9}.
	operator deselectAll.
	operator applyOn: holder.
	self assert: holder selectionModel isEmpty
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testDeselectAllIndexes [

	operator selectAllIndexes: {2. 6. 9}.
	operator applyOn: holder.
	self assert: holder selectionModel selectedIndexes size equals: 3.
	self assert: holder selectionModel selectedIndexes asSet equals: {2. 6. 9} asSet.	
	operator deselectAllIndexes: {2. 6. 9}.
	operator applyOn: holder.
	self assert: holder selectionModel isEmpty 
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testDeselectAllThenSelectAllIndexes [

	operator deselectAll.
	operator applyOn: holder.
	self assert: holder selectionModel isEmptySelectionModel.
	operator selectAllIndexes: #(3 5 6).
	operator applyOn: holder.
	self assert: holder selectionModel selectedIndexes asSet equals: #(3 5 6) asSet

]

{ #category : #tests }
ToSelectionModelOperatorTest >> testDeselectAllThenSelectIndexTo [

	operator deselectAll.
	operator applyOn: holder.
	self assert: holder selectionModel isEmptySelectionModel.
	operator selectIndex: 2 to: 10.
	operator applyOn: holder.
	self assert: holder selectionModel selectedIndexes size equals: 9.
	self assert: holder selectionModel selectedIndexes asSet equals: (2 to: 10) asSet
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testDeselectIndex [

	operator selectIndex: 2.
	operator applyOn: holder.
	self assert: holder selectionModel selectedIndexes size equals: 1.
	self assert: holder selectionModel selectedIndexes asSet equals: {2} asSet.	
	operator deselectIndex: 2.
	operator applyOn: holder.
	self assert: holder selectionModel isEmpty
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testDispatchEventForCommandOn [

	| selChangedEvent selRequestEvent cmd |
	holder addEventHandler: (BlEventHandler
			 on: ToListSelectionChangedEvent
			 do: [ :event | selChangedEvent := event ]).
	holder addEventHandler: (BlEventHandler
			 on: ToSelectionRequestEvent
			 do: [ :event | selRequestEvent := event ]).

	operator addCommand: (cmd := ToWholeSelectionCommand new
				        operation: ToAddSelectionOperation new;
				        yourself).
	operator dispatchEventForCommandOn: holder.
	self assert: holder selectionModel isNotEmpty.
	self assert: selChangedEvent notNil.
	self assert: selRequestEvent notNil.
	self assert: selRequestEvent command == cmd
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testDispatchSelectionChanged [

	| selChangedEvent |
	holder addEventHandler: (BlEventHandler
			 on: ToListSelectionChangedEvent
			 do: [ :event | selChangedEvent := event ]).

	operator selectAllIndexes: { 2. 6. 9 }.
	operator applyOn: holder.
	self assert: selChangedEvent notNil.

	selChangedEvent := nil.
	" no change "
	operator selectAllIndexes: { 2. 6. 9 }.
	operator applyOn: holder.
	self assert: selChangedEvent isNil
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectAll [

	operator selectAll.
	operator applyOn: holder.
	self assert: holder selectionModel isNotEmpty.
	operator selectAll.
	operator applyOn: holder.
	self
		assert: holder selectionModel isWholeSelectionModel
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectAllIndexes [

	operator selectAllIndexes: {2. 6. 9}.
	operator applyOn: holder.
	self assert: holder selectionModel selectedIndexes size equals: 3.
	self assert: holder selectionModel selectedIndexes asSet equals: {2. 6. 9} asSet
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectAllThenDeselectAllIndexes [

	operator selectAll.
	operator applyOn: holder.
	self assert: holder selectionModel isWholeSelectionModel.
	operator deselectAllIndexes: #(3 5 6).
	operator applyOn: holder.
	self assert: holder selectionModel isCompositeSelectionModel.
	self assert: holder selectionModel selectedIndexesCount equals: holder selectionModel itemCount - 3.
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectAllThenDeselectAllIndexes2 [

	operator selectAll.
	operator applyOn: holder.
	self assert: holder selectionModel isWholeSelectionModel.
	operator deselectAll.
	operator applyOn: holder.
	self assert: holder selectionModel isEmptySelectionModel.

]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectAllThenDeselectIndex [

	operator selectAll.
	operator applyOn: holder.
	self assert: holder selectionModel isWholeSelectionModel.
	operator deselectIndex:  10.
	operator applyOn: holder.
	self assert: holder selectionModel isCompositeSelectionModel.
	self assert: holder selectionModel selectedIndexesCount equals: holder selectionModel itemCount - 1.
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectAllThenSelectAllIndexes [

	operator selectAll.
	operator applyOn: holder.
	self
		assert: holder selectionModel isWholeSelectionModel.
	operator selectAllIndexes: #(3 5 6).
	operator applyOn: holder.
	self assert: holder selectionModel selectedIndexes asSet equals: #(3 5 6) asSet

]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectAllThenSelectAllIndexes2 [

	operator selectAll.
	operator applyOn: holder.
	self
		assert: holder selectionModel isWholeSelectionModel.
	operator selectAllIndexes: #(3 5 6).
	operator applyOn: holder.
	self assert: holder selectionModel selectedIndexes asSet equals: #(3 5 6) asSet

]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectAllThenSelectIndexTo [

	operator selectAll.
	operator applyOn: holder.
	self assert: holder selectionModel isWholeSelectionModel.
	operator selectIndex: 2 to: 10.
	operator applyOn: holder.
	self assert: holder selectionModel selectedIndexes size equals: 9.
	self
		assert: holder selectionModel selectedIndexes asSet
		equals: (2 to: 10) asSet
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectIndex [

	operator selectIndex: 2.
	operator applyOn: holder.
	self assert: holder selectionModel selectedIndexes size equals: 1.
	self assert: holder selectionModel selectedIndexes first equals: 2
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectIndexTo [

	operator selectIndex: 2 to: 10.
	operator applyOn: holder.
	self assert: holder selectionModel selectedIndexes size equals: 9.
	self assert: holder selectionModel selectedIndexes asSet equals: (2 to: 10) asSet
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectOnlyIndex [

	operator deselectAll.
	operator selectAllIndexes: {2. 6. 9}.
	operator applyOn: holder.
	self assert: holder selectionModel selectedIndexes asSet equals: {2. 6. 9} asSet.
	operator selectOnlyIndex: 10.
	operator applyOn: holder.
	self assert: holder selectionModel selectedIndexes asSet equals: {10} asSet.
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectOnlyIndexes [

	operator selectAllIndexes: {2. 6. 9}.
	operator applyOn: holder.
	self assert: holder selectionModel selectedIndexes asSet equals: {2. 6. 9} asSet.
	operator selectOnlyIndexes: {10. 6. 20}.
	operator applyOn: holder.
	self assert: holder selectionModel selectedIndexes asSet equals: {10. 6. 20} asSet.
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectionChanged [

	operator selectAllIndexes: {2. 6. 9}.
	operator applyOn: holder.
	self assert: selectionChanged. 

]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectionChangedOnDeselectAll [

	operator selectAllIndexes: {2. 6. 9}.
	operator applyOn: holder.
	self assert: selectionChanged. 
	selectionChanged := false.
	operator deselectAll.
	operator applyOn: holder.
	self assert: selectionChanged.
	selectionChanged := false.
	operator deselectAll.
	operator applyOn: holder.
	self deny: selectionChanged
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectionChangedOnDeselectAll2 [

	operator selectAllIndexes: {2. 6. 9}.
	operator applyOn: holder.
	self assert: selectionChanged. 
	selectionChanged := false.
	operator deselectAll.
	operator deselectAll.
	operator applyOn: holder.
	self assert: selectionChanged
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectionChangedOnDeselectAllIndexes [

	self deny: selectionChanged. 
	operator selectAllIndexes: {2. 6. 9}.
	operator applyOn: holder.
	self assert: selectionChanged. 
	selectionChanged := false.
	operator deselectAllIndexes: {2. 6. 9}.
	operator applyOn: holder.
	self assert: selectionChanged. 
	selectionChanged := false.
	operator deselectAllIndexes: {2. 6. 9}.
	operator applyOn: holder.
	self deny: selectionChanged. 

]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectionChangedOnDeselectIndex [

	operator selectIndex: 2.
	operator applyOn: holder.
	self assert: selectionChanged. 
	selectionChanged := false.
	operator deselectIndex: 2.
	operator applyOn: holder.
	self assert: selectionChanged. 
	selectionChanged := false.
	operator deselectIndex: 2.
	operator applyOn: holder.
	self deny: selectionChanged. 

]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectionChangedOnSelectAll [

	self deny: selectionChanged. 
	operator selectAll.
	operator applyOn: holder.
	self assert: selectionChanged. 
	selectionChanged := false.
	operator selectAll.
	operator applyOn: holder.
	self deny: selectionChanged. 

]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectionChangedOnSelectAllIndexes [

	self deny: selectionChanged. 
	operator selectAllIndexes: {2. 6. 9}.
	operator applyOn: holder.
	self assert: selectionChanged. 
	selectionChanged := false.
	operator selectAllIndexes: {2. 6. 9}.
	operator applyOn: holder.
	self deny: selectionChanged. 

]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectionChangedOnSelectIndex [

	self deny: selectionChanged. 
	operator selectIndex: 2.
	operator applyOn: holder.
	self assert: selectionChanged. 
	selectionChanged := false.
	operator selectIndex: 2.
	operator applyOn: holder.
	self deny: selectionChanged. 


]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectionChangedOnSelectOnlyIndex [

	self deny: selectionChanged. 
	operator deselectAll.
	operator applyOn: holder.
	self deny: selectionChanged. 
	selectionChanged := false.
	operator selectAllIndexes: {2. 6. 9}.
	operator applyOn: holder.
	self assert: selectionChanged. 
	selectionChanged := false.
	operator selectOnlyIndex: 10.
	operator applyOn: holder.
	self assert: selectionChanged. 
	selectionChanged := false.
	operator selectOnlyIndex: 10.
	operator applyOn: holder.
	self deny: selectionChanged. 

]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectionChangedOnSelectOnlyIndexes [

	self deny: selectionChanged. 
	operator selectAllIndexes: {2. 6. 9}.
	operator applyOn: holder.
	self assert: selectionChanged. 
	selectionChanged := false.
	operator selectOnlyIndexes: {10. 6. 20}.
	operator applyOn: holder.
	self assert: selectionChanged. 
	selectionChanged := false.
	operator selectOnlyIndexes: {10. 6. 20}.
	operator applyOn: holder.
	self deny: selectionChanged 

]
