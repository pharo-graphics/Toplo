Class {
	#name : #ToTableDividerEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'startDragPosition'
	],
	#category : #'Toplo-Widget-Table-Core'
}

{ #category : #'divider dragging' }
ToTableDividerEventHandler >> dividerDragEvent: anEvent [

	| table divider  state |
	divider := anEvent currentTarget.
	table := divider parentTable.
	state := divider parentTable list columnStateAt: divider cellIndex.
	table header divider: divider movedBy: anEvent delta x from: startDragPosition x.
	table list divider: divider movedBy: anEvent delta x from: startDragPosition x.
	table otherDividersUpdate: divider
	
]

{ #category : #'divider dragging' }
ToTableDividerEventHandler >> dividerDragRequestEvent: anEvent [

	| divider state  w |
	divider := anEvent currentTarget.
	state := divider parentTable list columnStateAt: divider cellIndex.
	"w := state startDragWidth + anEvent delta x.
	w > 10 ifFalse: [ anEvent deny ]"
]

{ #category : #'divider dragging' }
ToTableDividerEventHandler >> dividerEndDragEvent: anEvent [

	| table divider |
	divider := anEvent currentTarget.
	table := divider parentTable.
	table requestDividersUpdate
]

{ #category : #'divider dragging' }
ToTableDividerEventHandler >> dividerStartDragEvent: anEvent [

	| divider table |
	divider := anEvent currentTarget.
	startDragPosition := divider constraints position.
	table := divider parentTable.
	table header divider: divider startDragAt: startDragPosition x
]

{ #category : #'api - accessing' }
ToTableDividerEventHandler >> eventsToHandle [

	^ {
		  ToDividerStartDragEvent.
		  ToDividerDragEvent.
		  ToDividerEndDragEvent }
]
