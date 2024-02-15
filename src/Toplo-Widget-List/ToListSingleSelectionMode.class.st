Class {
	#name : #ToListSingleSelectionMode,
	#superclass : #ToListSelectionMode,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #testing }
ToListSingleSelectionMode >> allowNodeSelectionOnMouseDown [

	( self selectedIndexesCount > 0 )
		ifTrue: [ self preserveSelectionOnFocused ifTrue: [ ^ false ] ].
	^ super allowNodeSelectionOnMouseDown
]

{ #category : #'instance creation' }
ToListSingleSelectionMode >> newSelecterIn: anElement [

	^ ToSingleSelectionModelSelecter new 
]

{ #category : #accessing }
ToListSingleSelectionMode >> nodeEventHandlerClasses [ 

	^ { ToListNodeSingleSelectionClickEventHandler }

]

{ #category : #'event handling' }
ToListSingleSelectionMode >> onClickEvent: anEvent onNode: aNode [

	super onClickEvent: anEvent onNode: aNode.
	anEvent modifiers isPrimaryModifier ifTrue: [
		| index |
		index := aNode holder position.
		(self selectionModel containsIndex: index) ifTrue: [
			^ self selecter deselectIndex: index ] ].

	self selecter selectOnlyIndex: aNode holder position
]
