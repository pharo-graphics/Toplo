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

	^ self selectionModel selectedIndexes
]

{ #category : #accessing }
ToListElementContextMenuRequest >> selectionModel [

	^ selectionModel ifNil: [ selectionModel := ToSelectionModel new ]
]

{ #category : #accessing }
ToListElementContextMenuRequest >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel 
]

{ #category : #sending }
ToListElementContextMenuRequest >> sendTo: anEvent [

	anEvent listElementContextMenuRequest: self
]
