Class {
	#name : #ToMenuWindowManager,
	#superclass : #ToPopupWindowManager,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'window handling' }
ToMenuWindowManager >> autoCloseWindow [

	super autoCloseWindow.
	element menuBarDo: [ :mb | mb cancelAutoOpen ]
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

{ #category : #'event handling' }
ToMenuWindowManager >> mouseDownEvent: anEvent [

	super mouseDownEvent: anEvent.
	(element itemContaining: anEvent target) ifNotNil: [ :found |
		found isMenu ifTrue: [
			element menuBarDo: [ :mb | mb switchAutoOpen ] ] ].
]

{ #category : #'event handling' }
ToMenuWindowManager >> pickOutsideEvent: anEvent [

	super pickOutsideEvent: anEvent.
	element menuBarDo: [ :mb | mb cancelAutoOpen ]
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
