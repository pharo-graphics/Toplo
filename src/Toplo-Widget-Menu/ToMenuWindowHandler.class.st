Class {
	#name : #ToMenuWindowHandler,
	#superclass : #ToPopupWindowHandler,
	#category : 'Toplo-Widget-Menu-Basic'
}

{ #category : #initialization }
ToMenuWindowHandler >> defaulPositionHook [ 

	^ [ :event :theMenu | theMenu isSubmenu
		  ifTrue: [ theMenu bounds inSpace bounds topRight ]
		  ifFalse: [ theMenu bounds inSpace bounds bottomLeft ] ]
]

{ #category : #accessing }
ToMenuWindowHandler >> elementEventHandlerClass [ 

	^ ToMenuEventHandler
]

{ #category : #'theme event handling' }
ToMenuWindowHandler >> toThemeChanged [

	currentWindow ifNotNil: [ currentWindow toThemeChanged ]
]

{ #category : #accessing }
ToMenuWindowHandler >> windowClass [

	^ ToMenuWindow 
]
