Class {
	#name : #ToPopupWindowDresser,
	#superclass : #ToBasicWindowDresser,
	#instVars : [
		'closeHandler',
		'widgetPositionHandler',
		'openedInSpaceHandler',
		'removedFromSpaceHandler'
	],
	#category : #'Toplo-Widget-Window'
}

{ #category : #'api - install/uninstall  hook' }
ToPopupWindowDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.
	openedInSpaceHandler := BlEventHandler on: BlElementAddedToSceneGraphEvent do: [ :event | 
		self openedInSpace: event in: anElement	].
	removedFromSpaceHandler := BlEventHandler on: BlElementRemovedFromSceneGraphEvent do: [ :event | 
		self removedFromSpace: event in: anElement	].
	anElement addEventHandler: openedInSpaceHandler.
	anElement addEventHandler: removedFromSpaceHandler
	
]

{ #category : #'api - install/uninstall  hook' }
ToPopupWindowDresser >> installWidget: newWidget in: anElement [

	super installWidget: newWidget in: anElement.
	newWidget ifNil: [ ^ self  ].
	widgetPositionHandler := BlEventHandler
		                         on: BlElementPositionChangedEvent
		                         do: [ :event | anElement close ].
	newWidget addEventHandler: widgetPositionHandler.
	super installWidget: newWidget in: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToPopupWindowDresser >> mouseUpOutside: anEvent in: aMenuWindow [

	" decide  if one have to close the window "

	" don't close if the clicked element is part of the menu "
	anEvent originalEvent currentTarget ifNotNil: [ :t |
		(t hasInParentChain: aMenuWindow widget) ifTrue: [ ^ self ] ].
	" ok, really outside "
	anEvent currentTarget close
]

{ #category : #'api - install/uninstall  hook' }
ToPopupWindowDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	
	anElement effect:
		(BlGaussianShadowEffect
			 color: Color gray
			 width: 5
			 offset: 2 asPoint)	



]

{ #category : #'api - install/uninstall  hook' }
ToPopupWindowDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToPopupWindowDresser >> openedInSpace: anEvent in: anElement [

	closeHandler := BlEventHandler
		                on: BlMouseUpOutsideEvent
		                do: [ :event | self mouseUpOutside: event in: anElement ].
	anElement addEventHandler: closeHandler
]

{ #category : #'api - install/uninstall  hook' }
ToPopupWindowDresser >> removedFromSpace: anEvent in: anElement [

	anElement removeEventHandler: closeHandler.
	closeHandler := nil
]

{ #category : #'api - install/uninstall  hook' }
ToPopupWindowDresser >> uninstallEventListenersIn: anElement [

	super installEventListenersIn: anElement.
	anElement removeEventHandler: openedInSpaceHandler.
	anElement removeEventHandler: removedFromSpaceHandler.
	closeHandler ifNotNil: [ anElement removeEventHandler: closeHandler ].
	closeHandler := nil.
	openedInSpaceHandler := nil.
	removedFromSpaceHandler := nil
	
]

{ #category : #'api - install/uninstall  hook' }
ToPopupWindowDresser >> uninstallWidget: oldWidget in: anElement [

	oldWidget ifNil: [ ^ self ].
	oldWidget removeEventHandler: widgetPositionHandler.
	widgetPositionHandler := nil.
	super uninstallWidget: oldWidget in: anElement
]
