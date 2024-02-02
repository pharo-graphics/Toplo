Class {
	#name : #TToListSelectionOperatorTest,
	#superclass : #TestCase,
	#instVars : [
		'operator'
	],
	#category : #'Toplo-Widget-List-Tests-Selection-Command'
}

{ #category : #running }
TToListSelectionOperatorTest >> setUp [ 

	super setUp.
	operator := ToListSelectionOperatorForTest new.
]

{ #category : #tests }
TToListSelectionOperatorTest >> testDeselectAll [

	self deny: operator selectionHasChanged. 
	operator selectAllIndexes: {2. 6. 9}.
	operator deselectAll.
	self assert: operator selectionModel isEmpty
]

{ #category : #tests }
TToListSelectionOperatorTest >> testDeselectAllIndexes [

	self deny: operator selectionHasChanged. 
	operator selectAllIndexes: {2. 6. 9}.
	self assert: operator selectionModel indices size equals: 3.
	self assert: operator selectionModel indices asSet equals: {2. 6. 9} asSet.	
	operator deselectAllIndexes: {2. 6. 9}.
	self assert: operator selectionModel isEmpty 
]

{ #category : #tests }
TToListSelectionOperatorTest >> testDeselectIndex [

	operator selectIndex: 2.
	self assert: operator selectionModel indices size equals: 1.
	self assert: operator selectionModel indices asSet equals: {2} asSet.	
	operator deselectIndex: 2.
	self assert: operator selectionModel isEmpty
]

{ #category : #tests }
TToListSelectionOperatorTest >> testDispatchEventForCommand [


	| selChangedEvent selRequestEvent cmd |
	operator addEventHandler: (BlEventHandler
			 on: ToListSelectionChangedEvent
			 do: [ :event | selChangedEvent := event ]).
	operator addEventHandler: (BlEventHandler
			 on: ToSelectionRequestEvent
			 do: [ :event | selRequestEvent := event ]).

	operator dispatchEventForCommand:
		(cmd := (ToWholeSelectionCommand new operation: ToAddSelectionOperation new)).
	self assert: operator selectionModel isNotEmpty.
	self assert: operator selectionModel to = operator dataSource size.
	self assert: selChangedEvent notNil.
	self assert: selRequestEvent notNil.
	self assert: selRequestEvent command == cmd.

]

{ #category : #tests }
TToListSelectionOperatorTest >> testDispatchSelectionChanged [

	| selChangedEvent |
	operator addEventHandler: (BlEventHandler
			 on: ToListSelectionChangedEvent
			 do: [ :event | selChangedEvent := event ]).

	operator selectAllIndexes: { 2. 6. 9 }.
	self assert: selChangedEvent notNil.
	self assert: selChangedEvent selectionModel = operator selectionModel.
	
	selChangedEvent := nil.
	" no change "
	operator selectAllIndexes: { 2. 6. 9 }.
	self assert: selChangedEvent isNil.
	
	" incompatible mode "
	operator selectionStrategy mode: ToListNoneSelectionMode new.
	self
		should: [ operator selectAllIndexes: { 2. 6. 9 } ]
		raise: ToIncompatibleMode.
	self assert: selChangedEvent isNil
]

{ #category : #tests }
TToListSelectionOperatorTest >> testIncompatibleMode [

	operator selectionStrategy mode: ToListNoneSelectionMode new.
	self should: [operator selectAllIndexes: {2. 6. 9} ] raise: ToIncompatibleMode.
	self should: [operator deselectAllIndexes: {2. 6. 9} ] raise: ToIncompatibleMode.
	self should: [operator selectIndex: 2 ] raise: ToIncompatibleMode.
	self should: [operator deselectIndex: 2 ] raise: ToIncompatibleMode.
	self should: [operator selectAll ] raise: ToIncompatibleMode.
	self should: [operator deselectAll ] raise: ToIncompatibleMode
]

{ #category : #tests }
TToListSelectionOperatorTest >> testIncompatibleMode2 [

	operator selectionStrategy mode: ToListSingleSelectionMode new.
	self should: [operator selectAllIndexes: {2. 6. 9} ] raise: ToIncompatibleMode.
	self should: [operator deselectAllIndexes: {2. 6. 9} ] raise: ToIncompatibleMode.
	operator selectIndex: 2.
	operator deselectIndex: 2.
	self should: [operator selectAll ] raise: ToIncompatibleMode.
	self should: [operator deselectAll ] raise: ToIncompatibleMode
]

{ #category : #tests }
TToListSelectionOperatorTest >> testInstallStrategy [

	| strategy |
	operator uninstallStrategy: operator selectionStrategy.
	operator installStrategy: (strategy := ToListSelectionStrategy new).
	self assert: (operator eventDispatcher handlers
			 detect: [ :h | h == operator selectionStrategy ]
			 ifNone: [  ]) isNil.
	self assert: (operator eventDispatcher handlers
			 detect: [ :h | h == strategy ]
			 ifNone: [  ]) notNil.
	

]

{ #category : #tests }
TToListSelectionOperatorTest >> testOnSelectionRequestError [

	operator selectionStrategy mode: ToListSingleSelectionMode new.
	self should: [operator selectAllIndexes: {2. 6. 9} ] raise: ToIncompatibleMode
]

{ #category : #tests }
TToListSelectionOperatorTest >> testOnSelectionRequestSuccess [

	operator selectAllIndexes: { 2. 6. 9 }.
	self assert: operator successfulCommand notNil.
	operator successfulCommand: nil.
	" no change "
	operator selectAllIndexes: { 2. 6. 9 }.
	self assert: operator successfulCommand isNil.
	
	operator selectionStrategy mode: ToListNoneSelectionMode new.
	operator successfulCommand: nil.
	self
		should: [ operator selectAllIndexes: { 2. 6. 9 } ]
		raise: ToIncompatibleMode.
	self assert: operator successfulCommand isNil.

]

{ #category : #tests }
TToListSelectionOperatorTest >> testSelectAll [

	operator selectAll.
	self assert: operator selectionModel isNotEmpty.
	operator selectAll.
	self assert: operator selectionModel to = operator dataSource size
]

{ #category : #tests }
TToListSelectionOperatorTest >> testSelectAllIndexes [

	self deny: operator selectionHasChanged. 
	operator selectAllIndexes: {2. 6. 9}.
	self assert: operator selectionModel indices size equals: 3.
	self assert: operator selectionModel indices asSet equals: {2. 6. 9} asSet
]

{ #category : #tests }
TToListSelectionOperatorTest >> testSelectIndex [

	operator selectIndex: 2.
	self assert: operator selectionModel indices size equals: 1.
	self assert: operator selectionModel indices first equals: 2
]

{ #category : #tests }
TToListSelectionOperatorTest >> testSelectIndexTo [

	operator selectIndex: 2 to: 10.
	self assert: operator selectionModel indices size equals: 9.
	self assert: operator selectionModel indices asSet equals: (2 to: 10) asSet
]

{ #category : #tests }
TToListSelectionOperatorTest >> testSelectOnlyIndex [

	operator deselectAll.
	operator selectAllIndexes: {2. 6. 9}.
	self assert: operator selectionModel indices asSet equals: {2. 6. 9} asSet.
	operator selectOnlyIndex: 10.
	self assert: operator selectionModel indices asSet equals: {10} asSet.
]

{ #category : #tests }
TToListSelectionOperatorTest >> testSelectOnlyIndexes [

	operator selectAllIndexes: {2. 6. 9}.
	self assert: operator selectionModel indices asSet equals: {2. 6. 9} asSet.
	operator selectOnlyIndexes: {10. 6. 20}.
	self assert: operator selectionModel indices asSet equals: {10. 6. 20} asSet.
]

{ #category : #tests }
TToListSelectionOperatorTest >> testSelectionChanged [

	self deny: operator selectionHasChanged. 
	operator selectAllIndexes: {2. 6. 9}.
	self assert: operator selectionHasChanged. 

]

{ #category : #tests }
TToListSelectionOperatorTest >> testSelectionChangedOnDeselectAll [

	self deny: operator selectionHasChanged. 
	operator selectAllIndexes: {2. 6. 9}.
	self assert: operator selectionHasChanged. 
	operator deselectAll.
	self assert: operator selectionHasChanged.
	operator deselectAll.
	self deny: operator selectionHasChanged
]

{ #category : #tests }
TToListSelectionOperatorTest >> testSelectionChangedOnDeselectAllIndexes [

	self deny: operator selectionHasChanged. 
	operator selectAllIndexes: {2. 6. 9}.
	self assert: operator selectionHasChanged. 
	operator deselectAllIndexes: {2. 6. 9}.
	self assert: operator selectionHasChanged. 
	operator deselectAllIndexes: {2. 6. 9}.
	self deny: operator selectionHasChanged. 

]

{ #category : #tests }
TToListSelectionOperatorTest >> testSelectionChangedOnDeselectIndex [

	operator selectIndex: 2.
	self assert: operator selectionHasChanged. 
	operator deselectIndex: 2.
	self assert: operator selectionHasChanged. 
	operator deselectIndex: 2.
	self deny: operator selectionHasChanged. 

]

{ #category : #tests }
TToListSelectionOperatorTest >> testSelectionChangedOnSelectAll [

	self deny: operator selectionHasChanged. 
	operator selectAll.
	self assert: operator selectionHasChanged. 
	operator selectAll.
	self deny: operator selectionHasChanged. 

]

{ #category : #tests }
TToListSelectionOperatorTest >> testSelectionChangedOnSelectAllIndexes [

	self deny: operator selectionHasChanged. 
	operator selectAllIndexes: {2. 6. 9}.
	self assert: operator selectionHasChanged. 
	operator selectAllIndexes: {2. 6. 9}.
	self deny: operator selectionHasChanged. 

]

{ #category : #tests }
TToListSelectionOperatorTest >> testSelectionChangedOnSelectIndex [

	self deny: operator selectionHasChanged. 
	operator selectIndex: 2.
	self assert: operator selectionHasChanged. 
	operator selectIndex: 2.
	self deny: operator selectionHasChanged. 


]

{ #category : #tests }
TToListSelectionOperatorTest >> testSelectionChangedOnSelectOnlyIndex [

	self deny: operator selectionHasChanged. 
	operator deselectAll.
	self deny: operator selectionHasChanged. 
	operator selectAllIndexes: {2. 6. 9}.
	self assert: operator selectionHasChanged. 
	operator selectOnlyIndex: 10.
	self assert: operator selectionHasChanged. 
	operator selectOnlyIndex: 10.
	self deny: operator selectionHasChanged. 

]

{ #category : #tests }
TToListSelectionOperatorTest >> testSelectionChangedOnSelectOnlyIndexes [

	self deny: operator selectionHasChanged. 
	operator selectAllIndexes: {2. 6. 9}.
	self assert: operator selectionHasChanged. 
	operator selectOnlyIndexes: {10. 6. 20}.
	self assert: operator selectionHasChanged. 
	operator selectOnlyIndexes: {10. 6. 20}.
	self deny: operator selectionHasChanged. 

]

{ #category : #tests }
TToListSelectionOperatorTest >> testUninstallStrategy [

	self assert: (operator eventDispatcher handlers
			 detect: [ :h | h == operator selectionStrategy ]
			 ifNone: [  ]) notNil.
	operator uninstallStrategy: operator selectionStrategy.
	self assert: (operator eventDispatcher handlers
			 detect: [ :h | h == operator selectionStrategy ]
			 ifNone: [  ]) isNil
]
