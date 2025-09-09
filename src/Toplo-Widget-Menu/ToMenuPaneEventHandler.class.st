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
		  BlMouseUpEvent.
		  BlLayoutResizerChangedEvent }
]

{ #category : #'event handling' }
ToMenuPaneEventHandler >> layoutResizerChangedEvent: anEvent [

	anEvent currentTarget requestConfiguration
]

{ #category : #'event handling' }
ToMenuPaneEventHandler >> mouseLeaveEvent: anEvent [

	target itemBar secondarySelecter deselectAll
]

{ #category : #'event handling' }
ToMenuPaneEventHandler >> mouseOverEvent: anEvent [

	| menus |
	target isAutoOpen ifFalse: [ ^ self ].

	" auto-open action "
	" get all menus "
	menus := target items select: [ :m |
		         m isItemContainer and: [ m isInline not ] ].
	" 
	if over a child of a menu or over a menu itself, then
	popup the menu window if it is closed.
	if over another element of the bar, then close all menu windows"
	menus do: [ :m |
			(anEvent target withAllParentsInclude: m)
				ifTrue: [ m menuWindow ifNil: [ m popupEvent: anEvent ] ]
				ifFalse: [ m closeWindow ] ]
]

{ #category : #'event handling' }
ToMenuPaneEventHandler >> mouseUpEvent: anEvent [

	target isEnabled ifFalse: [ ^ self ].
	" don't cancel auto-open if on a menu because it is started by a mouse up on root menus  "
	anEvent target
		withAllParentsUpTo: target
		do: [ :p | p isMenu ifTrue: [ ^ self ] ].
	target cancelAutoOpen
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
