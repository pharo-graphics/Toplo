Class {
	#name : #ToTableElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'dividerStartPosition'
	],
	#category : #'Toplo-Widget-Table-Core'
}

{ #category : #'event handling' }
ToTableElementEventHandler >> addedToSpaceEvent: anEvent [

	| table |
	table := anEvent currentTarget.
	table whenLayoutedDoOnce: [ table freezeCellsWidth ]
]

{ #category : #'divider dragging' }
ToTableElementEventHandler >> dividerDragEvent: anEvent [

	| table divider  |
	table := anEvent currentTarget.
	divider := anEvent sourceEvent target.
	table header divider: divider movedBy: anEvent delta x from: dividerStartPosition x.
	table list divider: divider movedBy: anEvent delta x from: dividerStartPosition x.
	table updateDividers
]

{ #category : #'divider dragging' }
ToTableElementEventHandler >> dividerStartDragEvent: anEvent [

	| divider table |
	divider := anEvent sourceEvent target.
	dividerStartPosition := divider constraints position.
	table := anEvent currentTarget.
	table header divider: divider startDragAt: dividerStartPosition x
]

{ #category : #'api - accessing' }
ToTableElementEventHandler >> eventsToHandle [

	^ {
		  ToDividerStartDragEvent.
		  ToDividerDragEvent.
		ToAddedToSpaceEvent.
		 } 
]
