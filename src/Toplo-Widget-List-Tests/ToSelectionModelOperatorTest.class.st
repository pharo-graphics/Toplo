Class {
	#name : #ToSelectionModelOperatorTest,
	#superclass : #TestCase,
	#instVars : [
		'holder',
		'selecter',
		'selectionChanged'
	],
	#category : #'Toplo-Widget-List-Tests-Selection-Command'
}

{ #category : #running }
ToSelectionModelOperatorTest >> setUp [

	super setUp.
	selectionChanged := false.
	holder := ToSelectionModelHolderForTest new.
	holder addEventHandler: (BlEventHandler
			 on: ToListSelectionChangedEvent
			 do: [ :event | selectionChanged := true ]).
	selecter := holder selecter
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testDeselectAll [

	selecter selectAllIndexes: {2. 6. 9}.
	selecter deselectAll.
	self assert: holder selectionModel isEmpty
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testDeselectAllIndexes [

	selecter selectAllIndexes: {2. 6. 9}.
	self assert: holder selectionModel indices size equals: 3.
	self assert: holder selectionModel indices asSet equals: {2. 6. 9} asSet.	
	selecter deselectAllIndexes: {2. 6. 9}.
	self assert: holder selectionModel isEmpty 
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testDeselectIndex [

	selecter selectIndex: 2.
	self assert: holder selectionModel indices size equals: 1.
	self assert: holder selectionModel indices asSet equals: {2} asSet.	
	selecter deselectIndex: 2.
	self assert: holder selectionModel isEmpty
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testDispatchEventForCommand [

	| selChangedEvent selRequestEvent cmd |
	holder addEventHandler: (BlEventHandler
			 on: ToListSelectionChangedEvent
			 do: [ :event | selChangedEvent := event ]).
	holder addEventHandler: (BlEventHandler
			 on: ToSelectionRequestEvent
			 do: [ :event | selRequestEvent := event ]).

	selecter dispatchEventForCommand:
		(cmd := ToWholeSelectionCommand new
			        operation: ToAddSelectionOperation new;
			        yourself).
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

	selecter selectAllIndexes: { 2. 6. 9 }.
	self assert: selChangedEvent notNil.
	self assert: holder selectionModel equals: selecter selectionModel.

	selChangedEvent := nil.
	" no change "
	selecter selectAllIndexes: { 2. 6. 9 }.
	self assert: selChangedEvent isNil.

	" incompatible mode "
	holder selectionMode: ToListNoneSelectionMode new.
	self
		should: [ selecter selectAllIndexes: { 2. 6. 9 } ]
		raise: ToIncompatibleMode.
	self assert: selChangedEvent isNil
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testIncompatibleMode [

	holder selectionMode: ToListNoneSelectionMode new.
	self should: [selecter selectAllIndexes: {2. 6. 9} ] raise: ToIncompatibleMode.
	self should: [selecter deselectAllIndexes: {2. 6. 9} ] raise: ToIncompatibleMode.
	self should: [selecter selectIndex: 2 ] raise: ToIncompatibleMode.
	self should: [selecter deselectIndex: 2 ] raise: ToIncompatibleMode.
	self should: [selecter selectAll ] raise: ToIncompatibleMode.
	self should: [selecter deselectAll ] raise: ToIncompatibleMode
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testIncompatibleMode2 [

	holder selectionMode: ToListSingleSelectionMode new.
	self should: [selecter selectAllIndexes: {2. 6. 9} ] raise: ToIncompatibleMode.
	self should: [selecter deselectAllIndexes: {2. 6. 9} ] raise: ToIncompatibleMode.
	selecter selectIndex: 2.
	selecter deselectIndex: 2.
	self should: [selecter selectAll ] raise: ToIncompatibleMode.
	self should: [selecter deselectAll ] raise: ToIncompatibleMode
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testOnSelectionRequestError [

	holder selectionMode: ToListSingleSelectionMode new.
	self should: [selecter selectAllIndexes: {2. 6. 9} ] raise: ToIncompatibleMode
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testOnSelectionRequestSuccess [

	selecter selectAllIndexes: { 2. 6. 9 }.
	self assert: holder successfulCommand notNil.
	holder successfulCommand: nil.
	" no change "
	selecter selectAllIndexes: { 2. 6. 9 }.
	self assert: holder successfulCommand isNil.
	
	holder selectionMode: ToListNoneSelectionMode new.
	holder successfulCommand: nil.
	self
		should: [ selecter selectAllIndexes: { 2. 6. 9 } ]
		raise: ToIncompatibleMode.
	self assert: holder successfulCommand isNil.

]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectAll [

	selecter selectAll.
	self assert: holder selectionModel isNotEmpty.
	selecter selectAll.
	self
		assert: holder selectionModel isWholeSelectionModel
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectAllIndexes [

	selecter selectAllIndexes: {2. 6. 9}.
	self assert: holder selectionModel indices size equals: 3.
	self assert: holder selectionModel indices asSet equals: {2. 6. 9} asSet
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectIndex [

	selecter selectIndex: 2.
	self assert: selecter selectionModel indices size equals: 1.
	self assert: selecter selectionModel indices first equals: 2
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectIndexTo [

	selecter selectIndex: 2 to: 10.
	self assert: selecter selectionModel indices size equals: 9.
	self assert: selecter selectionModel indices asSet equals: (2 to: 10) asSet
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectOnlyIndex [

	selecter deselectAll.
	selecter selectAllIndexes: {2. 6. 9}.
	self assert: selecter selectionModel indices asSet equals: {2. 6. 9} asSet.
	selecter selectOnlyIndex: 10.
	self assert: selecter selectionModel indices asSet equals: {10} asSet.
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectOnlyIndexes [

	selecter selectAllIndexes: {2. 6. 9}.
	self assert: selecter selectionModel indices asSet equals: {2. 6. 9} asSet.
	selecter selectOnlyIndexes: {10. 6. 20}.
	self assert: selecter selectionModel indices asSet equals: {10. 6. 20} asSet.
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectionChanged [

	selecter selectAllIndexes: {2. 6. 9}.
	self assert: selectionChanged. 

]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectionChangedOnDeselectAll [

	selecter selectAllIndexes: {2. 6. 9}.
	self assert: selectionChanged. 
	selectionChanged := false.
	selecter deselectAll.
	self assert: selectionChanged.
	selectionChanged := false.
	selecter deselectAll.
	self deny: selectionChanged
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectionChangedOnDeselectAllIndexes [

	self deny: selectionChanged. 
	selecter selectAllIndexes: {2. 6. 9}.
	self assert: selectionChanged. 
	selectionChanged := false.
	selecter deselectAllIndexes: {2. 6. 9}.
	self assert: selectionChanged. 
	selectionChanged := false.
	selecter deselectAllIndexes: {2. 6. 9}.
	self deny: selectionChanged. 

]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectionChangedOnDeselectIndex [

	selecter selectIndex: 2.
	self assert: selectionChanged. 
	selectionChanged := false.
	selecter deselectIndex: 2.
	self assert: selectionChanged. 
	selectionChanged := false.
	selecter deselectIndex: 2.
	self deny: selectionChanged. 

]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectionChangedOnSelectAll [

	self deny: selectionChanged. 
	selecter selectAll.
	self assert: selectionChanged. 
	selectionChanged := false.
	selecter selectAll.
	self deny: selectionChanged. 

]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectionChangedOnSelectAllIndexes [

	self deny: selectionChanged. 
	selecter selectAllIndexes: {2. 6. 9}.
	self assert: selectionChanged. 
	selectionChanged := false.
	selecter selectAllIndexes: {2. 6. 9}.
	self deny: selectionChanged. 

]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectionChangedOnSelectIndex [

	self deny: selectionChanged. 
	selecter selectIndex: 2.
	self assert: selectionChanged. 
	selectionChanged := false.
	selecter selectIndex: 2.
	self deny: selectionChanged. 


]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectionChangedOnSelectOnlyIndex [

	self deny: selectionChanged. 
	selecter deselectAll.
	self deny: selectionChanged. 
	selectionChanged := false.
	selecter selectAllIndexes: {2. 6. 9}.
	self assert: selectionChanged. 
	selectionChanged := false.
	selecter selectOnlyIndex: 10.
	self assert: selectionChanged. 
	selectionChanged := false.
	selecter selectOnlyIndex: 10.
	self deny: selectionChanged. 

]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectionChangedOnSelectOnlyIndexes [

	self deny: selectionChanged. 
	selecter selectAllIndexes: {2. 6. 9}.
	self assert: selectionChanged. 
	selectionChanged := false.
	selecter selectOnlyIndexes: {10. 6. 20}.
	self assert: selectionChanged. 
	selectionChanged := false.
	selecter selectOnlyIndexes: {10. 6. 20}.
	self deny: selectionChanged 

]
