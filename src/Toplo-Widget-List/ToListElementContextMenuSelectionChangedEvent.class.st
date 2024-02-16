Class {
	#name : #ToListElementContextMenuSelectionChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'selection',
		'sourceEvent',
		'node'
	],
	#category : #'Toplo-Widget-List-Context-menu'
}

{ #category : #accessing }
ToListElementContextMenuSelectionChangedEvent >> node [

	^ node
]

{ #category : #accessing }
ToListElementContextMenuSelectionChangedEvent >> node: aNode [

	node := aNode
]

{ #category : #accessing }
ToListElementContextMenuSelectionChangedEvent >> selection [

	^ selection ifNil: [ selection := BlCompositeSelection new ]
]

{ #category : #accessing }
ToListElementContextMenuSelectionChangedEvent >> selection: aSelection [

	selection := aSelection
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
