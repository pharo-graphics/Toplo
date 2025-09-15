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

{ #category : #testing }
ToMouseUpOutsideEventFilter >> isElementOutside [

	" is the element iside or outside ? 
	ifTrue, a mouse up on the element is considered as an outside event"
	^ false
]

{ #category : #'api - hooks' }
ToMouseUpOutsideEventFilter >> isInstalled [

	^ holder notNil
]

{ #category : #'mouse handlers' }
ToMouseUpOutsideEventFilter >> isMouseUpOnElement: anEvent [
	" do nothing if it is inside my element "

	^ anEvent target withAllParentsInclude: element
]

{ #category : #'mouse handlers' }
ToMouseUpOutsideEventFilter >> isMouseUpOutsideEvent: anEvent [
	" do nothing if it is inside my element "

	" is the mouse up occurs on the element itsef ?"
	(self isMouseUpOnElement: anEvent) ifTrue: [
		" is the element considered as outside ? "
		^ self isElementOutside ].
	" mouse up outside the element detected "
	^ true
]

{ #category : #'mouse handlers' }
ToMouseUpOutsideEventFilter >> mouseUpEvent: anEvent [
	" 
	do nothing if the original event target is inside my target 
	"

	holder ifNil: [ ^ self ].
	holder isAttachedToSceneGraph ifFalse: [ " if my target is removed
		This can be the case if the parent is removed "
			holder removeEventFilter: self.
			^ self ].

	(self isMouseUpOutsideEvent: anEvent) ifFalse: [ ^ self ].

	" ok, the event is outside. Consuming should be done outside "
	element dispatchEvent: (ToMouseUpOutsideEvent new
			 sourceEvent: anEvent;
			 emitter: self;
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

{ #category : #'api - hooks' }
ToMouseUpOutsideEventFilter >> stop [

	holder ifNil: [ ^ self ].
	holder removeEventFilter: self
]
