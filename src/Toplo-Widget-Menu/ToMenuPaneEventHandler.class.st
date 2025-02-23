Class {
	#name : #ToMenuPaneEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'target'
	],
	#category : #'Toplo-Widget-Menu-Pane'
}

{ #category : #'api - accessing' }
ToMenuPaneEventHandler >> eventsToHandle [

	^ {
		  BlMouseLeaveEvent.
		  BlMouseOverEvent.
		  ToLayoutOrientationChangedEvent.
		  ToLayoutDirectionChangedEvent.
		  BlLayoutResizerChangedEvent }
]

{ #category : #'event handling' }
ToMenuPaneEventHandler >> layoutDirectionChangedEvent: anEvent [

	anEvent currentTarget requestInnerConfiguration
]

{ #category : #'event handling' }
ToMenuPaneEventHandler >> layoutOrientationChangedEvent: anEvent [

	target isHorizontal
		ifTrue: [
			target isWrapping: false.
			target hasUniformNodeWidth: false ]
		ifFalse: [
			target isWrapping: true.
			target hasUniformNodeWidth: true ]
]

{ #category : #'event handling' }
ToMenuPaneEventHandler >> layoutResizerChangedEvent: anEvent [

	anEvent currentTarget requestInnerConfiguration
]

{ #category : #'event handling' }
ToMenuPaneEventHandler >> mouseLeaveEvent: anEvent [

	target itemBar secondarySelecter deselectAll
]

{ #category : #'event handling' }
ToMenuPaneEventHandler >> mouseOverEvent: anEvent [

	target mouseOverEvent: anEvent
]

{ #category : #'api - hooks' }
ToMenuPaneEventHandler >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	target := anElement
]

{ #category : #'api - hooks' }
ToMenuPaneEventHandler >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	target := nil
]
