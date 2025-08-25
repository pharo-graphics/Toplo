Class {
	#name : #ToMenuPopupManager,
	#superclass : #ToPopupWindowManager,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #'window handling' }
ToMenuPopupManager >> beInline [ 

	super beInline.
	anchorElement openOnHovered: false
]

{ #category : #initialization }
ToMenuPopupManager >> defaultMeasurement [

	^ ToMenuMeasurement new
]

{ #category : #initialization }
ToMenuPopupManager >> defaultPlacement [

	^ ToMenuPlacement new
]

{ #category : #accessing }
ToMenuPopupManager >> defaultWindowClass [

	^ ToMenuWindow
]

{ #category : #'api - accessing' }
ToMenuPopupManager >> eventsToHandle [

	^ super eventsToHandle , {
		  BlMouseEnterEvent.
		  BlMouseLeaveEvent }
]

{ #category : #'window handling' }
ToMenuPopupManager >> forceCloseWindowOnEvent: anEvent [ 

	anchorElement menuPaneDo: [ :mb | mb cancelAutoOpen ].
	super forceCloseWindowOnEvent: anEvent.

]

{ #category : #accessing }
ToMenuPopupManager >> inlineWindowClass [

	^ ToMenuInlineWindowElement
]

{ #category : #'event handling' }
ToMenuPopupManager >> isPickedOutsideEvent: anEvent [
	" return true if the event is considered as a pick outside event "

	| target |
	target := anEvent target.
	(target firstInParentChainSatisfying: [ :e |
		 e isKindOf: ToAnchoredWindow ]) ifNotNil: [ :w |
		target := w anchorElement ].
	target ifNil: [ ^ super isPickedOutsideEvent: anEvent ].
	(target hasAnyInParentChainSatisfying: [ :e |
		 e isKindOf: ToMenuItemElement ]) ifTrue: [ ^ false ].
	^ super isPickedOutsideEvent: anEvent
]

{ #category : #'event handling' }
ToMenuPopupManager >> mouseEnterEvent: anEvent [

	anchorElement itemBar secondarySelecter deselectAll
]

{ #category : #'window handling' }
ToMenuPopupManager >> newInlineWindowStarter [ 

	^ ToInlineMenuStarter new
]

{ #category : #'window handling' }
ToMenuPopupManager >> newWindow [

	| w |
	w := super newWindow.
	self anchorElement isSubmenu ifTrue: [
		self anchorRoot: self anchorElement parentMenu manager anchorRoot ].
	^ w
]

{ #category : #'event handling' }
ToMenuPopupManager >> onMouseUpOutsideEvent: anEvent [

	super onMouseUpOutsideEvent: anEvent.
	anchorElement menuPaneDo: [ :mb |
		mb cancelAutoOpen ]
]

{ #category : #'window handling' }
ToMenuPopupManager >> onWindowClosed [

	super onWindowClosed.
	anchorElement itemBar secondarySelecter deselectAll
]

{ #category : #'window handling' }
ToMenuPopupManager >> onWindowOpened [

	super onWindowOpened.
	anchorElement itemBar requestFocus
]
