Class {
	#name : #ToListElementWithFakeNodeContainerTest,
	#superclass : #ToParameterizedHostTest,
	#category : #'Toplo-Widget-List-Tests-Core-ListElement'
}

{ #category : #tests }
ToListElementWithFakeNodeContainerTest >> testOneSpecifcNode [

	| l |
	l := ToListElementWithFakeNodeContainerForTest new.
	l dataAccessor add: 'first'.
	self waitTestingSpaces.
	self assert: l dataSource first equals: 'first'.
	" adding the list in the space consequence is a layout computing which update the list nodes"
	space root addChild: l.
	self waitTestingSpaces.
	self assert: l nodeContainers size equals: 1.
	self assert: l nodeContainers first node class identicalTo: ToListNodeForTest.	
	self assert: l nodeContainers first holder class identicalTo: ToListNodeHolderForTest.	
	self assert: l nodeContainers first node children size equals: 1.	
	self assert: l nodeContainers first node firstChild class identicalTo: ToLabel.	
	self assert: l fakeNodeContainerWrapper node holder num equals: 1.
	self assert: l fakeNodeContainerWrapper node holder dataItem class equals: l defaultFakeDataItem class.
	self assert: l nodeContainers first node firstChild text asString equals: '2:first'.	
	self assert: l nodeContainers first holder num equals: 2.	
	self assert: l nodeContainers first holder dataItem equals: 'first'
]
