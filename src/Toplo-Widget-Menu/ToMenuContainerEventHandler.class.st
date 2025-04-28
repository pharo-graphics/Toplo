Class {
	#name : #ToMenuContainerEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #'event handling' }
ToMenuContainerEventHandler >> elementExtentChangedEvent: anEvent [

	anEvent currentTarget refreshLayout
]

{ #category : #'api - accessing' }
ToMenuContainerEventHandler >> eventsToHandle [
	^ { BlMouseLeaveEvent. BlElementExtentChangedEvent }
]

{ #category : #'event handling' }
ToMenuContainerEventHandler >> mouseLeaveEvent: anEvent [

	anEvent currentTarget isOpened ifFalse: [ ^ self ].
	anEvent currentTarget itemBar secondarySelecter deselectAll
]
