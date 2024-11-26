Class {
	#name : #ToMenuWindowManager,
	#superclass : #ToPopupWindowManager,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #initialization }
ToMenuWindowManager >> defaultPositionHook [

	^ [ :window :theMenu :event |
	  window position: (theMenu isSubmenu
			   ifTrue: [
			   (theMenu bounds inParent: self anchorRoot) bounds topRight ]
			   ifFalse: [
			   (theMenu bounds inParent: self anchorRoot) bounds bottomLeft ]) ]
]

{ #category : #'window handling' }
ToMenuWindowManager >> popupNewWindowEvent: anEvent [

	element items ifEmpty: [ ^ self ].
	super popupNewWindowEvent: anEvent
]

{ #category : #accessing }
ToMenuWindowManager >> windowClass [

	^ ToMenuWindow 
]
