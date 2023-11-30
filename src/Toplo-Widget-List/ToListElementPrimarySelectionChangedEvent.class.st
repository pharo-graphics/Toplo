Class {
	#name : 'ToListElementPrimarySelectionChangedEvent',
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
ToListElementPrimarySelectionChangedEvent >> newSelectedIndexes [

	^ newSelectedIndexes
]

{ #category : 'accessing' }
ToListElementPrimarySelectionChangedEvent >> newSelectedIndexes: aCollection [

	newSelectedIndexes := aCollection
]

{ #category : 'accessing' }
ToListElementPrimarySelectionChangedEvent >> oldSelectedIndexes [

	^ oldSelectedIndexes
]

{ #category : 'accessing' }
ToListElementPrimarySelectionChangedEvent >> oldSelectedIndexes: aCollection [

	oldSelectedIndexes := aCollection
]

{ #category : 'sending' }
ToListElementPrimarySelectionChangedEvent >> sendTo: anObject [

	anObject listElementPrimarySelectionChangedEvent: self
]
