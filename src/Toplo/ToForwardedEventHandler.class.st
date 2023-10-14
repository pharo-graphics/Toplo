Class {
	#name : 'ToForwardedEventHandler',
	#superclass : 'BlCustomEventHandler',
	#category : 'Toplo-Core',
	#package : 'Toplo',
	#tag : 'Core'
}

{ #category : 'api - accessing' }
ToForwardedEventHandler >> eventsToHandle [

	^ self subclassResponsibility 
]

{ #category : 'api - event managing' }
ToForwardedEventHandler >> handleEvent: anEvent [
	" The event can come from the infinite element. 
	In that case, the event is re-dispatched from here to allow client to simply 
	add handlers to my list element (and not have to ask to my infinite)"

	|  originalSource |
	" if the event has been dispatched from here "
	anEvent source = anEvent currentTarget ifTrue: [
		^ super handleEvent: anEvent ].
	" if not, then clone the event and re-dispatch it from here"
	originalSource := anEvent source.
	anEvent source: anEvent currentTarget.
	anEvent currentTarget dispatchEvent: anEvent.
	anEvent source: originalSource 
	
	
]
