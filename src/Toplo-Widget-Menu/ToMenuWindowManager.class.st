Class {
	#name : #ToMenuWindowManager,
	#superclass : #ToPopupWindowManager,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #'window handling' }
ToMenuWindowManager >> autoCloseWindow [ 

	super autoCloseWindow.
	anchorElement menuPaneDo: [ :mb | mb cancelAutoOpen ]
]

{ #category : #'window handling' }
ToMenuWindowManager >> beInline [ 

	super beInline.
	anchorElement openOnHovered: false
]

{ #category : #'event handling' }
ToMenuWindowManager >> canCloseOnPickingEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	(target isInline or: [ target isInInlineWindow ]) ifTrue: [
		^ currentWindow notNil ].
	^ super canCloseOnPickingEvent: anEvent
]

{ #category : #initialization }
ToMenuWindowManager >> defaultMeasurement [

	^ ToMenuMeasurement new
]

{ #category : #initialization }
ToMenuWindowManager >> defaultPlacement [

	^ ToMenuPlacement new
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

{ #category : #'event handling' }
ToMenuWindowManager >> mouseLeaveEvent: anEvent [

]

{ #category : #'window handling' }
ToMenuWindowManager >> newInlineMode [ 

	^ ToMenuInlineWindowMode new
]

{ #category : #'window handling' }
ToMenuWindowManager >> onClosed [

	super onClosed.
	anchorElement itemBar secondarySelecter deselectAll
]

{ #category : #'window handling' }
ToMenuWindowManager >> onOpened [

	super onOpened.
	anchorElement itemBar requestFocus
]

{ #category : #'event handling' }
ToMenuWindowManager >> pickOutsideEvent: anEvent [

	super pickOutsideEvent: anEvent.
	anchorElement menuPaneDo: [ :mb |
		mb cancelAutoOpen ]
]

{ #category : #'window handling' }
ToMenuWindowManager >> pickOutsideFilterClass [ 

	^ ToMenuWindowPickOutsideEventFilter
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
