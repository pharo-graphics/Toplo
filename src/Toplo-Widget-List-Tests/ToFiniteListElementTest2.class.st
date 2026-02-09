"
A ToAbstractListElementTest is a test class for testing the behavior of ToAbstractListElement
"
Class {
	#name : #ToFiniteListElementTest2,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'l'
	],
	#category : #'Toplo-Widget-List-Tests-Core-FiniteListElement'
}

{ #category : #running }
ToFiniteListElementTest2 >> setUp [ 

	super setUp.
	l := ToFiniteListElementForTest2 new
]

{ #category : #tests }
ToFiniteListElementTest2 >> testDisabledWithFiveNodes [

	l dataAccessor add: (ToLabel text: 'first').
	l disabledSelecter selectOneMoreIndex: 1.
	space root addChild: l.
	self waitTestingSpaces.
	l dataAccessor addFirst: (ToLabel text: 'second').
	self waitTestingSpaces.
	l dataAccessor add: (ToLabel text: 'third').
	self waitTestingSpaces.
	l dataAccessor add: (ToLabel text: 'fourth') afterIndex: 2.
	self waitTestingSpaces.
	l dataAccessor addFirst: (ToLabel text: 'fifth').
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 3 }.
	self assert: l nodes first isEnabled.
	self assert: l nodes second isEnabled.
	self assert: l nodes third isDisabled.
	self assert: l nodes fourth isEnabled.
	self assert: l nodes fifth isEnabled
]

{ #category : #tests }
ToFiniteListElementTest2 >> testDisabledWithFiveNodes2 [

	space root addChild: l.
	l dataAccessor add: (ToLabel text: 'first').
	l dataAccessor add: (ToLabel text: 'second').
	self waitTestingSpaces.
	l disabledSelecter selectOneMoreIndex: 2.
	self waitTestingSpaces.
	l forceLayout.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }.
	l dataAccessor add: (ToLabel text: 'third').
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }.
	l dataAccessor add: (ToLabel text: 'fourth').
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }.
	l dataAccessor add: (ToLabel text: 'fifth').
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }.
	self assert: l nodes first isEnabled.
	self assert: l nodes second isDisabled.
	self assert: l nodes third isEnabled.
	self assert: l nodes fourth isEnabled.
	self assert: l nodes fifth isEnabled
]

{ #category : #tests }
ToFiniteListElementTest2 >> testDisabledWithFiveNodes4 [

	space root addChild: l.
	l dataAccessor add: (ToLabel text: 'first').
	l dataAccessor add: (ToLabel text: 'second').
	self waitTestingSpaces.
	l disabledSelecter selectIndex: 2.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }.
	l dataAccessor add: (ToLabel text: 'third').
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }.
	l dataAccessor addFirst: (ToLabel text: 'fourth').
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 3 }.
	l dataAccessor add: (ToLabel text: 'fifth').
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 3 }.
	self assert: l nodes first isEnabled.
	self assert: l nodes second isEnabled.
	self assert: l nodes third isDisabled.
	self assert: l nodes fourth isEnabled.
	self assert: l nodes fifth isEnabled
]

{ #category : #tests }
ToFiniteListElementTest2 >> testDisabledWithFiveNodesLateAddToSpace [

	l dataAccessor add: (ToLabel text: 'first').
	l disabledSelecter selectOneMoreIndex: 1.
	l dataAccessor addFirst: (ToLabel text: 'second').
	l dataAccessor add: (ToLabel text: 'third').
	l dataAccessor add: (ToLabel text: 'fourth') afterIndex: 2.
	l dataAccessor addFirst: (ToLabel text: 'fifth').
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
ToFiniteListElementTest2 >> testDisabledWithFiveNodesLateAddToSpace2 [

	l dataAccessor add: (ToLabel text: 'first').
	l dataAccessor add: (ToLabel text: 'second').
	l disabledSelecter selectOneMoreIndex: 2.
	l dataAccessor add: (ToLabel text: 'third').
	l dataAccessor add: (ToLabel text: 'fourth').
	l dataAccessor add: (ToLabel text: 'fifth').
	space root addChild: l.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }.
	self assert: l nodes first isEnabled.
	self assert: l nodes second isDisabled.
	self assert: l nodes third isEnabled.
	self assert: l nodes fourth isEnabled.
	self assert: l nodes fifth isEnabled
]

{ #category : #tests }
ToFiniteListElementTest2 >> testDisabledWithFiveNodesLateAddToSpace4 [

	l dataAccessor add: (ToLabel text: 'first').
	l dataAccessor add: (ToLabel text: 'second').
	l disabledSelecter selectOneMoreIndex: 2.
	l dataAccessor add: (ToLabel text: 'third').
	l dataAccessor addFirst: (ToLabel text: 'fourth').
	l dataAccessor add: (ToLabel text: 'fifth').
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
ToFiniteListElementTest2 >> testDisabledWithFourNodes [

	l dataAccessor add: (ToLabel text: 'first').
	space root addChild: l.
	self waitTestingSpaces.
	l disabledSelecter selectOneMoreIndex: 1.
	self waitTestingSpaces.
	l dataAccessor addFirst: (ToLabel text: 'second').
	self waitTestingSpaces.
	l dataAccessor add: (ToLabel text: 'third').
	self waitTestingSpaces.
	l dataAccessor add: (ToLabel text: 'fourth') afterIndex: 2.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }.
	self assert: l nodes first isEnabled.
	self assert: l nodes second isDisabled.
	self assert: l nodes third isEnabled.
	self assert: l nodes fourth isEnabled
]

{ #category : #tests }
ToFiniteListElementTest2 >> testDisabledWithFourNodes2 [

	space root addChild: l.
	l dataAccessor add: (ToLabel text: 'first').
	l dataAccessor add: (ToLabel text: 'second').
	l innerElement forceLayout.
	self waitTestingSpaces.
	l disabledSelecter selectOneMoreIndex: 2.
	l dataAccessor add: (ToLabel text: 'third').
	l dataAccessor add: (ToLabel text: 'fourth').
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }.
	self assert: l nodes first isEnabled.
	self assert: l nodes second isDisabled.
	self assert: l nodes third isEnabled.
	self assert: l nodes fourth isEnabled
]

{ #category : #tests }
ToFiniteListElementTest2 >> testDisabledWithFourNodes3 [

	space root addChild: l.
	l forceLayout.
	l dataAccessor add: (ToLabel text: 'first').
	l dataAccessor add: (ToLabel text: 'second').
	self waitTestingSpaces.
	l disabledSelecter selectOneMoreIndex: 2.
	self waitTestingSpaces.
	l dataAccessor addFirst: (ToLabel text: 'third').
	self waitTestingSpaces.
	l dataAccessor add: (ToLabel text: 'fourth').
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 3 }.
	self assert: l nodes first isEnabled.
	self assert: l nodes second isEnabled.
	self assert: l nodes third isDisabled.
	self assert: l nodes fourth isEnabled
]

{ #category : #tests }
ToFiniteListElementTest2 >> testDisabledWithFourNodesLateAddToSpace [

	l dataAccessor add: (ToLabel text: 'first').
	l disabledSelecter selectOneMoreIndex: 1.
	l dataAccessor addFirst: (ToLabel text: 'second').
	l dataAccessor add: (ToLabel text: 'third').
	l dataAccessor add: (ToLabel text: 'fourth') afterIndex: 2.
	space root addChild: l.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }.
	self assert: l nodes first isEnabled.
	self assert: l nodes second isDisabled.
	self assert: l nodes third isEnabled.
	self assert: l nodes fourth isEnabled
]

{ #category : #tests }
ToFiniteListElementTest2 >> testDisabledWithFourNodesLateAddToSpace2 [

	l dataAccessor add: (ToLabel text: 'first').
	l dataAccessor add: (ToLabel text: 'second').
	l disabledSelecter selectOneMoreIndex: 2.
	l dataAccessor add: (ToLabel text: 'third').
	l dataAccessor add: (ToLabel text: 'fourth').
	space root addChild: l.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }.
	self assert: l nodes first isEnabled.
	self assert: l nodes second isDisabled.
	self assert: l nodes third isEnabled.
	self assert: l nodes fourth isEnabled
]

{ #category : #tests }
ToFiniteListElementTest2 >> testDisabledWithFourNodesLateAddToSpace3 [

	l dataAccessor add: (ToLabel text: 'first').
	l dataAccessor add: (ToLabel text: 'second').
	l disabledSelecter selectOneMoreIndex: 2.
	l dataAccessor addFirst: (ToLabel text: 'third').
	l dataAccessor add: (ToLabel text: 'fourth').
	space root addChild: l.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 3 }.
	self assert: l nodes first isEnabled.
	self assert: l nodes second isEnabled.
	self assert: l nodes third isDisabled.
	self assert: l nodes fourth isEnabled
]

{ #category : #tests }
ToFiniteListElementTest2 >> testDisabledWithOneNode [

	l dataAccessor add: (ToLabel text: 'first').
	space root addChild: l.
	self waitTestingSpaces.
	self assert: l nodeContainers size equals: 1.
	self assert: l disabledSelectionModel isEmpty.
	l disabledSelecter selectOneMoreIndex: 1.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndex equals: 1
]

{ #category : #tests }
ToFiniteListElementTest2 >> testDisabledWithThreeNodes [

	l dataAccessor add: (ToLabel text: 'first').
	space root addChild: l.
	self waitTestingSpaces.
	self assert: l nodeContainers size equals: 1.
	self assert: l disabledSelectionModel isEmpty.
	l disabledSelecter selectOneMoreIndex: 1.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndex equals: 1.
	l dataAccessor addFirst: (ToLabel text: 'second').
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }.
	l dataAccessor add: (ToLabel text: 'third').
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }.
	self assert: l nodes first isEnabled.
	self assert: l nodes second isDisabled.
	self assert: l nodes third isEnabled
]

{ #category : #tests }
ToFiniteListElementTest2 >> testDisabledWithThreeNodesLateAddToSpace [

	l dataAccessor add: (ToLabel text: 'first').
	l disabledSelecter selectOneMoreIndex: 1.
	l dataAccessor addFirst: (ToLabel text: 'second').
	l dataAccessor add: (ToLabel text: 'third').
	space root addChild: l.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }.
	self assert: l nodes first isEnabled.
	self assert: l nodes second isDisabled.
	self assert: l nodes third isEnabled
]

{ #category : #tests }
ToFiniteListElementTest2 >> testDisabledWithTwoNodes [

	l dataAccessor add: (ToLabel text: 'first').
	space root addChild: l.
	l forceLayout.
	self waitTestingSpaces.
	self assert: l nodeContainers size equals: 1.
	self assert: l disabledSelectionModel isEmpty.
	l disabledSelecter selectOneMoreIndex: 1.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndex equals: 1.
	l dataAccessor addFirst: (ToLabel text: 'second').
	l forceLayout.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }.
	self assert: l nodes first isEnabled.
	self assert: l nodes second isDisabled
]

{ #category : #tests }
ToFiniteListElementTest2 >> testDisabledWithTwoNodes2 [

	l dataAccessor add: (ToLabel text: 'first').
	space root addChild: l.
	self waitTestingSpaces.
	self assert: l nodeContainers size equals: 1.
	self assert: l disabledSelectionModel isEmpty.
	l disabledSelecter selectOneMoreIndex: 1.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndex equals: 1.
	l dataAccessor addFirst: (ToLabel text: 'second').
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }.
	self waitTestingSpaces.
	self assert: l nodes first isEnabled.
	self assert: l nodes second isDisabled
]

{ #category : #tests }
ToFiniteListElementTest2 >> testDisabledWithTwoNodesLateAddToSpace [

	l dataAccessor add: (ToLabel text: 'first').
	l disabledSelecter selectOneMoreIndex: 1.
	l dataAccessor addFirst: (ToLabel text: 'second').
	space root addChild: l.
	self waitTestingSpaces.
	self assert: l disabledSelecter selectedIndexes equals: { 2 }.
	self assert: l nodes first isEnabled.
	self assert: l nodes second isDisabled
]

{ #category : #tests }
ToFiniteListElementTest2 >> testEmptyList [

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
ToFiniteListElementTest2 >> testOneNode [

	space root addChild: l.
	l dataAccessor add: (ToLabel text: 'first').
	self waitTestingSpaces.
	self assert: l dataSource first text asString equals: 'first'.
	self assert: l nodeContainers  size equals: 1.
	self assert: l nodes first class identicalTo: ToListNodeForTest.	
	self assert: l nodes first  holder class identicalTo: ToListNodeHolderForTest.	
	self assert: l nodes first  children size equals: 1.	
	self assert: l nodes first  firstChild class identicalTo: ToLabel.
	" 2 because the fake node container has been added first "
	self assert: l nodes first  firstChild text asString equals: 'first'.	
	self assert: l nodes first  holder num equals: 1.	
	self assert: l nodes first  holder dataItem text asString equals: 'first'
]

{ #category : #tests }
ToFiniteListElementTest2 >> testSelectionWithOneNode [

	l dataAccessor add: (ToLabel text: 'first').
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
ToFiniteListElementTest2 >> testSelectionWithTwoNodes [

	l dataAccessor add: (ToLabel text: 'first').
	space root addChild: l.
	self waitTestingSpaces.
	self assert: l nodeContainers size equals: 1.
	self assert: l selectionModel isEmpty.
	l selecter selectOneMoreIndex: 1.
	self waitTestingSpaces.
	self assert: l selecter selectedIndex equals: 1.
	l dataAccessor addFirst: (ToLabel text: 'second').
	self waitTestingSpaces.
	self assert: l selecter selectedIndex equals: 2.
	self assert: l selecter selectedIndexes equals: { 2 }
]
