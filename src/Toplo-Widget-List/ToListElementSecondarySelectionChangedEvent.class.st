Class {
	#name : 'ToListElementSecondarySelectionChangedEvent',
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
ToListElementSecondarySelectionChangedEvent >> selectedIndexes [

	^ selectedIndexes
]

{ #category : 'accessing' }
ToListElementSecondarySelectionChangedEvent >> selectedIndexes: aCollection [

	selectedIndexes := aCollection
]

{ #category : 'sending' }
ToListElementSecondarySelectionChangedEvent >> sendTo: anObject [

	anObject listElementSecondarySelectionChangedEvent: self
]

{ #category : 'accessing' }
ToListElementSecondarySelectionChangedEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : 'accessing' }
ToListElementSecondarySelectionChangedEvent >> sourceEvent: anEvent [

	sourceEvent := anEvent
]
