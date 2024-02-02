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

	operator selectAllIndexes: {2. 6. 9}.
	operator deselectAll.
	self assert: operator selectionModel isEmpty
]

{ #category : #tests }
TToListSelectionOperatorTest >> testDeselectAllIndexes [

	operator selectAllIndexes: {2. 6. 9}.
	operator deselectAllIndexes: {2. 6. 9}.
	self assert: operator selectionModel isEmpty
]

{ #category : #tests }
TToListSelectionOperatorTest >> testDeselectIndex [

	operator selectIndex: 2.
	operator deselectIndex: 2.
	self assert: operator selectionModel isEmpty
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
TToListSelectionOperatorTest >> testSelectAll [

	operator selectAll.
	self assert: operator selectionModel isNotEmpty.
	self assert: operator selectionModel to = operator dataSource size
]

{ #category : #tests }
TToListSelectionOperatorTest >> testSelectAllIndexes [

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
TToListSelectionOperatorTest >> testSelectOnlyIndex [

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
TToListSelectionOperatorTest >> testUninstallStrategy [

	self assert: (operator eventDispatcher handlers
			 detect: [ :h | h == operator selectionStrategy ]
			 ifNone: [  ]) notNil.
	operator uninstallStrategy: operator selectionStrategy.
	self assert: (operator eventDispatcher handlers
			 detect: [ :h | h == operator selectionStrategy ]
			 ifNone: [  ]) isNil
]
