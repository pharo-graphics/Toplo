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

	element space ifNil: [ " if my target is removed
		This can be the case if the parent is removed "
			holder ifNotNil: [ :h | h removeEventFilter: self ].
			^ self ].

	""" do nothing if it is inside my element ""
	(anEvent target withAllParentsInclude: element) ifTrue: [ ^ self ]."

	self onMouseUpEvent: anEvent
]

{ #category : #'api - hooks' }
ToMouseUpOutsideEventFilter >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	holder := anElement
]

{ #category : #'mouse handlers' }
ToMouseUpOutsideEventFilter >> onMouseUpEvent: anEvent [

	" ouside, consume mouse up and launch mouse up outside "
	"anEvent consume."

	element dispatchEvent: (ToMouseUpOutsideEvent new
			 sourceEvent: anEvent;
			 emitter: self;
			 fillFromTime: element space time;
			 yourself)
]

{ #category : #'api - hooks' }
ToMouseUpOutsideEventFilter >> onUninstalledIn: anElement [

	holder := nil.
	super onUninstalledIn: anElement

]
