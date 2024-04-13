Class {
	#name : #ToMenuWindowManager,
	#superclass : #ToPopupWindowManager,
	#category : #'Toplo-Widget-Menu-Basic'
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
