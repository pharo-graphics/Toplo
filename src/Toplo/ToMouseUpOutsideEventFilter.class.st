Class {
	#name : #ToMouseUpOutsideEventFilter,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'holder',
		'element'
	],
	#category : #'Toplo-Support-EventGenerator'
}

{ #category : #accessing }
ToMouseUpOutsideEventFilter >> element: anElement [

	element := anElement
]

{ #category : #'api - accessing' }
ToMouseUpOutsideEventFilter >> eventsToHandle [

	^ { BlMouseUpEvent }
]

{ #category : #'api - hooks' }
ToMouseUpOutsideEventFilter >> isInstalled [

	^ holder notNil
]

{ #category : #'mouse handlers' }
ToMouseUpOutsideEventFilter >> mouseUpEvent: anEvent [
	" 
	do nothing if the original event target is inside my target 
	"
	holder ifNil: [ ^ self ].
	" I'm a one shot event filter, so remove myself as an event filter here"
	holder removeEventFilter: self.

	element space ifNil: [ " if my target is removed
		This can be the case if the parent is removed "
		holder := nil.
		^ self ].

	" do nothing if it is inside my element "
	(anEvent target withAllParentsInclude: element) ifTrue: [ ^ self ].

	" ouside, consume mouse up and launch mouse up outside "
	anEvent consume.
	element dispatchEvent: (ToMouseUpOutsideEvent new
			 sourceEvent: anEvent;
			 fillFromTime: element space time;
			 yourself)
]

{ #category : #'api - hooks' }
ToMouseUpOutsideEventFilter >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	holder := anElement
]

{ #category : #'api - hooks' }
ToMouseUpOutsideEventFilter >> onUninstalledIn: anElement [

	holder := nil.
	super onUninstalledIn: anElement

]
