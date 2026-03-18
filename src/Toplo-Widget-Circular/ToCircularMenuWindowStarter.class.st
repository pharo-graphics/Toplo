Class {
	#name : #ToCircularMenuWindowStarter,
	#superclass : #ToWindowStarter,
	#category : #'Toplo-Widget-Circular-Menu'
}

{ #category : #'starting-stopping' }
ToCircularMenuWindowStarter >> startWindow: aWindow fromManager: aManager onEvent: anEvent [

	| menuItem |
	aWindow lastPopupEvent: anEvent.
	aWindow localTheme ifNil: [
		aWindow localTheme: aManager anchorElement lookupTheme ].
	aWindow refreshLayout.

	menuItem := aWindow menuItem.

	" if encompassing, then a sub menu window must be added *** before *** the parent menu 
	window or menu pane to not hide it (let it over the sub-menu) 
	and allow user interactions with the parent."
	menuItem encompassing ifTrue: [
			| sibling parent |
			sibling := menuItem isSubmenu
				           ifTrue: [ menuItem parentMenu menuWindow ]
				           ifFalse: [ menuItem menuPane ].
			sibling ifNotNil: [
					parent := sibling parent.
					^ parent addChild: aWindow before: sibling ] ].

	aManager anchorRoot addChild: aWindow
]

{ #category : #'starting-stopping' }
ToCircularMenuWindowStarter >> stopWindow: aWindow fromManager: aManager [

	aWindow removeFromParent
]
