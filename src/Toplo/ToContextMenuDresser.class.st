Class {
	#name : #ToContextMenuDresser,
	#superclass : #ToMenuWindowDresser,
	#instVars : [
		'popupTimeHandler',
		'openSourceEvent'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'api - install/uninstall  hook' }
ToContextMenuDresser >> autoCloseOnMouseUpDelay [

	^ 400 milliSeconds 
]

{ #category : #'api - install/uninstall  hook' }
ToContextMenuDresser >> installWidget: newWidget in: anElement [

	popupTimeHandler := BlEventHandler on: ToWidgetWindowOpenedEvent do: [ :event | self windowOpenedEvent: event ].
	newWidget addEventHandler: popupTimeHandler.
	super installWidget: newWidget in: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToContextMenuDresser >> mouseOutside: anEvent in: aMenuWindow [

	| origEventTarget |
	origEventTarget := anEvent originalEvent currentTarget.
	origEventTarget ifNil: [
		^ super mouseOutside: anEvent in: aMenuWindow ].
	(origEventTarget hasInParentChain: aMenuWindow widget) ifTrue: [ 
		" mouse up on the context menu widget, let's close the menu if the delay between opening and mouse up is short enough"
		(anEvent originalEvent timestamp - openSourceEvent timestamp) > self autoCloseOnMouseUpDelay ifTrue: [ 
			^ anEvent currentTarget close ] ].
	super mouseOutside: anEvent in: aMenuWindow
]

{ #category : #'api - install/uninstall  hook' }
ToContextMenuDresser >> uninstallWidget: oldWidget in: anElement [

	oldWidget ifNotNil: [
		oldWidget removeEventHandler: popupTimeHandler.
		popupTimeHandler := nil ].
	super uninstallWidget: oldWidget in: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToContextMenuDresser >> windowOpenedEvent: event [

	openSourceEvent := event sourceEvent
]
