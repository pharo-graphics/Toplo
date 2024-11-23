"
A ToAbstractListElementTest is a test class for testing the behavior of ToAbstractListElement
"
Class {
	#name : #ToSpecificBarElementTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'l'
	],
	#category : #'Toplo-Widget-List-Tests-Core-BarElement'
}

{ #category : #running }
ToSpecificBarElementTest >> setUp [ 

	super setUp.
	l := ToSpecificBarElementForTest new
]

{ #category : #tests }
ToSpecificBarElementTest >> testDisabledWithFiveNodes [

	l dataAccessor add: 'first'.
	space root addChild: l.
	self waitTestingSpaces.
	l nodes first disabled: true.
	l dataAccessor addFirst: 'second'.
	l dataAccessor add: 'third'.
	l dataAccessor add: 'fourth' afterIndex: 2.
	l dataAccessor addFirst: 'fifth'.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 3 }
]

{ #category : #tests }
ToSpecificBarElementTest >> testDisabledWithFourNodes [

	l dataAccessor add: 'first'.
	space root addChild: l.
	self waitTestingSpaces.
	l nodes first disabled: true.
	l dataAccessor addFirst: 'second'.
	l dataAccessor add: 'third'.
	l dataAccessor add: 'fourth' afterIndex: 2.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }
]

{ #category : #tests }
ToSpecificBarElementTest >> testDisabledWithFourNodes2 [

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
ToSpecificBarElementTest >> testDisabledWithThreeNodes [

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
	self assert: l disabledSelecter selectedIndexes equals: { 2 }.
	l dataAccessor add: 'third'.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }
]

{ #category : #tests }
ToSpecificBarElementTest >> testDisabledWithTwoNodes [

	l dataAccessor add: 'first'.
	space root addChild: l.
	self waitTestingSpaces.
	self assert: l nodes size equals: 1.
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
ToSpecificBarElementTest >> testDisabledWithTwoNodes2 [

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
ToSpecificBarElementTest >> testEmptyList [

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
ToSpecificBarElementTest >> testOneNode [

	space root addChild: l.
	l dataAccessor add: 'first'.
	self waitTestingSpaces.
	self assert: l dataSource first equals: 'first'.
	self assert: l nodes  size equals: 1.
	self assert: l nodes first class identicalTo: ToSpecificBarNodeForTest.	
	self assert: l nodes first  holder class identicalTo: ToSpecificBarNodeHolderForTest.	
	self assert: l nodes first  children size equals: 1.	
	self assert: l nodes first  firstChild class identicalTo: ToLabel.
	" 2 because the fake node has been added first "
	self assert: l nodes first  firstChild text asString equals: '2:first'.	
	self assert: l nodes first  holder num equals: 2.	
	self assert: l nodes first  holder dataItem equals: 'first'
]

{ #category : #tests }
ToSpecificBarElementTest >> testSelectionWithOneNode [

	l dataAccessor add: 'first'.
	space root addChild: l.
	self waitTestingSpaces.
	self assert: l nodes size equals: 1.
	self assert: l selectionModel isEmpty.
	l selecter selectIndex: 1.
	self assert: l selectionModel isEmpty.
	self waitTestingSpaces.
	self assert: l selecter selectedIndex equals: 1.
	self assert: l selectionModel selectedIndexes equals: { 1 }
]

{ #category : #tests }
ToSpecificBarElementTest >> testSelectionWithTwoNodes [

	l dataAccessor add: 'first'.
	space root addChild: l.
	self waitTestingSpaces.
	self assert: l nodes size equals: 1.
	self assert: l selectionModel isEmpty.
	l selecter selectIndex: 1.
	self waitTestingSpaces.
	self assert: l selecter selectedIndex equals: 1.
	l dataAccessor addFirst: 'second'.
	self waitTestingSpaces.
	self assert: l selecter selectedIndex equals: 2.
	self assert: l selecter selectedIndexes equals: { 2 }
]
