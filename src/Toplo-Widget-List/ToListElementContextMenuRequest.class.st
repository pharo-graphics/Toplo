Class {
	#name : #ToListElementContextMenuRequest,
	#superclass : #ToContextMenuRequest,
	#instVars : [
		'selection'
	],
	#category : #'Toplo-Widget-List-Context-menu'
}

{ #category : #accessing }
ToListElementContextMenuRequest >> selectedIndexes [

	^ self selection indices
]

{ #category : #accessing }
ToListElementContextMenuRequest >> selection [

	^ selection ifNil: [ selection := BlCompositeSelection new ]
]

{ #category : #sending }
ToListElementContextMenuRequest >> sendTo: anEvent [

	anEvent listElementContextMenuRequest: self
]
