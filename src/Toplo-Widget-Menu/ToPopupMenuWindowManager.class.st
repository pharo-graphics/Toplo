Class {
	#name : #ToPopupMenuWindowManager,
	#superclass : #ToMenuWindowManager,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #'window handling' }
ToPopupMenuWindowManager >> beInline [ 
	" for inline windows/ menus"
	windowStarter := self newInlineWindowStarter.
	checkOutsideEvent := false.
	anchorElement openOnHovered: false
]

{ #category : #'window handling' }
ToPopupMenuWindowManager >> bottomUpCloseWindowRequestOnEvent: anEvent [ 
	" requestto actually manage the window closing "

	self closeWindowNowOnEvent: anEvent.
	self hasInlineWindow ifTrue: [ ^ self ].
	anchorElement menuPaneDo: [ :mb | mb cancelAutoOpen ].
	anchorElement parentMenuDo: [ :rm |
		rm manager bottomUpCloseWindowRequestOnEvent: anEvent ]
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

	anchorElement isSubmenu ifTrue: [
		anchorRoot := anchorElement parentMenu manager anchorRoot ].
	^ super newWindow
]

{ #category : #'event handling' }
ToPopupMenuWindowManager >> onOutsideEvent: anEvent [

	super onOutsideEvent: anEvent.
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
	anchorElement isInline ifTrue: [ ^ self ].
	anchorElement menuPaneDo: [ :mb | mb startAutoOpen ].

]
