Class {
	#name : #ToMenuWindowManager,
	#superclass : #ToPopupWindowManager,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #'window handling' }
ToMenuWindowManager >> beInline [ 

	super beInline.
	element openOnHovered: false
]

{ #category : #'event handling' }
ToMenuWindowManager >> checkCloseOnPickingEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	(target isInline or: [ target isInInlineWindow ]) ifTrue: [
		^ currentWindow notNil ].
	^ super checkCloseOnPickingEvent: anEvent
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

{ #category : #accessing }
ToMenuWindowManager >> inlineWindowClass [

	^ ToInlineMenuWindowElement
]

{ #category : #'event handling' }
ToMenuWindowManager >> mouseEnterEvent: anEvent [

	element itemBar secondarySelecter deselectAll
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
	element itemBar secondarySelecter deselectAll
]

{ #category : #'window handling' }
ToMenuWindowManager >> onOpened [

	super onOpened.
	element itemBar requestFocus
]

{ #category : #'event handling' }
ToMenuWindowManager >> pickOutsideEvent: anEvent [

	super pickOutsideEvent: anEvent.
	element menuBarDo: [ :mb |
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
