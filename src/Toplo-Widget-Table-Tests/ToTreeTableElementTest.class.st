Class {
	#name : #ToTreeTableElementTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'tree'
	],
	#category : #'Toplo-Widget-Table-Tests'
}

{ #category : #running }
ToTreeTableElementTest >> setUp [

	super setUp.
	tree := ToTreeTableElement new.
	tree columns: {
			(ToTableColumn new
				 title: 'Name';
				 key: 'yourself';
				 dataIndex: #yourself;
				 yourself). }.
	tree nodeManager childrenGetter: [ :dataItem |
			Array streamContents: [ :stream |
				dataItem do: [ :c | stream nextPut: c asSymbol ] ] ].
	tree dataAccessor addAll: { #AAA. #BBB. #CCC }.
	space root addChild: tree
]

{ #category : #'expanding-collapsing tests' }
ToTreeTableElementTest >> testCollapse [
	"The data source size decreases when collapsing a wrapper"

	| wrapper size |
	"get the second node wrapper"
	wrapper := tree dataSource at: 2.
	"expand it, then no event should be dispateched"
	size := tree dataSource size.
	wrapper expand.
	wrapper collapse.
	self deny: wrapper isExpanded.
	self assert: tree dataSource size equals: size.
	^ wrapper
]

{ #category : #'expanding-collapsing tests' }
ToTreeTableElementTest >> testCollapseWithSelectionBeforeCollapsedWrapper [

	" no selection changed event should be dispateched "

	| selChangedEvent wrapper size |
	selChangedEvent := nil.
	tree selecter selectIndex: 1.
	self waitTestingSpaces.
	tree
		addEventHandlerOn: ToListPrimarySelectionChangedEvent
		do: [ :event | selChangedEvent := event ].
	" get the second node wrapper "
	wrapper := tree dataSource at: 2.
	"expand it, then no event should be dispateched"
	size := tree dataSource size.
	wrapper expand.
	self assert: selChangedEvent isNil.
	self assert: tree selecter selectedIndexes equals: { 1 }.
	selChangedEvent := nil.
	wrapper collapse.
	self assert: wrapper isCollapsed.
	self assert: selChangedEvent isNil.
	self assert: tree selecter selectedIndexes equals: { 1 }
]

{ #category : #'expanding-collapsing tests' }
ToTreeTableElementTest >> testExpand [

	" the data source size increases when expanding a wrapper  "
	| wrapper size |
	" get the second node wrapper "
	wrapper := tree dataSource at: 2.
	"expand it, then no event should be dispateched"
	size := tree dataSource size.
	wrapper expand.
	self assert: wrapper isExpanded.
	self assert: tree dataSource size equals: size + 3.
	^ wrapper

]

{ #category : #'expanding-collapsing tests' }
ToTreeTableElementTest >> testExpandWithEmptySelection [

	| selChangedEvent wrapper size |
	selChangedEvent := nil.
	tree
		addEventHandlerOn: ToListPrimarySelectionChangedEvent
		do: [ :event | selChangedEvent := event ].
	" get the second node wrapper "
	wrapper := tree dataSource at: 2.
	"expand it, then no event should be dispateched"
	size := tree dataSource size.
	wrapper expand.
	self assert: wrapper isExpanded.
	self assert: tree dataSource size equals: size + 3.
	self assert: selChangedEvent isNil
]

{ #category : #'expanding-collapsing tests' }
ToTreeTableElementTest >> testExpandWithSelectionBeforeExpandedWrapper [

	| selChangedEvent wrapper size |
	selChangedEvent := nil.
	tree selecter selectIndex: 1.
	self waitTestingSpaces.
	tree
		addEventHandlerOn: ToListPrimarySelectionChangedEvent
		do: [ :event | selChangedEvent := event ].
	" get the second node wrapper "
	wrapper := tree dataSource at: 2.
	"expand it, then no event should be dispateched"
	size := tree dataSource size.
	wrapper expand.
	self assert: wrapper isExpanded.
	self assert: tree dataSource size equals: size + 3.
	self assert: selChangedEvent isNil.
	self assert: tree selecter selectedIndexes equals: { 1 }
]
