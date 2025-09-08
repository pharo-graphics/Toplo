Class {
	#name : #ToMenuWindowManager,
	#superclass : #ToPopupWindowManager,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #'window handling' }
ToMenuWindowManager >> beInline [ 

	super beInline.
	anchorElement openOnHovered: false
]

{ #category : #'window handling' }
ToMenuWindowManager >> checkCloseWindowOnEvent: anEvent [ 

	anchorElement menuPaneDo: [ :mb | mb cancelAutoOpen ].
	super checkCloseWindowOnEvent: anEvent
]

{ #category : #initialization }
ToMenuWindowManager >> defaultMeasurement [

	^ ToMenuMeasurement new
]

{ #category : #initialization }
ToMenuWindowManager >> defaultPlacement [

	^ ToMenuPlacement new
]

{ #category : #accessing }
ToMenuWindowManager >> defaultWindowClass [

	^ ToMenuWindow
]

{ #category : #'api - accessing' }
ToMenuWindowManager >> eventsToHandle [

	^ super eventsToHandle , {
		  BlMouseEnterEvent.
		  BlMouseLeaveEvent }
]

{ #category : #accessing }
ToMenuWindowManager >> inlineWindowClass [

	^ ToMenuInlineWindowElement
]

{ #category : #'event handling' }
ToMenuWindowManager >> mouseEnterEvent: anEvent [

	anchorElement itemBar secondarySelecter deselectAll
]

{ #category : #'window handling' }
ToMenuWindowManager >> newInlineWindowStarter [ 

	^ ToInlineMenuStarter new
]

{ #category : #'window handling' }
ToMenuWindowManager >> newWindow [

	| w |
	w := super newWindow.
	self anchorElement isSubmenu ifTrue: [
		self anchorRoot: self anchorElement parentMenu manager anchorRoot ].
	^ w
]

{ #category : #'event handling' }
ToMenuWindowManager >> onMouseUpOutsideEvent: anEvent [

	super onMouseUpOutsideEvent: anEvent.
	anchorElement menuPaneDo: [ :mb |
		mb cancelAutoOpen ]
]

{ #category : #'window handling' }
ToMenuWindowManager >> onWindowClosed [

	super onWindowClosed.
	anchorElement itemBar secondarySelecter deselectAll
]

{ #category : #'window handling' }
ToMenuWindowManager >> onWindowOpened [

	super onWindowOpened.
	anchorElement itemBar requestFocus.
	anchorElement isInline ifTrue: [ ^ self ].
	anchorElement menuPaneDo: [ :mb | mb startAutoOpen ].

]

{ #category : #initialization }
ToMenuWindowManager >> pickOutsideFilterClass [

	^ ToMenuMouseUpOutsideEventFilter
]
