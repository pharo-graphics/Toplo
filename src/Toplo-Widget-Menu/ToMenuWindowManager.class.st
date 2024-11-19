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
				   (theMenu bounds inParent: self anchorRoot) bounds topRight
				   + (theMenu padding topRight + (theMenu padding left @ 0)) ]
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
	anEvent currentTarget bar secondarySelectionModel deselectAll.
	super popupWindowClosedEvent: anEvent
]

{ #category : #'theme event handling' }
ToMenuWindowManager >> toThemeInstalled [

	currentWindow ifNotNil: [ currentWindow toThemeInstalled ]
]

{ #category : #'theme event handling' }
ToMenuWindowManager >> toThemeUninstalled: aTheme [

	currentWindow ifNotNil: [ currentWindow toThemeUninstalled: aTheme ]
]

{ #category : #accessing }
ToMenuWindowManager >> windowClass [

	^ ToMenuWindow 
]
