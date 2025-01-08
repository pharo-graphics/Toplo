Class {
	#name : #ToMenuBarEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'target'
	],
	#category : #'Toplo-Widget-Menu-Bar'
}

{ #category : #'api - accessing' }
ToMenuBarEventHandler >> eventsToHandle [

	^ {
		  BlMouseLeaveEvent.
		  BlMouseOverEvent.
		  ToLayoutOrientationChangedEvent.
		  ToLayoutDirectionChangedEvent.
		  BlLayoutResizerChangedEvent }
]

{ #category : #'event handling' }
ToMenuBarEventHandler >> layoutDirectionChangedEvent: anEvent [

	anEvent currentTarget configureLayout
]

{ #category : #'event handling' }
ToMenuBarEventHandler >> layoutOrientationChangedEvent: anEvent [

	target isHorizontal
		ifTrue: [
			target nodeWrapping: false.
			target uniformNodeWidth: false ]
		ifFalse: [
			target nodeWrapping: true.
			target uniformNodeWidth: true ].
	anEvent currentTarget configureLayout
]

{ #category : #'event handling' }
ToMenuBarEventHandler >> layoutResizerChangedEvent: anEvent [

	anEvent currentTarget configureLayout
]

{ #category : #'event handling' }
ToMenuBarEventHandler >> mouseLeaveEvent: anEvent [

	target itemList secondarySelecter deselectAll
]

{ #category : #'event handling' }
ToMenuBarEventHandler >> mouseOverEvent: anEvent [

	target mouseOverEvent: anEvent
]

{ #category : #'api - hooks' }
ToMenuBarEventHandler >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	target := anElement
]

{ #category : #'api - hooks' }
ToMenuBarEventHandler >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	target := nil
]
