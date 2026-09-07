"
A ToTableElementTest is a test class for testing the behavior of ToTableElement
"
Class {
	#name : #ToTableElementTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'table'
	],
	#category : #'Toplo-Widget-Table-Tests'
}

{ #category : #running }
ToTableElementTest >> setUp [

	super setUp.
	table := ToTableElement new.
	table columns: {
			(ToTableColumn new
				 title: 'Name';
				 key: 'name';
				 dataIndex: 'name';
				 yourself).
			(ToTableColumn new
				 title: 'Number of methods';
				 key: 'methods';
				 dataIndex: 'numberOfMethods';
				 yourself) }.
	table dataAccessor addAll:
		(Smalltalk globals allClasses copyFrom: 1 to: 3).

	space deferAndSettle: [ space root addChild: table ]
]

{ #category : #running }
ToTableElementTest >> testAddColumn [

	| rows |
	space deferAndSettle: [
		table columns: {
			(ToTableColumn new
				 title: 'Name 2';
				 key: 'name';
				 dataIndex: 'name';
				 yourself).
			(ToTableColumn new
				 title: 'Number of methods 2';
				 key: 'methods';
				 dataIndex: 'numberOfMethods';
				 yourself).
			(ToTableColumn new
				 title: 'Number of variables 2';
				 key: 'variables';
				 dataIndex: 'numberOfVariables';
				 yourself) } ].
	self
		assert: table header nodeContainer middleContainer children size
		equals: 3.

	rows := table selectChildrenWithId: #row.
	self assert: rows isNotEmpty.
	rows do: [ :row | self assert: row children size equals: 3 ]
]

{ #category : #running }
ToTableElementTest >> testAddElementInData [

	self assert: (table selectChildrenWithId: #row) size equals: 3.

	space deferAndSettle: [
		table dataAccessor addAll: { Number. Float. Integer } ].
	self assert: (table selectChildrenWithId: #row) size equals: 6
]

{ #category : #running }
ToTableElementTest >> testNumberOfColumn [

	| rows |
	self assert: table header nodeContainer middleContainer children size equals: 2.
	rows := table selectChildrenWithId: #row.
	self assert: rows isNotEmpty.
	rows do: [ :row | self assert: row children size equals: 2 ]
]
