"
A ToAbstractListElementTest is a test class for testing the behavior of ToAbstractListElement
"
Class {
	#name : #ToSpecificFiniteListElementTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'l'
	],
	#category : #'Toplo-Widget-List-Tests-Core-FiniteListElement'
}

{ #category : #running }
ToSpecificFiniteListElementTest >> setUp [ 

	super setUp.
	l := ToSpecificFiniteListElementForTest new
]

{ #category : #tests }
ToSpecificFiniteListElementTest >> testDisabledWithFiveNodes [

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
ToSpecificFiniteListElementTest >> testDisabledWithFiveNodesLateAddToSpace [

	l dataAccessor add: 'first'.
	l disabledSelecter selectOneMoreIndex: 1.
	l dataAccessor addFirst: 'second'.
	l dataAccessor add: 'third'.
	l dataAccessor add: 'fourth' afterIndex: 2.
	l dataAccessor addFirst: 'fifth'.
	space root addChild: l.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 3 }.
	self assert: l nodes first isEnabled.
	self assert: l nodes second isEnabled.
	self assert: l nodes third isDisabled.
	self assert: l nodes fourth isEnabled.
	self assert: l nodes fifth isEnabled
]

{ #category : #tests }
ToSpecificFiniteListElementTest >> testDisabledWithFourNodes [

	l dataAccessor add: 'first'.
	space root addChild: l.
	self waitTestingSpaces.
	l disabledSelecter selectOneMoreIndex: 1.
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
ToSpecificFiniteListElementTest >> testDisabledWithFourNodes2 [

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
ToSpecificFiniteListElementTest >> testDisabledWithFourNodesLateAddToSpace [

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
ToSpecificFiniteListElementTest >> testDisabledWithFourNodesLateAddToSpace2 [

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
ToSpecificFiniteListElementTest >> testDisabledWithOneNode [

	l dataAccessor add: 'first'.
	space root addChild: l.
	self waitTestingSpaces.
	self assert: l nodeContainers size equals: 1.
	self assert: l disabledSelectionModel isEmpty.
	l disabledSelecter selectOneMoreIndex: 1.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndex equals: 1.
	self assert: l nodes first isDisabled
]

{ #category : #tests }
ToSpecificFiniteListElementTest >> testDisabledWithThreeNodes [

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
ToSpecificFiniteListElementTest >> testDisabledWithThreeNodesLateAddToSpace [

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
ToSpecificFiniteListElementTest >> testDisabledWithTwoNodes [

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
	self assert: l nodes first isEnabled.
	self assert: l nodes second isDisabled
]

{ #category : #tests }
ToSpecificFiniteListElementTest >> testDisabledWithTwoNodes2 [

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
	self assert: l nodes first isEnabled.
	self assert: l nodes second isDisabled
]

{ #category : #tests }
ToSpecificFiniteListElementTest >> testDisabledWithTwoNodesLateAddToSpace [

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
ToSpecificFiniteListElementTest >> testDisabledWithTwoNodesLateAddToSpace2 [

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
ToSpecificFiniteListElementTest >> testEmptyList [

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
ToSpecificFiniteListElementTest >> testOneNode [

	space root addChild: l.
	l dataAccessor add: 'first'.
	self waitTestingSpaces.
	self assert: l dataSource first equals: 'first'.
	self assert: l nodes  size equals: 1.
	self assert: l nodes first class identicalTo: ToSpecificFiniteListNodeForTest.	
	self assert: l nodes first  holder class identicalTo: ToSpecificFiniteListNodeHolderForTest.	
	self assert: l nodes first  children size equals: 1.	
	self assert: l nodes first  firstChild class identicalTo: ToLabel.
	" 3 because the fake node container has been added first then reinstalled because of the fakeDataItem: send in ToSpecificFiniteListNodeHolderForTest>>initialize   "
	self assert: l nodes first  firstChild text asString equals: '3:first'.	
	self assert: l nodes first  holder num equals: 3.	
	self assert: l nodes first  holder dataItem equals: 'first'.
	self assert: l nodes first isEnabled
]

{ #category : #tests }
ToSpecificFiniteListElementTest >> testSelectionWithOneNode [

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
ToSpecificFiniteListElementTest >> testSelectionWithTwoNodes [

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
