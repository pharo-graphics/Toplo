Class {
	#name : #ToListContextMenuSelectionMode,
	#superclass : #ToAbstractListSelectionMode,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'api - hooks' }
ToListContextMenuSelectionMode >> installDefaultOptionsIn: anElement [

	overOption := (ToListSelectionOption groupedForMode: self)
		                 beneath: false;
		                 yourself.
	beneathOption := (ToListSelectionOption noneForMode: self)
		              beneath: true;
		              yourself.
	beneathOption onInstalledIn: anElement.
	overOption onInstalledIn: anElement.


]

{ #category : #testing }
ToListContextMenuSelectionMode >> isMultipleSelection [

	^ true
]
