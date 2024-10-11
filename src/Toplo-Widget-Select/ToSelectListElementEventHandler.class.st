Class {
	#name : #ToSelectListElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'select'
	],
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #'api - accessing' }
ToSelectListElementEventHandler >> eventsToHandle [

	^ { ToSieveSelectionChangedEvent }
]

{ #category : #accessing }
ToSelectListElementEventHandler >> select: aSelect [

	select := aSelect
]

{ #category : #'element handlers' }
ToSelectListElementEventHandler >> sieveSelectionChangedEvent: anEvent [

	select onSelectionChangedInPopupListElement: anEvent
]
