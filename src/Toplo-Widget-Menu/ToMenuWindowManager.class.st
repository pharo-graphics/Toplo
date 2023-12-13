Class {
	#name : 'ToMenuWindowManager',
	#superclass : 'ToPopupWindowManager',
	#category : 'Toplo-Widget-Menu-Basic',
	#package : 'Toplo-Widget-Menu',
	#tag : 'Basic'
}

{ #category : 'initialization' }
ToMenuWindowManager >> defaulPositionHook [ 

	^ [ :event :theMenu | theMenu isSubmenu
		  ifTrue: [ theMenu bounds inSpace bounds topRight ]
		  ifFalse: [ theMenu bounds inSpace bounds bottomLeft ] ]
]

{ #category : 'accessing' }
ToMenuWindowManager >> elementEventHandlerClass [ 

	^ ToMenuEventHandler
]

{ #category : 'theme event handling' }
ToMenuWindowManager >> toThemeChanged [

	currentWindow ifNotNil: [ currentWindow toThemeChanged ]
]

{ #category : 'accessing' }
ToMenuWindowManager >> windowClass [

	^ ToMenuWindow 
]
