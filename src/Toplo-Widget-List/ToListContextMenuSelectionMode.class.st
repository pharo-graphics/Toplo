Class {
	#name : #ToListContextMenuSelectionMode,
	#superclass : #ToAbstractListSelectionMode,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'api - hooks' }
ToListContextMenuSelectionMode >> installDefaultOptionsIn: anElement [

	overOption := (ToListSelectionOption groupedForMode: self)
		                 selectionContainer: anElement overContainer;
		                 yourself.
	beneathOption := (ToListSelectionOption noneForMode: self)
		              selectionContainer: anElement beneathContainer;
		              yourself.

]

{ #category : #testing }
ToListContextMenuSelectionMode >> isMultipleSelection [

	^ true
]
