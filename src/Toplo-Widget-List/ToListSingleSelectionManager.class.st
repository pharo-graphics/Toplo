Class {
	#name : #ToListSingleSelectionManager,
	#superclass : #ToListSelectionManager,
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #initialization }
ToListSingleSelectionManager >> defaultSelectionMode [

	^ ToListSingleSelectionMode new
]

{ #category : #accessing }
ToListSingleSelectionManager >> nodeEventHandlerClasses [ 

	^ { ToListNodeSingleSelectionClickEventHandler }

]

{ #category : #'event handling' }
ToListSingleSelectionManager >> onClickOnNode: aNode event: anEvent [

	anEvent modifiers isPrimaryModifier ifTrue: [
		| index |
		index := aNode holder position.
		(self selectionModel containsIndex: index) ifTrue: [
			^ self selecter deselectIndex: index ] ].

	self selecter selectOnlyIndex: aNode holder position
]
