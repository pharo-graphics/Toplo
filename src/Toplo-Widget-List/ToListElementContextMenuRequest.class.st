Class {
	#name : 'ToListElementContextMenuRequest',
	#superclass : 'ToContextMenuRequest',
	#instVars : [
		'selectionIndexes',
		'secondarySelectionIndexes'
	],
	#category : 'Toplo-Widget-List-core',
	#package : 'Toplo-Widget-List',
	#tag : 'core'
}

{ #category : 'accessing' }
ToListElementContextMenuRequest >> secondarySelectionIndexes [

	^ secondarySelectionIndexes
]

{ #category : 'accessing' }
ToListElementContextMenuRequest >> secondarySelectionIndexes: aCollection [

	secondarySelectionIndexes := aCollection
]

{ #category : 'accessing' }
ToListElementContextMenuRequest >> selectionIndexes [

	^ selectionIndexes
]

{ #category : 'accessing' }
ToListElementContextMenuRequest >> selectionIndexes: aCollection [

	selectionIndexes := aCollection
]

{ #category : 'sending' }
ToListElementContextMenuRequest >> sendTo: anEvent [

	anEvent listElementContextMenuRequest: self
]
