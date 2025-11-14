Class {
	#name : #ToTableElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'dividerStartPosition'
	],
	#category : #'Toplo-Widget-Table-Core'
}

{ #category : #'divider dragging' }
ToTableElementEventHandler >> dividerDragEvent: anEvent [

	| table dividers pos |
	table := anEvent currentTarget.
	dividers := table selectChildrenWithId: #columnDivider.
	pos := dividers indexOf: anEvent sourceEvent target.
	table header dividerAt: pos movedBy: anEvent delta x from: dividerStartPosition x.
	table list dividerAt: pos movedBy: anEvent delta x from: dividerStartPosition x
]

{ #category : #'divider dragging' }
ToTableElementEventHandler >> dividerStartDragEvent: anEvent [

	| divider |
	divider := anEvent sourceEvent target.
	dividerStartPosition := divider constraints position
]

{ #category : #'api - accessing' }
ToTableElementEventHandler >> eventsToHandle [

	^ {
		  ToDividerStartDragEvent.
		  ToDividerDragEvent }
]
