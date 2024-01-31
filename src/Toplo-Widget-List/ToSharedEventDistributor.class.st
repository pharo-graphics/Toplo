Class {
	#name : #ToSharedEventDistributor,
	#superclass : #BlSharedEventDistributor,
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'api - event managing' }
ToSharedEventDistributor >> dispatch: aBlEvent on: anElement [

	| aNewEvent |
	shouldHandle ifFalse: [ ^ self ].

	aNewEvent := aBlEvent newCopyFor: anElement.
	aBlEvent isMouse ifTrue: [
		self adjustPosition: aNewEvent from: aBlEvent ].

	shouldHandle := false.
	[ 
	"anElement trace. ' dispatch: ' trace. aNewEvent class name traceCr."
	anElement dispatchEvent: aNewEvent ] ensure: [
		shouldHandle := true ].

	"Update the original event from the copy .
	This is necessary if event processing depends on #isConsumed 
	as an example (e.g. dnd processing)"
	aBlEvent copySharedStatesFrom: aNewEvent.
]

{ #category : #'api - event managing' }
ToSharedEventDistributor >> handleEvent: anEvent [

	shouldHandle ifFalse: [ 'should not handle: ' trace.  anEvent traceCr. ^ self ].
	elements do: [ :eachElement |
		anEvent currentTarget = eachElement ifFalse: [
			self dispatch: anEvent on: eachElement ] ]
]
