Class {
	#name : 'ToListElementContextMenuSelectionChangedEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'selectedIndexes',
		'sourceEvent'
	],
	#category : 'Toplo-Widget-List-core',
	#package : 'Toplo-Widget-List',
	#tag : 'core'
}

{ #category : 'accessing' }
ToListElementContextMenuSelectionChangedEvent >> selectedIndexes [

	^ selectedIndexes
]

{ #category : 'accessing' }
ToListElementContextMenuSelectionChangedEvent >> selectedIndexes: aCollection [

	selectedIndexes := aCollection
]

{ #category : 'sending' }
ToListElementContextMenuSelectionChangedEvent >> sendTo: anObject [

	anObject listElementContextMenuSelectionChangedEvent: self
]

{ #category : 'accessing' }
ToListElementContextMenuSelectionChangedEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : 'accessing' }
ToListElementContextMenuSelectionChangedEvent >> sourceEvent: anEvent [

	sourceEvent := anEvent
]
