Class {
	#name : #ToCircularMenuWindowStarter,
	#superclass : #ToWindowStarter,
	#category : #'Toplo-Core-Window'
}

{ #category : #'starting-stopping' }
ToCircularMenuWindowStarter >> startWindow: aWindow fromManager: aManager onEvent: anEvent [

	aWindow lastPopupEvent: anEvent.
	aWindow localTheme ifNil: [
		aWindow localTheme: aManager anchorElement lookupTheme ].
	aWindow refreshLayout.
	aWindow menuItem isSubmenu ifTrue: [
			^ aManager anchorRoot
				  addChild: aWindow
				  before: aWindow menuItem parentMenu menuWindow ].
	aWindow menuItem isMenuPaneMenu ifTrue: [
			^ aManager anchorRoot
				  addChild: aWindow
				  before: aWindow menuItem menuPane ].
	aManager anchorRoot addChild: aWindow
]

{ #category : #'starting-stopping' }
ToCircularMenuWindowStarter >> stopWindow: aWindow fromManager: aManager [

	aWindow removeFromParent
]
