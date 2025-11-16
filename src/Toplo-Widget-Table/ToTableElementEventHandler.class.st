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
	table whenLayoutedDoOnce: [ table freezeColumnsWidth ]
]

{ #category : #'divider dragging' }
ToTableElementEventHandler >> dividerDragEvent: anEvent [

	| table dividers pos |
	table := anEvent currentTarget.
	dividers := table selectChildrenWithId: #columnDivider.
	pos := anEvent sourceEvent target columnElementIndex.
	table header dividerAt: pos movedBy: anEvent delta x from: dividerStartPosition x.
	table list dividerAt: pos movedBy: anEvent delta x from: dividerStartPosition x.
	table updateDividers
]

{ #category : #'divider dragging' }
ToTableElementEventHandler >> dividerStartDragEvent: anEvent [

	| divider table dividers pos |
	divider := anEvent sourceEvent target.
	dividerStartPosition := divider constraints position.
	table := anEvent currentTarget.
	dividers := table selectChildrenWithId: #columnDivider.
	pos := anEvent sourceEvent target columnElementIndex.
	table header dividerAt: pos startDragAt: dividerStartPosition x
]

{ #category : #'api - accessing' }
ToTableElementEventHandler >> eventsToHandle [

	^ {
		  ToDividerStartDragEvent.
		  ToDividerDragEvent.
		ToAddedToSpaceEvent.
		 } 
]
