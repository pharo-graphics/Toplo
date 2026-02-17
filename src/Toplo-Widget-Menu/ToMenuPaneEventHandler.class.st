Class {
	#name : #ToMenuPaneEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-Menu-Pane'
}

{ #category : #'event handling' }
ToMenuPaneEventHandler >> elementExtentChangedEvent: anEvent [

	anEvent currentTarget requestConfiguration
]

{ #category : #'api - accessing' }
ToMenuPaneEventHandler >> eventsToHandle [

	^ {
		  BlMouseUpEvent.
		  BlLayoutResizerChangedEvent.
		  BlElementExtentChangedEvent }
]

{ #category : #'event handling' }
ToMenuPaneEventHandler >> layoutResizerChangedEvent: anEvent [

	anEvent currentTarget requestConfiguration
]

{ #category : #'event handling' }
ToMenuPaneEventHandler >> mouseUpEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target isEnabled ifFalse: [ ^ self ].
	" don't cancel auto-open if on a menu because it is started by a mouse up on root menus  "
	anEvent target
		withAllParentsUpTo: target
		do: [ :p | p isMenu ifTrue: [ ^ self ] ].
	target stopAutoOpen
]
