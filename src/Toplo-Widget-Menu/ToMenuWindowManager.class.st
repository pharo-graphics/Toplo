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

{ #category : #initializing }
ToMenuWindowManager >> defaultPlacement [

	^ ToMenuPlacement new
]

{ #category : #'api - accessing' }
ToMenuWindowManager >> eventsToHandle [

	^ super eventsToHandle , {
		  BlMouseEnterEvent.
		  BlMouseLeaveEvent }
]

{ #category : #'event handling' }
ToMenuWindowManager >> mouseDownEvent: anEvent [

	super mouseDownEvent: anEvent.
	(element itemContaining: anEvent target) ifNotNil: [ :found |
		found isMenu ifTrue: [
			element menuBarDo: [ :mb | mb switchAutoOpen ] ] ].
]

{ #category : #'event handling' }
ToMenuWindowManager >> mouseEnterEvent: anEvent [

	element itemList secondarySelecter deselectAll
]

{ #category : #'event handling' }
ToMenuWindowManager >> mouseLeaveEvent: anEvent [

	element itemList secondarySelecter deselectAll
]

{ #category : #'window handling' }
ToMenuWindowManager >> onClosed [ 

	super onClosed.
	element itemList secondarySelecter deselectAll
]

{ #category : #'window handling' }
ToMenuWindowManager >> onOpened [

	super onOpened.
	element itemList requestFocus
]

{ #category : #'event handling' }
ToMenuWindowManager >> pickOutsideEvent: anEvent [

	super pickOutsideEvent: anEvent.
	element menuBarDo: [ :mb | mb cancelAutoOpen ]
]

{ #category : #'window handling' }
ToMenuWindowManager >> popupNewWindowEvent: anEvent [

	"element items ifEmpty: [ ^ self ]."
	super popupNewWindowEvent: anEvent
]

{ #category : #accessing }
ToMenuWindowManager >> popupWindowClass [

	^ ToMenuWindow 
]
