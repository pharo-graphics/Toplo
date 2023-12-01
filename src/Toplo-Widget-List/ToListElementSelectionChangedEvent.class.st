Class {
	#name : 'ToListElementSelectionChangedEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'newSelectedIndexes',
		'oldSelectedIndexes'
	],
	#category : 'Toplo-Widget-List-core',
	#package : 'Toplo-Widget-List',
	#tag : 'core'
}

{ #category : 'accessing' }
ToListElementSelectionChangedEvent >> newSelectedIndexes [

	^ newSelectedIndexes
]

{ #category : 'accessing' }
ToListElementSelectionChangedEvent >> newSelectedIndexes: aCollection [

	newSelectedIndexes := aCollection
]

{ #category : 'accessing' }
ToListElementSelectionChangedEvent >> oldSelectedIndexes [

	^ oldSelectedIndexes
]

{ #category : 'accessing' }
ToListElementSelectionChangedEvent >> oldSelectedIndexes: aCollection [

	oldSelectedIndexes := aCollection
]

{ #category : 'sending' }
ToListElementSelectionChangedEvent >> sendTo: anObject [

	anObject listElementSelectionChangedEvent: self
]
