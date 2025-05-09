Class {
	#name : #ToStillPressedPickOutsideEventFilter,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'holder',
		'element'
	],
	#category : #'Toplo-Support-EventGenerator'
}

{ #category : #accessing }
ToStillPressedPickOutsideEventFilter >> element: anElement [

	element := anElement
]

{ #category : #'api - accessing' }
ToStillPressedPickOutsideEventFilter >> eventsToHandle [

	^ { BlMouseUpEvent }
]

{ #category : #'api - hooks' }
ToStillPressedPickOutsideEventFilter >> isInstalled [

	^ holder notNil
]

{ #category : #'mouse handlers' }
ToStillPressedPickOutsideEventFilter >> mouseUpEvent: anEvent [
	" 
	do nothing if the original event target is inside my target 
	"

	element space ifNil: [ " if my target is removed
		This can be the case if the parent is removed "
		holder removeEventFilter: self.
		holder := nil.
		^ self ].

	" It it ouside my target, do nothing "
	(anEvent target withAllParentsInclude: element) ifTrue: [ ^ self ].

	anEvent consume.
	holder ifNil: [ ^ self ].
	" ok, mouseUp outside the element and outside of the popup window "
	holder removeEventFilter: self.
	element dispatchEvent: (ToPickOutsideEvent new
			 sourceEvent: anEvent;
			 fillFromTime: element space time;
			 yourself)
]

{ #category : #'api - hooks' }
ToStillPressedPickOutsideEventFilter >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	holder := anElement
]

{ #category : #'api - hooks' }
ToStillPressedPickOutsideEventFilter >> onUninstalledIn: anElement [

	holder := nil.
	super onUninstalledIn: anElement

]
