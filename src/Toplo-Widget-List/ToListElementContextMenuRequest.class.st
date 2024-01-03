Class {
	#name : #ToListElementContextMenuRequest,
	#superclass : #ToContextMenuRequest,
	#instVars : [
		'selectedIndexes'
	],
	#category : #'Toplo-Widget-List-Context-menu'
}

{ #category : #accessing }
ToListElementContextMenuRequest >> selectedIndexes [

	^ selectedIndexes
]

{ #category : #accessing }
ToListElementContextMenuRequest >> selectedIndexes: aCollection [

	selectedIndexes := aCollection
]

{ #category : #sending }
ToListElementContextMenuRequest >> sendTo: anEvent [

	anEvent listElementContextMenuRequest: self
]
