Class {
	#name : #ToListElementContextMenuRequest,
	#superclass : #ToContextMenuRequest,
	#instVars : [
		'selectionIndexes'
	],
	#category : 'Toplo-Widget-List-Context-menu'
}

{ #category : #accessing }
ToListElementContextMenuRequest >> selectionIndexes [

	^ selectionIndexes
]

{ #category : #accessing }
ToListElementContextMenuRequest >> selectionIndexes: aCollection [

	selectionIndexes := aCollection
]

{ #category : #sending }
ToListElementContextMenuRequest >> sendTo: anEvent [

	anEvent listElementContextMenuRequest: self
]
