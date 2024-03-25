Class {
	#name : #ToListSingleSelectionMode,
	#superclass : #ToListSelectionMode,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #testing }
ToListSingleSelectionMode >> allowRequestFocusOnMouseDown [

	( self selectedIndexesCount > 0 )
		ifTrue: [ self preserveSelectionOnFocused ifTrue: [ ^ false ] ].
	^ super allowRequestFocusOnMouseDown
]

{ #category : #testing }
ToListSingleSelectionMode >> isMultipleSelection [

	^ false
]

{ #category : #'instance creation' }
ToListSingleSelectionMode >> newSelecter [

	^ ToSingleSelectionModelSelecter
		  selectionModel: self selectionModel
		  operator: self operator
]

{ #category : #accessing }
ToListSingleSelectionMode >> nodeEventHandlerClasses [ 

	^ { ToListNodeSingleSelectionClickEventHandler }

]

{ #category : #'event handling' }
ToListSingleSelectionMode >> onClickEvent: anEvent onNode: aNode [

	super onClickEvent: anEvent onNode: aNode.
	(anEvent sourceEvent modifiers isPrimaryModifier or: [ self selectOnMouseDown ])
		ifTrue: [
			| index |
			index := aNode holder position.
			(self selectionModel containsIndex: index) ifTrue: [
				^ self selecter deselectIndex: index ] ].
	self selecter selectOnlyIndex: aNode holder position
]
