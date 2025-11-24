"
A ToTableElementTest is a test class for testing the behavior of ToTableElement
"
Class {
	#name : #ToTableElementTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'table'
	],
	#category : #'Toplo-Widget-Table-Tests-Core'
}

{ #category : #running }
ToTableElementTest >> setUp [

	super setUp.
	table := ToTableElement new.
	space root addChild: table.
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
	self waitTestingSpaces
]

{ #category : #running }
ToTableElementTest >> testAddColumn [

	| rows |
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
				 yourself).
			(ToTableColumn new
				 title: 'Number of variables';
				 key: 'variables';
				 dataIndex: 'numberOfVariables';
				 yourself) }.
	self waitTestingSpaces.
	self assert: (table childWithId: #header) middleContainer children size equals: 3.
	rows := table selectChildrenWithId: #row.
	self assert: rows isNotEmpty.
	rows do: [ :row | self assert: row children size equals: 3 ]
]

{ #category : #running }
ToTableElementTest >> testAddElementInData [

	self assert: (table selectChildrenWithId: #row) size equals: 3.
	table dataAccessor addAll:
		(Smalltalk globals allClasses copyFrom: 4 to: 6).
	self waitTestingSpaces.
	self assert: (table selectChildrenWithId: #row) size equals: 6
]

{ #category : #running }
ToTableElementTest >> testNumberOfColumn [

	| rows |
	self assert: (table childWithId: #header) middleContainer children size equals: 2.
	rows := table selectChildrenWithId: #row.
	self assert: rows isNotEmpty.
	rows do: [ :row | self assert: row children size equals: 2 ]
]
