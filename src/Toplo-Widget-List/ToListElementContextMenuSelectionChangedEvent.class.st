Class {
	#name : #ToListElementContextMenuSelectionChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'selectionModel',
		'sourceEvent'
	],
	#category : #'Toplo-Widget-List-Context-menu'
}

{ #category : #accessing }
ToListElementContextMenuSelectionChangedEvent >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToListElementContextMenuSelectionChangedEvent >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]

{ #category : #sending }
ToListElementContextMenuSelectionChangedEvent >> sendTo: anObject [

	anObject listElementContextMenuSelectionChangedEvent: self
]

{ #category : #accessing }
ToListElementContextMenuSelectionChangedEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToListElementContextMenuSelectionChangedEvent >> sourceEvent: anEvent [

	sourceEvent := anEvent
]
