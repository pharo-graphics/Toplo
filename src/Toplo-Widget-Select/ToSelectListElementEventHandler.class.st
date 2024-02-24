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

	^ { ToSieveSelectionChangedEvent. ToListClickOnNodePreNotificationEvent }
]

{ #category : #'element handlers' }
ToSelectListElementEventHandler >> listClickOnNodePreNotificationEvent: anEvent [

	"select listElement isMultipleSelection ifFalse: [ select listElement selectionModel deselectAll ]"
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
	select strategy refreshHeaderNodeContainer
]
