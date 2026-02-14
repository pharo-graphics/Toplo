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

	^ anchorElement defaultWindowMeasurement
]

{ #category : #initialization }
ToPopupMenuWindowManager >> defaultPlacement [

	^ anchorElement defaultWindowPlacement
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

{ #category : #'window handling' }
ToPopupMenuWindowManager >> windowClass [ 

	^ anchorElement windowClass
]

{ #category : #accessing }
ToPopupMenuWindowManager >> windowStarter [

	^ anchorElement windowStarter
]
