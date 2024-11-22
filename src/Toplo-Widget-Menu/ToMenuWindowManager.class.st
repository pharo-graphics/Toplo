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

{ #category : #initialization }
ToMenuWindowManager >> initialize [ 

	super initialize.
	popupOnMouseEnter := false.
	closeOnMouseLeave := false.

]

{ #category : #'event handling' }
ToMenuWindowManager >> popupWindowClosedEvent: anEvent [
	" deselect all to have a freshed window without any selection on next popup "

	anEvent currentTarget itemList secondarySelectionModel deselectAll.
	super popupWindowClosedEvent: anEvent
]

{ #category : #accessing }
ToMenuWindowManager >> windowClass [

	^ ToMenuWindow 
]
