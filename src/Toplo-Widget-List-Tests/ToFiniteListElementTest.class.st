"
A ToAbstractListElementTest is a test class for testing the behavior of ToAbstractListElement
"
Class {
	#name : #ToFiniteListElementTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'l'
	],
	#category : #'Toplo-Widget-List-Tests-Core-FiniteListElement'
}

{ #category : #running }
ToFiniteListElementTest >> setUp [ 

	super setUp.
	l := ToListElementForTest finite
]

{ #category : #tests }
ToFiniteListElementTest >> testDisabledWithFiveNodes [

	l dataAccessor removeAll.
	l removeFromParent.
	l dataAccessor add: 'first'.
	space root addChild: l.
	l disabledSelecter selectOneMoreIndex: 1.
	self waitTestingSpaces.
	l dataAccessor addFirst: 'second'.
	self waitTestingSpaces.
	l dataAccessor add: 'third'.
	self waitTestingSpaces.
	l dataAccessor add: 'fourth' afterIndex: 2.
	self waitTestingSpaces.
	l dataAccessor addFirst: 'fifth'.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 3 }.
	self assert: l nodes first isEnabled.
	self assert: l nodes second isEnabled.
	self assert: l nodes third isDisabled.
	self assert: l nodes fourth isEnabled.
	self assert: l nodes fifth isEnabled
]

{ #category : #tests }
ToFiniteListElementTest >> testDisabledWithFiveNodesLateAddToSpace [

	l dataAccessor add: 'first'.
	l disabledSelecter selectOneMoreIndex: 1.
	l dataAccessor addFirst: 'second'.
	l dataAccessor add: 'third'.
	l dataAccessor add: 'fourth' afterIndex: 2.
	l dataAccessor addFirst: 'fifth'.
	space root addChild: l.
	l forceLayout.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 3 }.
	self assert: l nodes first isEnabled.
	self assert: l nodes second isEnabled.
	self assert: l nodes third isDisabled.
	self assert: l nodes fourth isEnabled.
	self assert: l nodes fifth isEnabled
]

{ #category : #tests }
ToFiniteListElementTest >> testDisabledWithFourNodes [

	l dataAccessor add: 'first'.
	space root addChild: l.
	self waitTestingSpaces.
	l disabledSelecter selectOneMoreIndex: 1.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 1 }.
	self waitTestingSpaces.
	self assert: l nodes first isDisabled.
	l dataAccessor addFirst: 'second'.
	self waitTestingSpaces.
	l dataAccessor add: 'third'.
	self waitTestingSpaces.
	l dataAccessor add: 'fourth' afterIndex: 2.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }.
	self assert: l nodes first  isEnabled.
	self assert: l nodes second  isDisabled.
	self assert: l nodes third  isEnabled.
	self assert: l nodes fourth  isEnabled
]

{ #category : #tests }
ToFiniteListElementTest >> testDisabledWithFourNodes2 [

	space root addChild: l.
	l dataAccessor add: 'first'.
	l dataAccessor add: 'second'.
	self waitTestingSpaces.
	l disabledSelecter selectOneMoreIndex: 2.
	l dataAccessor add: 'third'.
	l dataAccessor add: 'fourth'.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }.
	self assert: l nodes first isEnabled.
	self assert: l nodes second isDisabled.
	self assert: l nodes third isEnabled.
	self assert: l nodes fourth isEnabled
]

{ #category : #tests }
ToFiniteListElementTest >> testDisabledWithFourNodesLateAddToSpace [

	l dataAccessor add: 'first'.
	l disabledSelecter selectOneMoreIndex: 1.
	l dataAccessor addFirst: 'second'.
	l dataAccessor add: 'third'.
	l dataAccessor add: 'fourth' afterIndex: 2.
	space root addChild: l.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }.
	self assert: l nodes first isEnabled.
	self assert: l nodes second isDisabled.
	self assert: l nodes third isEnabled.
	self assert: l nodes fourth isEnabled
]

{ #category : #tests }
ToFiniteListElementTest >> testDisabledWithFourNodesLateAddToSpace2 [

	l dataAccessor add: 'first'.
	l dataAccessor add: 'second'.
	l disabledSelecter selectOneMoreIndex: 2.
	l dataAccessor add: 'third'.
	l dataAccessor add: 'fourth'.
	space root addChild: l.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }.
	self assert: l nodes first isEnabled.
	self assert: l nodes second isDisabled.
	self assert: l nodes third isEnabled.
	self assert: l nodes fourth isEnabled
]

{ #category : #tests }
ToFiniteListElementTest >> testDisabledWithOneNode [

	l dataAccessor add: 'first'.
	space root addChild: l.
	self waitTestingSpaces.
	self assert: l nodeContainers size equals: 1.
	self assert: l disabledSelectionModel isEmpty.
	l disabledSelecter selectIndex: 1.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndex equals: 1.
	self waitTestingSpaces.
	self assert: l nodes first isDisabled
]

{ #category : #tests }
ToFiniteListElementTest >> testDisabledWithThreeNodes [

	l dataAccessor add: 'first'.
	space root addChild: l.
	self waitTestingSpaces.
	self assert: l nodeContainers size equals: 1.
	self assert: l disabledSelectionModel isEmpty.
	l disabledSelecter selectOneMoreIndex: 1.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndex equals: 1.
	l dataAccessor addFirst: 'second'.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndex equals: 2.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }.
	l dataAccessor add: 'third'.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }.
	self assert: l nodes first isEnabled.
	self assert: l nodes second isDisabled.
	self assert: l nodes third isEnabled
]

{ #category : #tests }
ToFiniteListElementTest >> testDisabledWithThreeNodesLateAddToSpace [

	l dataAccessor add: 'first'.
	l disabledSelecter selectOneMoreIndex: 1.
	l dataAccessor addFirst: 'second'.
	l dataAccessor add: 'third'.
	space root addChild: l.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }.
	self assert: l nodes first isEnabled.
	self assert: l nodes second isDisabled.
	self assert: l nodes third isEnabled
]

{ #category : #tests }
ToFiniteListElementTest >> testDisabledWithTwoNodes [

	l dataAccessor add: 'first'.
	space root addChild: l.
	l forceLayout.
	self waitTestingSpaces.
	self assert: l nodeContainers size equals: 1.
	self assert: l disabledSelectionModel isEmpty.
	l disabledSelecter selectOneMoreIndex: 1.
	l forceLayout.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndex equals: 1.
	l dataAccessor addFirst: 'second'.
	l forceLayout.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndex equals: 2.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }.
	self assert: l nodes first isEnabled.
	self assert: l nodes second isDisabled
]

{ #category : #tests }
ToFiniteListElementTest >> testDisabledWithTwoNodes2 [

	l dataAccessor add: 'first'.
	space root addChild: l.
	self waitTestingSpaces.
	self assert: l nodeContainers size equals: 1.
	self assert: l disabledSelectionModel isEmpty.
	l disabledSelecter selectOneMoreIndex: 1.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndex equals: 1.
	l dataAccessor addFirst: 'second'.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndex equals: 2.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }.
	self waitTestingSpaces.
	self assert: l nodes first isEnabled.
	self assert: l nodes second isDisabled
]

{ #category : #tests }
ToFiniteListElementTest >> testDisabledWithTwoNodesLateAddToSpace [

	l dataAccessor add: 'first'.
	l disabledSelecter selectOneMoreIndex: 1.
	l dataAccessor addFirst: 'second'.
	space root addChild: l.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndex equals: 2.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }.
	self assert: l nodes first isEnabled.
	self assert: l nodes second isDisabled
]

{ #category : #tests }
ToFiniteListElementTest >> testDisabledWithTwoNodesLateAddToSpace2 [

	l dataAccessor add: 'first'.
	l disabledSelecter selectOneMoreIndex: 1.
	l dataAccessor addFirst: 'second'.
	space root addChild: l.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndex equals: 2.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }.
	self assert: l nodes first isEnabled.
	self assert: l nodes second isDisabled
]

{ #category : #tests }
ToFiniteListElementTest >> testEmptyList [

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
ToFiniteListElementTest >> testOneNode [

	space root addChild: l.
	l dataAccessor add: 'first'.
	self waitTestingSpaces.
	self assert: l dataSource first equals: 'first'.
	self assert: l nodes  size equals: 1.
	self assert: l nodes first class identicalTo: ToListNodeForTest.	
	self assert: l nodes first  holder class identicalTo: ToListNodeHolderForTest.	
	self assert: l nodes first  children size equals: 1.	
	self assert: l nodes first  firstChild class identicalTo: ToLabel.
	self assert: l nodes first  firstChild text asString equals: '1:first'.	
	self assert: l nodes first  holder num equals: 1.	
	self assert: l nodes first  holder dataItem equals: 'first'.
	self assert: l nodes first isEnabled
]

{ #category : #tests }
ToFiniteListElementTest >> testSelectionWithOneNode [

	l dataAccessor add: 'first'.
	space root addChild: l.
	self waitTestingSpaces.
	self assert: l nodeContainers size equals: 1.
	self assert: l selectionModel isEmpty.
	l selecter selectOneMoreIndex: 1.
	self waitTestingSpaces.
	self assert: l selecter selectedIndex equals: 1.
	self assert: l selectionModel selectedIndexes equals: { 1 }
]

{ #category : #tests }
ToFiniteListElementTest >> testSelectionWithTwoNodes [

	l dataAccessor add: 'first'.
	space root addChild: l.
	self waitTestingSpaces.
	self assert: l nodeContainers size equals: 1.
	self assert: l selectionModel isEmpty.
	l selecter selectOneMoreIndex: 1.
	self waitTestingSpaces.
	self assert: l selecter selectedIndex equals: 1.
	l dataAccessor addFirst: 'second'.
	self waitTestingSpaces.
	self assert: l selecter selectedIndex equals: 2.
	self assert: l selecter selectedIndexes equals: { 2 }
]
