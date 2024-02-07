Class {
	#name : #ToSelectionModelSelecterTest,
	#superclass : #TestCase,
	#instVars : [
		'holder',
		'selectionChanged',
		'selecter'
	],
	#category : #'Toplo-Widget-List-Tests-Selection-Updater'
}

{ #category : #running }
ToSelectionModelSelecterTest >> setUp [

	super setUp.
	selectionChanged := false.
	holder := ToSelectionModelHolderForTest new.
	holder data addAll: (1 to: 1000).
	holder addEventHandler: (BlEventHandler
			 on: ToListSelectionChangedEvent
			 do: [ :event | selectionChanged := true ]).
	selecter := holder selecter
]

{ #category : #tests }
ToSelectionModelSelecterTest >> testAddCommand [

	| selChangedEvent selRequestEvent cmd |
	holder addEventHandler: (BlEventHandler
			 on: ToListSelectionChangedEvent
			 do: [ :event | selChangedEvent := event ]).
	holder addEventHandler: (BlEventHandler
			 on: ToSelectionRequestEvent
			 do: [ :event | selRequestEvent := event ]).

	selecter addCommand: (cmd := ToWholeSelectionCommand new
			        operation: ToAddSelectionOperation new;
			        yourself).
	selecter apply.
	self assert: holder selectionModel isNotEmpty.
	self assert: selChangedEvent notNil.
	self assert: selRequestEvent notNil.
	self assert: selRequestEvent command identicalTo: cmd
]

{ #category : #tests }
ToSelectionModelSelecterTest >> testDeselectAll [

	selecter selectAllIndexes: {2. 6. 9}.
	selecter deselectAll.
	selecter apply.
	self assert: holder selectionModel isEmpty
]

{ #category : #tests }
ToSelectionModelSelecterTest >> testDeselectAllIndexes [

	selecter selectAllIndexes: {2. 6. 9}.
	selecter deselectAllIndexes: {2. 6. 9}.
	selecter apply.
	self assert: holder selectionModel isEmpty 
]

{ #category : #tests }
ToSelectionModelSelecterTest >> testDeselectIndex [

	selecter selectIndex: 2.
	selecter deselectIndex: 2.
	selecter apply.
	self assert: holder selectionModel isEmpty
]

{ #category : #tests }
ToSelectionModelSelecterTest >> testDispatchSelectionChanged [

	| selChangedEvent |
	holder addEventHandler: (BlEventHandler
			 on: ToListSelectionChangedEvent
			 do: [ :event | selChangedEvent := event ]).

	selecter selectAllIndexes: { 2. 6. 9 }.
	selecter apply.
	self assert: selChangedEvent notNil.

	selChangedEvent := nil.
	" no change "
	selecter selectAllIndexes: { 2. 6. 9 }.
	selecter apply.
	self assert: selChangedEvent isNil
]

{ #category : #tests }
ToSelectionModelSelecterTest >> testSelectAll [

	selecter selectAll.
	selecter apply.
	self assert: holder selectionModel isNotEmpty.
	self
		assert: holder selectionModel isWholeSelectionModel
]

{ #category : #tests }
ToSelectionModelSelecterTest >> testSelectAllIndexes [

	selecter selectAllIndexes: {2. 6. 9}.
	selecter apply.
	self assert: holder selectionModel selectedIndexes size equals: 3.
	self assert: holder selectionModel selectedIndexes asSet equals: {2. 6. 9} asSet
]

{ #category : #tests }
ToSelectionModelSelecterTest >> testSelectIndex [

	selecter selectIndex: 2.
	selecter apply.
	self assert: holder selectionModel selectedIndexes size equals: 1.
	self assert: holder selectionModel selectedIndexes first equals: 2
]

{ #category : #tests }
ToSelectionModelSelecterTest >> testSelectIndexTo [

	selecter selectIndex: 2 to: 10.
	selecter apply.
	self assert: holder selectionModel selectedIndexes size equals: 9.
	self assert: holder selectionModel selectedIndexes asSet equals: (2 to: 10) asSet
]

{ #category : #tests }
ToSelectionModelSelecterTest >> testSelectOnlyIndex [

	selecter deselectAll.
	selecter selectAllIndexes: {2. 6. 9}.
	selecter selectOnlyIndex: 10.
	selecter apply.
	self assert: holder selectionModel selectedIndexes asSet equals: {10} asSet.
]

{ #category : #tests }
ToSelectionModelSelecterTest >> testSelectOnlyIndexes [

	selecter selectAllIndexes: {2. 6. 9}.
	selecter selectOnlyIndexes: {10. 6. 20}.
	selecter apply.
	self assert: holder selectionModel selectedIndexes asSet equals: {10. 6. 20} asSet.
]

{ #category : #tests }
ToSelectionModelSelecterTest >> testSelectionChanged [

	selecter selectAllIndexes: {2. 6. 9}.
	selecter apply.
	self assert: selectionChanged. 

]

{ #category : #tests }
ToSelectionModelSelecterTest >> testSelectionChangedOnDeselectAll [

	selectionChanged := false.
	selecter selectAllIndexes: {2. 6. 9}.
	selecter apply.
	selecter deselectAll.
	selecter apply.
	self assert: selectionChanged
]

{ #category : #tests }
ToSelectionModelSelecterTest >> testSelectionChangedOnDeselectAll2 [

	selectionChanged := false.
	selecter selectAllIndexes: {2. 6. 9}.
	selecter apply.
	selecter deselectAll.
	selecter deselectAll.
	selecter apply.
	self assert: selectionChanged
]
