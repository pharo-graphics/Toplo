Class {
	#name : #ToScrollableElementEventHandler,
	#superclass : #BlScrollableElementEventHandler,
	#category : #'Toplo-Widget-Pane-Core'
}

{ #category : #'mouse handlers' }
ToScrollableElementEventHandler >> mouseWheelEvent: anEvent [
	
	anEvent currentTarget eventDispatcher wantsScrolledEvent ifFalse: [
		^ self ].
	super mouseWheelEvent: anEvent
]
