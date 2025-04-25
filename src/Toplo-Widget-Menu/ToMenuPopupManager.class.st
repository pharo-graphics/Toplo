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
ToMenuPopupManager >> newInlineMode [ 

	^ ToMenuInlineWindowMode new
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
