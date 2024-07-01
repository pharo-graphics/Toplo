Class {
	#name : #ToListElementContextMenuRequest,
	#superclass : #ToContextMenuRequest,
	#instVars : [
		'selectionModel'
	],
	#category : #'Toplo-Widget-List-Context-menu'
}

{ #category : #accessing }
ToListElementContextMenuRequest >> selectedIndexes [

	^ selectionModel selectedIndexes
]

{ #category : #accessing }
ToListElementContextMenuRequest >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]

{ #category : #sending }
ToListElementContextMenuRequest >> sendTo: anEvent [

	anEvent listElementContextMenuRequest: self
]
