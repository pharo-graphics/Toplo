Class {
	#name : #ToListSelectionCommandEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'currentTarget'
	],
	#category : #'Toplo-Widget-List-Selection-Strategy'
}

{ #category : #'api - accessing' }
ToListSelectionCommandEventHandler >> eventsToHandle [

	^ { ToListSelectionCommandEventDep }
]

{ #category : #'api - accessing' }
ToListSelectionCommandEventHandler >> listDeselectWholeDataCommand: aSelectionAction [

	currentTarget deselectAll


]

{ #category : #'api - accessing' }
ToListSelectionCommandEventHandler >> listSelectOrDeselectNeighboursCommand: aSelectionAction [

	currentTarget addOrRemoveWithGap: aSelectionAction number


]

{ #category : #'api - accessing' }
ToListSelectionCommandEventHandler >> listSelectToIndexCommand: aSelectionAction [

	currentTarget selectToIndex: aSelectionAction index
]

{ #category : #'api - accessing' }
ToListSelectionCommandEventHandler >> listSelectWholeDataCommand: aSelectionAction [

	currentTarget selectAll


]

{ #category : #'api - accessing' }
ToListSelectionCommandEventHandler >> listSelectionCherryPickCommand: aSelectionAction [

	currentTarget cherryPickIndex: aSelectionAction index


]

{ #category : #'api - accessing' }
ToListSelectionCommandEventHandler >> listSelectionCommandEvent: anEvent [

	currentTarget := anEvent currentTarget.
	anEvent command applyOn: self.
	currentTarget := nil


]

{ #category : #'api - accessing' }
ToListSelectionCommandEventHandler >> listSelectionDeselectAllIndexesCommand: aSelectionAction [

	currentTarget deselectAllIndexes: aSelectionAction indexes


]

{ #category : #'api - accessing' }
ToListSelectionCommandEventHandler >> listSelectionDeselectIndexCommand: aSelectionAction [

	currentTarget deselectIndex: aSelectionAction index


]

{ #category : #'api - accessing' }
ToListSelectionCommandEventHandler >> listSelectionSelectAllIndexesCommand: aSelectionAction [

	aSelectionAction exclusively
		ifTrue: [ currentTarget selectOnlyIndexes: aSelectionAction indexes ]
		ifFalse: [ currentTarget selectAllIndexes: aSelectionAction indexes ]
]

{ #category : #'api - accessing' }
ToListSelectionCommandEventHandler >> listSelectionSelectIndexCommand: aSelectionAction [

	aSelectionAction exclusively
		ifTrue: [ currentTarget selectOnlyIndex: aSelectionAction index ]
		ifFalse: [ currentTarget selectIndex: aSelectionAction index ]
]
