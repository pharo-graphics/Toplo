Class {
	#name : #ToBarElementEventHandler,
	#superclass : #ToListElementEventHandler,
	#category : #'Toplo-Widget-List-Core-BarElement'
}

{ #category : #'api - accessing' }
ToBarElementEventHandler >> eventsToHandle [

	^ super eventsToHandle, {
		  ToMainLayoutDirectionChangedEvent.
		  ToMainLayoutOrientationChangedEvent.
		  ToMainResizerChangedEvent }
]

{ #category : #layout }
ToBarElementEventHandler >> mainLayoutDirectionChangedEvent: anEvent [

	anEvent currentTarget configureLayout
]

{ #category : #layout }
ToBarElementEventHandler >> mainLayoutOrientationChangedEvent: anEvent [

	anEvent currentTarget configureLayout
]

{ #category : #layout }
ToBarElementEventHandler >> mainResizerChangedEvent: anEvent [

	anEvent currentTarget configureLayout
]
