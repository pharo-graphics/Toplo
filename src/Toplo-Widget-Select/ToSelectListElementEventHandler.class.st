Class {
	#name : #ToSelectListElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'select'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'api - accessing' }
ToSelectListElementEventHandler >> eventsToHandle [

	^ { ToSieveSelectionChangedEvent.  }
]

{ #category : #accessing }
ToSelectListElementEventHandler >> select: aSelect [

	select := aSelect
]

{ #category : #'element handlers' }
ToSelectListElementEventHandler >> sieveSelectionChangedEvent: anEvent [

	select selectionModel = anEvent selectionModel ifTrue: [ ^ self ].
	select selectionModel deselectAll.
	select selectionModel selectIndexes: anEvent selectionModel selectedIndexes.
	select strategy refreshHeaderNodeContainer.
	select dispatchEvent: ToSelectListSelectionChanged new
]
