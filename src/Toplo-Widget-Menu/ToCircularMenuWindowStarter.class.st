Class {
	#name : #ToCircularMenuWindowStarter,
	#superclass : #ToWindowStarter,
	#category : #'Toplo-Widget-Menu-Circular'
}

{ #category : #'starting-stopping' }
ToCircularMenuWindowStarter >> startWindow: aWindow fromManager: aManager onEvent: anEvent [

	| menuItem |
	
	aWindow lastPopupEvent: anEvent.
	aWindow localTheme ifNil: [
		aWindow localTheme: aManager anchorElement lookupTheme ].
	aWindow refreshLayout.

	menuItem := aWindow menuItem.

	menuItem encompassing ifTrue: [
			menuItem isSubmenu ifTrue: [
					^ aManager anchorRoot
						  addChild: aWindow
						  before: menuItem parentMenu menuWindow ].
			menuItem isMenuPaneMenu ifTrue: [
				^ aManager anchorRoot addChild: aWindow before: menuItem menuPane ] ].
	
	aManager anchorRoot addChild: aWindow
]

{ #category : #'starting-stopping' }
ToCircularMenuWindowStarter >> stopWindow: aWindow fromManager: aManager [

	aWindow removeFromParent
]
