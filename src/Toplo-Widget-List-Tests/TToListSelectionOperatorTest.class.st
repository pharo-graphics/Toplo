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
