"
A ToAbstractListElementTest is a test class for testing the behavior of ToAbstractListElement
"
Class {
	#name : #ToSpecificListElementTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'l'
	],
	#category : #'Toplo-Widget-List-Tests-Core-ListElement'
}

{ #category : #running }
ToSpecificListElementTest >> setUp [ 

	super setUp.
	l := ToSpecificListElementForTest new
]

{ #category : #tests }
ToSpecificListElementTest >> testDisabledWithFiveNodes [

	l dataAccessor add: 'first'.
	space root addChild: l.
	self waitTestingSpaces.
	l innerElement firstChild disabled: true.
	l dataAccessor addFirst: 'second'.
	l dataAccessor add: 'third'.
	l dataAccessor add: 'fourth' afterIndex: 2.
	l dataAccessor addFirst: 'fifth'.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 3 }
]

{ #category : #tests }
ToSpecificListElementTest >> testDisabledWithFourNodes [

	l dataAccessor add: 'first'.
	space root addChild: l.
	self waitTestingSpaces.
	l innerElement firstChild disabled: true.
	l dataAccessor addFirst: 'second'.
	l dataAccessor add: 'third'.
	l dataAccessor add: 'fourth' afterIndex: 2.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }
]

{ #category : #tests }
ToSpecificListElementTest >> testDisabledWithFourNodes2 [

	space root addChild: l.
	l dataAccessor add: 'first'.
	l dataAccessor add: 'second'.
	self waitTestingSpaces.
	l nodes second disabled: true.
	l dataAccessor add: 'third'.
	l dataAccessor add: 'fourth'.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }
]

{ #category : #tests }
ToSpecificListElementTest >> testDisabledWithThreeNodes [

	l dataAccessor add: 'first'.
	space root addChild: l.
	self waitTestingSpaces.
	self assert: l innerElement children size equals: 1.
	self assert: l disabledSelectionModel isEmpty.
	l innerElement firstChild disabled: true.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndex equals: 1.
	l dataAccessor addFirst: 'second'.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndex equals: 2.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }.
	l dataAccessor add: 'third'.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }
]

{ #category : #tests }
ToSpecificListElementTest >> testDisabledWithTwoNodes [

	l dataAccessor add: 'first'.
	space root addChild: l.
	self waitTestingSpaces.
	self assert: l innerElement children size equals: 1.
	self assert: l disabledSelectionModel isEmpty.
	l disabledSelecter selectIndex: 1.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndex equals: 1.
	l dataAccessor addFirst: 'second'.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndex equals: 2.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }
]

{ #category : #tests }
ToSpecificListElementTest >> testDisabledWithTwoNodes2 [

	l dataAccessor add: 'first'.
	space root addChild: l.
	self waitTestingSpaces.
	self assert: l nodes size equals: 1.
	self assert: l disabledSelectionModel isEmpty.
	l nodes first disabled: true.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndex equals: 1.
	l dataAccessor addFirst: 'second'.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndex equals: 2.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }
]

{ #category : #tests }
ToSpecificListElementTest >> testEmptyList [

	self assert: l nodes identicalTo: l innerElement children.
	self assert: l selecter selectedIndexes isEmpty.
	self assert: l selectionModel underlyingModel isEmpty.
	self assert: l secondarySelectionModel underlyingModel isEmpty.	
	self assert: l unselectableSelectionModel underlyingModel isEmpty.
	self assert: l disabledSelectionModel underlyingModel isEmpty.
	self assert: l disabledSelectionModel underlyingModel isEmpty.
	self assert: l hiddenSelectionModel underlyingModel isEmpty.
	self assert: l contextMenuSelectionModel underlyingModel isEmpty
]

{ #category : #tests }
ToSpecificListElementTest >> testOneNode [

	l dataAccessor add: 'first'.
	self waitTestingSpaces.
	self assert: l dataSource first equals: 'first'.
	" no node since the list is not added in a space "
	self assert: l innerElement children size equals: 0.
	self assert: l nodes identicalTo: l innerElement children.
	self assert: l nodes size equals: 0.
	" adding the list in the space consequence is a layout computing which update the list nodes"
	space root addChild: l.
	self waitTestingSpaces.
	self assert: l innerElement children size equals: 1.
	self assert: l innerElement firstChild class identicalTo: ToSpecificListNodeForTest.	
	self assert: l nodes first class identicalTo: ToSpecificListNodeForTest.	
	self assert: l nodes first holder class identicalTo: ToSpecificListNodeHolderForTest.	
	self assert: l nodes first children size equals: 1.	
	self assert: l nodes first firstChild class identicalTo: ToLabel.	
	self assert: l nodes first firstChild text asString equals: '1:first'.	
	self assert: l nodes first holder num equals: 1.	
	self assert: l nodes first holder dataItem equals: 'first'
]

{ #category : #tests }
ToSpecificListElementTest >> testSelectionWithOneNode [

	l dataAccessor add: 'first'.
	space root addChild: l.
	self waitTestingSpaces.
	self assert: l innerElement children size equals: 1.
	self assert: l selectionModel isEmpty.
	l selecter selectIndex: 1.
	self assert: l selectionModel isEmpty.
	self waitTestingSpaces.
	self assert: l selecter selectedIndex equals: 1.
	self assert: l selectionModel selectedIndexes equals: { 1 }
]

{ #category : #tests }
ToSpecificListElementTest >> testSelectionWithTwoNodes [

	l dataAccessor add: 'first'.
	space root addChild: l.
	self waitTestingSpaces.
	self assert: l innerElement children size equals: 1.
	self assert: l selectionModel isEmpty.
	l selecter selectIndex: 1.
	self waitTestingSpaces.
	self assert: l selecter selectedIndex equals: 1.
	l dataAccessor addFirst: 'second'.
	self waitTestingSpaces.
	self assert: l selecter selectedIndex equals: 2.
	self assert: l selecter selectedIndexes equals: { 2 }
]
