Class {
	#name : #ToMenuStrategy,
	#superclass : #ToPopupWindowStrategy,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #initialization }
ToMenuStrategy >> defaultPositionHook [

	^ [ :window :theMenu :event |
	  (theMenu isSubmenu
			   ifTrue: [
			   (theMenu bounds inParent: self anchorRoot) topRight ]
			   ifFalse: [
			   (theMenu bounds inParent: self anchorRoot) bottomLeft ]) ]
]
