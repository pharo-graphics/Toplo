Class {
	#name : #ToPopupMenuWindowManager,
	#superclass : #ToPopupWindowManager,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #accessing }
ToPopupMenuWindowManager >> anchorRoot [
	" the root element in which the window is placed "

	anchorElement isSubmenu ifTrue: [
		^ anchorElement parentMenu manager anchorRoot ].
	^ super anchorRoot
]

{ #category : #'window handling' }
ToPopupMenuWindowManager >> beInline [ 
	" for inline windows/ menus"
	self beInlineWithWindowClass: ToMenuInlineWindowElement
]

{ #category : #'window handling' }
ToPopupMenuWindowManager >> beInlineWithWindowClass: aWindowClass [
	" for inline windows/ menus"
	windowFactory := [ aWindowClass ].
	windowStarter := self newInlineWindowStarter.
	checkOutsideEvent := false
]

{ #category : #'window handling' }
ToPopupMenuWindowManager >> bottomUpCloseWindowRequestOnEvent: anEvent [ 
	" requestto actually manage the window closing "

	self closeWindowIfMinimumDelayExceededOnEvent: anEvent.
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

{ #category : #initialization }
ToPopupMenuWindowManager >> defaultWindowFactory [

	^ [
		  anchorElement isSubmenu
			  ifTrue: [ ToSubmenuWindow ]
			  ifFalse: [ ToMenuWindow ] ]
]

{ #category : #accessing }
ToPopupMenuWindowManager >> inlineWindowClass [

	^ ToMenuInlineWindowElement
]

{ #category : #'window handling' }
ToPopupMenuWindowManager >> newInlineWindowStarter [ 

	^ ToInlineMenuStarter new
]

{ #category : #'event handling' }
ToPopupMenuWindowManager >> onOutsideEvent: anEvent [

	super onOutsideEvent: anEvent.
	anchorElement onOutsideEvent: anEvent
]

{ #category : #'window handling' }
ToPopupMenuWindowManager >> onWindowOpenedOnEvent: anEvent [

	super onWindowOpenedOnEvent: anEvent.
	anchorElement isInline ifTrue: [ ^ self ].
	anchorElement menuPaneDo: [ :mb | mb startAutoOpen ]
]
