Class {
	#name : #ToMenuWindowHandler,
	#superclass : #ToPopupWindowHandler,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #initialization }
ToMenuWindowHandler >> defaulPositionHook [ 

	^ [ :event | element isSubmenu
		  ifTrue: [ element bounds inSpace bounds topRight ]
		  ifFalse: [ element bounds inSpace bounds bottomLeft ] ]
]

{ #category : #accessing }
ToMenuWindowHandler >> elementEventHandlerClass [ 

	^ ToMenuEventHandler
]
