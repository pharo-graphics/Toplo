Class {
	#name : #ToSelectEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'event handling' }
ToSelectEventHandler >> addedToSpaceEvent: anEvent [

	anEvent currentTarget refreshHeaderFromPopupListSelection 
]

{ #category : #'api - accessing' }
ToSelectEventHandler >> eventsToHandle [
	^ { ToAddedToSpaceEvent }
]
