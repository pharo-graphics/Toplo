Class {
	#name : #ToMenuContainerEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #'api - accessing' }
ToMenuContainerEventHandler >> eventsToHandle [
	^ { BlMouseLeaveEvent }
]

{ #category : #'event handling' }
ToMenuContainerEventHandler >> mouseLeaveEvent: anEvent [

	anEvent currentTarget isOpened ifFalse: [ ^ self ].
	anEvent currentTarget itemList secondarySelecter deselectAll
]
