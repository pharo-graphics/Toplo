Class {
	#name : #ToMenuBarAutoOpenEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'menuBar',
		'autoOpenDresser'
	],
	#category : #'Toplo-Widget-MenuBar'
}

{ #category : #accessing }
ToMenuBarAutoOpenEventHandler >> autoOpenDresser: anInstaller [
	" set the dresser that installed myself "
	autoOpenDresser := anInstaller
]

{ #category : #'api - accessing' }
ToMenuBarAutoOpenEventHandler >> buttonClickedEvent: anEvent [

	self removeAutoOpenDresser
]

{ #category : #'api - accessing' }
ToMenuBarAutoOpenEventHandler >> eventsToHandle [

	^ { BlSpaceMouseDownOutsideEvent. ToButtonClickedEvent }
]

{ #category : #accessing }
ToMenuBarAutoOpenEventHandler >> menuBar: aMenuBar [

	menuBar := aMenuBar
]

{ #category : #'api - accessing' }
ToMenuBarAutoOpenEventHandler >> mouseDownOutsideEvent: anEvent [

	self removeAutoOpenDresser
]

{ #category : #'api - accessing' }
ToMenuBarAutoOpenEventHandler >> removeAutoOpenDresser [

	autoOpenDresser ifNil: [ ^ self ].
	autoOpenDresser removeAutoOpenDresserIn: menuBar.
	autoOpenDresser := nil.
	menuBar := nil
]
