Class {
	#name : #ToMenuWindowManager,
	#superclass : #ToPopupWindowManager,
	#category : 'Toplo-Widget-Menu-Basic'
}

{ #category : #initialization }
ToMenuWindowManager >> defaultPositionHook [

	^ [ :window :theMenu :event |
	  window position: (theMenu isSubmenu
			   ifTrue: [ (theMenu bounds inParent: self anchorRoot) bounds topRight ]
			   ifFalse: [ (theMenu bounds inParent: self anchorRoot) bounds bottomLeft ]) ]
]

{ #category : #accessing }
ToMenuWindowManager >> elementEventHandlerClass [ 

	^ ToMenuEventHandler
]

{ #category : #'theme event handling' }
ToMenuWindowManager >> toThemeChanged [

	currentWindow ifNotNil: [ currentWindow toThemeChanged ]
]

{ #category : #accessing }
ToMenuWindowManager >> windowClass [

	^ ToMenuWindow 
]
