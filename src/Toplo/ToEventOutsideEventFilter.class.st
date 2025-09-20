Class {
	#name : #ToEventOutsideEventFilter,
	#superclass : #BlBasicEventHandler,
	#instVars : [
		'holder',
		'element'
	],
	#category : #'Toplo-Support-EventGenerator'
}

{ #category : #accessing }
ToEventOutsideEventFilter >> element: anElement [

	element := anElement
]

{ #category : #testing }
ToEventOutsideEventFilter >> isElementIgnored [

	" is the element inide or outside ? 
	ifTrue, a mouse up on the element is considered as an outside event"
	^ false
]

{ #category : #'mouse handlers' }
ToEventOutsideEventFilter >> isEventOnElement: anEvent [
	" do nothing if it is inside my element "

	^ anEvent target withAllParentsInclude: element
]

{ #category : #'api - hooks' }
ToEventOutsideEventFilter >> isInstalled [

	^ holder notNil
]

{ #category : #'mouse handlers' }
ToEventOutsideEventFilter >> isOutsideEvent: anEvent [
	" do nothing if it is inside my element "

	" is the mouse up occurs on the element itsef ?"
	(self isEventOnElement: anEvent) ifTrue: [
		" is the element considered as outside ? "
		^ self isElementIgnored ].
	" mouse up outside the element detected "
	^ true
]

{ #category : #'api - hooks' }
ToEventOutsideEventFilter >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	holder := anElement
]

{ #category : #'api - hooks' }
ToEventOutsideEventFilter >> onUninstalledIn: anElement [

	holder := nil.
	super onUninstalledIn: anElement

]

{ #category : #'api - hooks' }
ToEventOutsideEventFilter >> stop [

	holder ifNil: [ ^ self ].
	holder removeEventFilter: self
]
