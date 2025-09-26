Class {
	#name : #ToOutsideEventFilter,
	#superclass : #BlBasicEventHandler,
	#instVars : [
		'holder',
		'element'
	],
	#category : #'Toplo-Support-EventGenerator'
}

{ #category : #'mouse handlers' }
ToOutsideEventFilter >> dispatchOutsideEventOn: anEvent [

	element dispatchEvent: (anEvent asOutsideEvent
			 sourceEvent: anEvent;
			 emitter: self;
			 yourself)
]

{ #category : #accessing }
ToOutsideEventFilter >> element: anElement [

	element := anElement
]

{ #category : #testing }
ToOutsideEventFilter >> isElementIgnored [

	" is the element inide or outside ? 
	ifTrue, a mouse up on the element is considered as an outside event"
	^ false
]

{ #category : #'mouse handlers' }
ToOutsideEventFilter >> isEventOnElement: anEvent [
	" do nothing if it is inside my element "

	^ anEvent target withAllParentsInclude: element
]

{ #category : #'api - hooks' }
ToOutsideEventFilter >> isInstalled [

	^ holder notNil
]

{ #category : #'mouse handlers' }
ToOutsideEventFilter >> isOutsideEvent: anEvent [
	" do nothing if it is inside my element "

	" is the mouse up occurs on the element itsef ?"
	(self isEventOnElement: anEvent) ifTrue: [
		" is the element considered as outside ? "
		^ self isElementIgnored ].
	" mouse up outside the element detected "
	^ true
]

{ #category : #'api - hooks' }
ToOutsideEventFilter >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	holder := anElement
]

{ #category : #'api - hooks' }
ToOutsideEventFilter >> onUninstalledIn: anElement [

	holder := nil.
	super onUninstalledIn: anElement

]

{ #category : #'api - hooks' }
ToOutsideEventFilter >> stop [

	holder ifNil: [ ^ self ].
	holder removeEventFilter: self
]
