Class {
	#name : #ToListSingleSelectionMode,
	#superclass : #ToListSelectionMode,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #initialization }
ToListSingleSelectionMode >> defaultSelectionCommandChecker [

	^ ToListSingleSelectionCommandChecker new
]

{ #category : #accessing }
ToListSingleSelectionMode >> nodeEventHandlerClasses [ 

	^ { ToListNodeSingleSelectionClickEventHandler }

]

{ #category : #'event handling' }
ToListSingleSelectionMode >> onClickOnNode: aNode event: anEvent [

	anEvent sourceEvent modifiers isPrimaryModifier ifTrue: [
		| index |
		index := aNode holder position.
		(self selectionModel containsIndex: index) ifTrue: [
			^ self selecter deselectIndex: index ] ].

	self selecter selectOnlyIndex: aNode holder position
]
