Class {
	#name : #ToMenuPopupManager,
	#superclass : #ToPopupWindowManager,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #'window handling' }
ToMenuPopupManager >> autoCloseWindow [ 

	super autoCloseWindow.
	anchorElement menuPaneDo: [ :mb | mb cancelAutoOpen ]
]

{ #category : #'window handling' }
ToMenuPopupManager >> beInline [ 

	super beInline.
	anchorElement openOnHovered: false
]

{ #category : #'event handling' }
ToMenuPopupManager >> canCloseOnPickingEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	(target isInline or: [ target isInInlineWindow ]) ifTrue: [
		^ currentWindow notNil ].
	^ super canCloseOnPickingEvent: anEvent
]

{ #category : #initialization }
ToMenuPopupManager >> defaultMeasurement [

	^ ToMenuMeasurement new
]

{ #category : #initialization }
ToMenuPopupManager >> defaultPlacement [

	^ ToMenuPlacement new
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

{ #category : #'event handling' }
ToMenuPopupManager >> mouseLeaveEvent: anEvent [

]

{ #category : #'window handling' }
ToMenuPopupManager >> onClosed [

	super onClosed.
	anchorElement itemBar secondarySelecter deselectAll
]

{ #category : #'window handling' }
ToMenuPopupManager >> onOpened [

	super onOpened.
	anchorElement itemBar requestFocus
]

{ #category : #'event handling' }
ToMenuPopupManager >> pickOutsideEvent: anEvent [

	super pickOutsideEvent: anEvent.
	anchorElement menuPaneDo: [ :mb |
		mb cancelAutoOpen ]
]

{ #category : #'window handling' }
ToMenuPopupManager >> pickOutsideFilterClass [ 

	^ ToMenuPickOutsideEventFilter
]

{ #category : #'window handling' }
ToMenuPopupManager >> popupNewWindowEvent: anEvent [

	"element items ifEmpty: [ ^ self ]."
	super popupNewWindowEvent: anEvent
]

{ #category : #accessing }
ToMenuPopupManager >> popupWindowClass [

	^ ToMenuWindow
]

{ #category : #'window handling' }
ToMenuPopupManager >> startWindow: aWindow [
	" the manager element is a ToMenu. 
	The window is added after the ToMenu in its barOwner"

	super startWindow: aWindow.
	isInline ifFalse: [ ^ self ].
	" an inline window works correctly only with wrapping (need for the flow layout)"
	aWindow itemBar isFlowable: true.
	self anchorElement menuBarOwner
		addItem: aWindow
		afterIndex: self anchorElement positionInList.
	" need to install a new skin to change the icon (from closed to opened) "
	self anchorElement requestNewSkin
]

{ #category : #'window handling' }
ToMenuPopupManager >> stopWindow: aWindow [
	" the manager element is a ToMenu. 
	The window is removed from its barOwner"

	super stopWindow: aWindow.
	isInline ifFalse: [ ^ self ].
	" an inline window works correctly only with wrapping (need for the flow layout)"
	aWindow itemBar isFlowable: true.
	self anchorElement menuBarOwner removeItem: aWindow.
	" need to install a new skin to change the icon (from closed to opened) "
	self anchorElement requestNewSkin
]
