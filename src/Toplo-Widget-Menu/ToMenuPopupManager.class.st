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

{ #category : #'window handling' }
ToMenuPopupManager >> closeWindowOnEvent: anEvent [ 

	anchorElement menuPaneDo: [ :mb | mb cancelAutoOpen ].
	super closeWindowOnEvent: anEvent
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

{ #category : #accessing }
ToMenuPopupManager >> inlineWindowClass [

	^ ToMenuInlineWindowElement
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

{ #category : #initialization }
ToMenuPopupManager >> pickOutsideFilterClass [

	^ ToMenuMouseUpOutsideEventFilter
]
