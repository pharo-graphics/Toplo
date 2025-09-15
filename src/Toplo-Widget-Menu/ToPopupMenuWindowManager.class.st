Class {
	#name : #ToPopupMenuWindowManager,
	#superclass : #ToMenuWindowManager,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #'window handling' }
ToPopupMenuWindowManager >> beInline [ 
	" for inline windows/ menus"
	windowStarter := self newInlineWindowStarter.
	checkPickOutside := false.
	anchorElement openOnHovered: false
]

{ #category : #'window handling' }
ToPopupMenuWindowManager >> bottomUpCloseWindowRequestOnEvent: anEvent [ 
	" requestto actually manage the window closing "

	self checkCloseWindowOnEvent: anEvent.
	self hasInlineWindow ifTrue: [ ^ self ].
	anchorElement parentMenuDo: [ :rm |
		rm manager bottomUpCloseWindowRequestOnEvent: anEvent ]
]

{ #category : #'window handling' }
ToPopupMenuWindowManager >> checkCloseWindowOnEvent: anEvent [ 

	anchorElement menuPaneDo: [ :mb | mb cancelAutoOpen ].
	super checkCloseWindowOnEvent: anEvent
]

{ #category : #initialization }
ToPopupMenuWindowManager >> defaultMeasurement [

	^ ToMenuMeasurement new
]

{ #category : #initialization }
ToPopupMenuWindowManager >> defaultPlacement [

	^ ToMenuPlacement new
]

{ #category : #accessing }
ToPopupMenuWindowManager >> defaultWindowClass [

	^ ToMenuWindow
]

{ #category : #'api - accessing' }
ToPopupMenuWindowManager >> eventsToHandle [

	^ super eventsToHandle , {
		  BlMouseEnterEvent.
		  BlMouseLeaveEvent }
]

{ #category : #testing }
ToPopupMenuWindowManager >> hasInlineWindow [

	^ windowStarter isForInlineWindow
]

{ #category : #accessing }
ToPopupMenuWindowManager >> inlineWindowClass [

	^ ToMenuInlineWindowElement
]

{ #category : #'event handling' }
ToPopupMenuWindowManager >> mouseEnterEvent: anEvent [

	anchorElement itemBar secondarySelecter deselectAll
]

{ #category : #'window handling' }
ToPopupMenuWindowManager >> newInlineWindowStarter [ 

	^ ToInlineMenuStarter new
]

{ #category : #'window handling' }
ToPopupMenuWindowManager >> newWindow [

	| w |
	w := super newWindow.
	self anchorElement isSubmenu ifTrue: [
		self anchorRoot: self anchorElement parentMenu manager anchorRoot ].
	^ w
]

{ #category : #'event handling' }
ToPopupMenuWindowManager >> onMouseUpOutsideEvent: anEvent [

	super onMouseUpOutsideEvent: anEvent.
	anchorElement menuPaneDo: [ :mb |
		mb cancelAutoOpen ]
]

{ #category : #'window handling' }
ToPopupMenuWindowManager >> onWindowClosedOnEvent: anEvent [

	super onWindowClosedOnEvent: anEvent.
	anchorElement itemBar secondarySelecter deselectAll
]

{ #category : #'window handling' }
ToPopupMenuWindowManager >> onWindowOpenedOnEvent: anEvent [

	super onWindowOpenedOnEvent: anEvent.
	anchorElement itemBar requestFocus.
	anchorElement isInline ifTrue: [ ^ self ].
	anchorElement menuPaneDo: [ :mb | mb startAutoOpen ].

]

{ #category : #initialization }
ToPopupMenuWindowManager >> pickOutsideFilterClass [

	^ ToMenuMouseUpOutsideEventFilter
]
