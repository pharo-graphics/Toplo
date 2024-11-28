Class {
	#name : #ToMenuWindowManager,
	#superclass : #ToPopupWindowManager,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'event handling' }
ToMenuWindowManager >> cancelAutoOpenOnMenu: aMenu [

	aMenu isTopMenu ifFalse: [ ^ self ].
	aMenu parentItemContainer isMenuBar ifFalse: [ ^ self ].
	aMenu parentItemContainer cancelAutoOpen 
]

{ #category : #'event handling' }
ToMenuWindowManager >> closeWindowOnMouseDownEvent: anEvent [

	| menu |
	super closeWindowOnMouseDownEvent: anEvent.
	menu := anEvent currentTarget.
	self cancelAutoOpenOnMenu: menu
]

{ #category : #'event handling' }
ToMenuWindowManager >> closeWindowOnMouseUp: anEvent [

	| menu |
	super closeWindowOnMouseUp: anEvent.
	menu := anEvent currentTarget.
	self cancelAutoOpenOnMenu: menu
]

{ #category : #initialization }
ToMenuWindowManager >> defaultPositionHook [

	^ [ :window :theMenu :event |
	  window position: (theMenu isSubmenu
			   ifTrue: [
			   (theMenu bounds inParent: self anchorRoot) bounds topRight ]
			   ifFalse: [
			   (theMenu bounds inParent: self anchorRoot) bounds bottomLeft ]) ]
]

{ #category : #'window handling' }
ToMenuWindowManager >> popupNewWindowEvent: anEvent [

	element items ifEmpty: [ ^ self ].
	super popupNewWindowEvent: anEvent
]

{ #category : #accessing }
ToMenuWindowManager >> windowClass [

	^ ToMenuWindow 
]
