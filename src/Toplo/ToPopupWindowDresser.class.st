Class {
	#name : #ToPopupWindowDresser,
	#superclass : #ToBasicWindowDresser,
	#instVars : [
		'closeHandler',
		'widgetPositionHandler'
	],
	#category : #'Toplo-window'
}

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
	anEvent originalEvent target ifNotNil: [ :t |
		(t hasInParentChain: aMenuWindow widget) ifTrue: [ ^ self ] ].
	" ok, really outside "
	anEvent consumed: true.
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
	anElement addEventFilter: closeHandler.
	anElement switchToSkinState: ToOpenState new
]

{ #category : #'api - install/uninstall  hook' }
ToPopupWindowDresser >> removedFromSpace: anEvent in: anElement [

	anElement removeEventFilter: closeHandler.
	closeHandler := nil.
	anElement switchToSkinState: ToCloseState new
]

{ #category : #'api - install/uninstall  hook' }
ToPopupWindowDresser >> uninstallEventListenersIn: anElement [

	super uninstallEventListenersIn: anElement.
	closeHandler ifNotNil: [ anElement removeEventFilter: closeHandler ].
	closeHandler := nil	
]

{ #category : #'api - install/uninstall  hook' }
ToPopupWindowDresser >> uninstallWidget: oldWidget in: anElement [

	oldWidget ifNil: [ ^ self ].
	oldWidget removeEventHandler: widgetPositionHandler.
	widgetPositionHandler := nil.
	super uninstallWidget: oldWidget in: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToPopupWindowDresser >> whenAddedToSpace: anvent in: anElement [

	super whenAddedToSpace: anvent in: anElement.
	self openedInSpace: anvent in: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToPopupWindowDresser >> whenRemovedFromSpace: anEvent in: anElement [

	super whenRemovedFromSpace: anEvent in: anElement.
	self removedFromSpace: anEvent in: anElement
]
