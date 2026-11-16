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

{ #category : #tests }
ToTableElementTest >> testDynamicAdditionPreservesColumnWidths [

	| tabPane table1 table2 tab2 |
	table1 := ToTableElement new.
	table1 columns: {
		(ToTableColumn new
			 title: 'Col 1';
			 yourself).
		(ToTableColumn new
			 title: 'Col 2';
			 yourself) }.
	table1 matchParent.

	table2 := ToTableElement new.
	table2 columns: {
		(ToTableColumn new
			 title: 'Col 1';
			 yourself).
		(ToTableColumn new
			 title: 'Col 2';
			 yourself) }.
	table2 matchParent.

	tabPane := ToTabPaneElement new.
	tabPane vertical: true.
	tabPane matchParent.
	tabPane itemBuilder: [ :button :data :holder |
		button label: (ToLabel text: data).
		button paneBuilder: [ :pane |
			data = 'Tab 1' ifTrue: [ pane addChild: table1 ].
			data = 'Tab 2' ifTrue: [ pane addChild: table2 ] ] ].
	tabPane addTabItemData: 'Tab 1'.
	tabPane addTabItemData: 'Tab 2'.

	space deferAndSettle: [ space root addChild: tabPane ].
	tab2 := tabPane dataSource second.
	tab2 eventSimulator click.
	space settle.

	self assert: table2 header cellContainers first width > 0.
	self assert: table2 header cellContainers second width > 0
]

{ #category : #tests }
ToTableElementTest >> testEnableTypeAheadForwardsToList [

	self deny: table list isTypeAheadEnabled.
	table enableTypeAhead.
	self assert: table list isTypeAheadEnabled.
	table disableTypeAhead.
	self deny: table list isTypeAheadEnabled
]

{ #category : #running }
ToTableElementTest >> testNumberOfColumn [

	| rows |
	self assert: table header nodeContainer middleContainer children size equals: 2.
	rows := table selectChildrenWithId: #row.
	self assert: rows isNotEmpty.
	rows do: [ :row | self assert: row children size equals: 2 ]
]
