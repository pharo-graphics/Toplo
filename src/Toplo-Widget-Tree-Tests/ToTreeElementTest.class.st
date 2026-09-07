Class {
	#name : #ToTreeElementTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'tree'
	],
	#category : #'Toplo-Widget-Tree-Tests-Core'
}

{ #category : #running }
ToTreeElementTest >> setUp [

	super setUp.
	tree := ToTreeElement new.
	tree childrenGetter: [ :dataItem |
			Array streamContents: [ :stream |
				dataItem do: [ :c | stream nextPut: c asSymbol ] ] ].
	space deferAndSettle: [
		tree dataAccessor addAll: { #AAA. #BBB. #CCC }.
		space root addChild: tree ]
]

{ #category : #'expanding-collapsing tests' }
ToTreeElementTest >> testCollapse [
	"The data source size decreases when collapsing a wrapper"

	| wrapper size |
	"get the second node wrapper"
	wrapper := tree dataSource second.
	"expand it, then no event should be dispateched"
	size := tree dataSource size.
	space deferAndSettle: [
		wrapper expand.
		wrapper collapse ].
	self deny: wrapper isExpanded.
	self assert: tree dataSource size equals: size
]

{ #category : #'expanding-collapsing tests' }
ToTreeElementTest >> testCollapseWithDirectCollapsedWrapperChildrenSelected [

	" one selection changed event should be dispateched when a collapsed wrapper
	has selected children "
	| selChangedEvent wrapper |
	selChangedEvent := nil.
	space deferAndSettle: [ tree selecter deselectAll ].
	tree
		addEventHandlerOn: ToListPrimarySelectionChangedEvent
		do: [ :event | selChangedEvent := event ].
	" get the second node wrapper "
	wrapper := tree dataSource second.
	"expand it, then no event should be dispateched"
	space deferAndSettle: [ wrapper expand ].
	" selection of the first expanded wrapper child "
	self assert: tree selecter selectedIndexes equals: {  }.
	selChangedEvent := nil.
	space deferAndSettle: [ tree selecter selectIndex: 3 ].
	self assert: tree selecter selectedIndexes equals: { 3 }.
	self assert: selChangedEvent notNil.
	selChangedEvent := nil.
	space deferAndSettle: [ wrapper collapse ].
	self assert: selChangedEvent notNil.
	self assert: selChangedEvent selectedIndexes equals: {  }.
	self assert: tree selecter selectedIndexes equals: {  }
]

{ #category : #'expanding-collapsing tests' }
ToTreeElementTest >> testCollapseWithSelectionAfterCollapsedWrapper [
	" no selection changed event should be dispateched "

	| selChangedEvent wrapper size count |
	selChangedEvent := nil.
	space deferAndSettle: [ tree selecter selectIndex: 3 ].
	count := 0.
	tree
		addEventHandlerOn: ToListPrimarySelectionChangedEvent
		do: [ :event |
				count := count + 1.
				selChangedEvent := event ].
	" get the second node wrapper "
	wrapper := tree dataSource second.
	"expand it, then no event should be dispateched"
	size := tree dataSource size.
	space deferAndSettle: [ wrapper expand ].
	self assert: count equals: 1.
	self assert: selChangedEvent notNil.
	self assert: tree selecter selectedIndexes equals: { 6 }.
	selChangedEvent := nil.
	space deferAndSettle: [ wrapper collapse ].
	self assert: wrapper isCollapsed.
	self assert: count equals: 2.
	self assert: selChangedEvent notNil.
	self assert: tree selecter selectedIndexes equals: { 3 }
]

{ #category : #'expanding-collapsing tests' }
ToTreeElementTest >> testCollapseWithSelectionBeforeCollapsedWrapper [

	" no selection changed event should be dispateched "

	| selChangedEvent wrapper size |
	selChangedEvent := nil.
	space deferAndSettle: [ tree selecter selectIndex: 1 ].
	tree
		addEventHandlerOn: ToListPrimarySelectionChangedEvent
		do: [ :event | selChangedEvent := event ].
	" get the second node wrapper "
	wrapper := tree dataSource second.
	"expand it, then no event should be dispateched"
	size := tree dataSource size.
	space deferAndSettle: [ wrapper expand ].
	self assert: selChangedEvent isNil.
	self assert: tree selecter selectedIndexes equals: { 1 }.
	selChangedEvent := nil.
	space deferAndSettle: [ wrapper collapse ].
	self assert: wrapper isCollapsed.
	self assert: selChangedEvent isNil.
	self assert: tree selecter selectedIndexes equals: { 1 }
]

{ #category : #'expanding-collapsing tests' }
ToTreeElementTest >> testCollapseWithSubSubCollapsedWrapperChildrenSelected [
	" one selection changed event should be dispateched when a collapsed wrapper
	has selected children "

	| selChangedEvent wrapper subWrapper |
	selChangedEvent := nil.
	space deferAndSettle: [ tree selecter deselectAll ].
	tree
		addEventHandlerOn: ToListPrimarySelectionChangedEvent
		do: [ :event | selChangedEvent := event ].
	" get the second node wrapper "
	wrapper := tree dataSource second.
	"expand it, then no event should be dispateched"
	space deferAndSettle: [ wrapper expand ].
	"get the expanded wrapper first child wrapper"
	subWrapper := tree dataSource third.
	self assert: subWrapper parentWrapper equals: wrapper.

	space deferAndSettle: [ subWrapper expand ].
	" selection of the first child wrapper of the subwrapper "
	self assert: tree dataSource fourth parentWrapper equals: subWrapper.
	selChangedEvent := nil.
	space deferAndSettle: [ tree selecter selectIndex: 4 ].
	self assert: selChangedEvent notNil.
	self assert: tree selecter selectedIndexes equals: { 4 }.
	selChangedEvent := nil.
	space deferAndSettle: [ wrapper collapse ].
	self assert: selChangedEvent notNil.
	self assert: selChangedEvent selectedIndexes equals: {  }.
	self assert: tree selecter selectedIndexes equals: {  }
]

{ #category : #'expanding-collapsing tests' }
ToTreeElementTest >> testExpand [

	" the data source size increases when expanding a wrapper  "
	| wrapper size |
	" get the second node wrapper "
	wrapper := tree dataSource second.
	"expand it, then no event should be dispateched"
	size := tree dataSource size.
	space deferAndSettle: [ wrapper expand ].
	self assert: wrapper isExpanded.
	self assert: tree dataSource size equals: size + 3
]

{ #category : #'expanding-collapsing tests' }
ToTreeElementTest >> testExpandWithEmptySelection [

	| selChangedEvent wrapper size |
	selChangedEvent := nil.
	tree
		addEventHandlerOn: ToListPrimarySelectionChangedEvent
		do: [ :event | selChangedEvent := event ].
	" get the second node wrapper "
	wrapper := tree dataSource second.
	"expand it, then no event should be dispateched"
	size := tree dataSource size.
	space deferAndSettle: [ wrapper expand ].
	self assert: wrapper isExpanded.
	self assert: tree dataSource size equals: size + 3.
	self assert: selChangedEvent isNil
]

{ #category : #'expanding-collapsing tests' }
ToTreeElementTest >> testExpandWithSelectionAfterExpandedWrapper [

	| selChangedEvent wrapper size count |
	selChangedEvent := nil.
	space deferAndSettle: [ tree selecter selectIndex: 3 ].
	count := 0.
	tree
		addEventHandlerOn: ToListPrimarySelectionChangedEvent
		do: [ :event |
				count := count + 1.
				selChangedEvent := event ].
	" get the second node wrapper "
	wrapper := tree dataSource second.
	"expand it, then no event should be dispateched"
	size := tree dataSource size.
	space deferAndSettle: [ wrapper expand ].
	self assert: wrapper isExpanded.
	self assert: tree dataSource size equals: size + 3.
	self assert: count equals: 1.
	self assert: selChangedEvent notNil.
	self assert: tree selecter selectedIndexes equals: { 6 }
]

{ #category : #'expanding-collapsing tests' }
ToTreeElementTest >> testExpandWithSelectionBeforeExpandedWrapper [

	| selChangedEvent wrapper size |
	selChangedEvent := nil.
	space deferAndSettle: [ tree selecter selectIndex: 1 ].
	tree
		addEventHandlerOn: ToListPrimarySelectionChangedEvent
		do: [ :event | selChangedEvent := event ].
	" get the second node wrapper "
	wrapper := tree dataSource second.
	"expand it, then no event should be dispateched"
	size := tree dataSource size.
	space deferAndSettle: [ wrapper expand ].
	self assert: wrapper isExpanded.
	self assert: tree dataSource size equals: size + 3.
	self assert: selChangedEvent isNil.
	self assert: tree selecter selectedIndexes equals: { 1 }
]
