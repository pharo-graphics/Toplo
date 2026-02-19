"
I delegate all events of type `eventClass` or ones that inherit from it to the event target.

I hold a strong reference to the event target

"
Class {
	#name : #ToUIEventDelegator,
	#superclass : #BlBasicEventHandler,
	#instVars : [
		'eventClasses',
		'eventTarget',
		'filters'
	],
	#category : #'Toplo-Core-States'
}

{ #category : #'instance creation' }
ToUIEventDelegator class >> delegate: anEventClassArray to: anEventTarget [
	^ self new
		eventClasses: anEventClassArray;
		eventTarget: anEventTarget;
		yourself
]

{ #category : #accessing }
ToUIEventDelegator >> eventClasses [

	^ eventClasses
]

{ #category : #accessing }
ToUIEventDelegator >> eventClasses: anEventClassArray [

	eventClasses := anEventClassArray
]

{ #category : #accessing }
ToUIEventDelegator >> eventTarget [

	^ eventTarget
]

{ #category : #accessing }
ToUIEventDelegator >> eventTarget: anObject [

	eventTarget := anObject
]

{ #category : #'api - event managing' }
ToUIEventDelegator >> handleEvent: anEvent [

	self eventTarget dispatchEvent: anEvent
]

{ #category : #'api - hooks' }
ToUIEventDelegator >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	" add event filters to set the event source that is checked by the skin event generator "
	filters := Array streamContents: [ :stream |
			           eventClasses do: [ :cls |
					           stream nextPut:
						           (anElement
							            addEventFilterOn: cls
							            do: [ :evt | evt source: anElement ]) ] ].
	eventTarget installedSkinStateGenerator pushAuthorizedSource: anElement
]

{ #category : #'api - hooks' }
ToUIEventDelegator >> onUninstalledIn: anElement [

	filters do: [ :f | anElement removeEventFilter: f ].
	filters := nil.
	eventTarget installedSkinStateGenerator popAuthorizedSource.
	super onUninstalledIn: anElement.

]

{ #category : #'api - event managing' }
ToUIEventDelegator >> wantsEvent: anEvent [
	
	^ eventClasses anySatisfy: [ :cls |
		  anEvent class == cls or: [ anEvent class inheritsFrom: cls ] ]
]
