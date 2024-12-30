Class {
	#name : #ToMenuWindowEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #'api - accessing' }
ToMenuWindowEventHandler >> eventsToHandle [
	^ { BlMouseLeaveEvent }
]

{ #category : #'event handling' }
ToMenuWindowEventHandler >> mouseLeaveEvent: anEvent [

	anEvent currentTarget isOpened ifFalse: [ ^ self ].
	anEvent currentTarget itemList secondarySelecter deselectAll
]
