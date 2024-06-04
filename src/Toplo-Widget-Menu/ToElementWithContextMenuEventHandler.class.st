Class {
	#name : #ToElementWithContextMenuEventHandler,
	#superclass : #ToElementWithPopupEventHandler,
	#category : #'Toplo-Widget-Menu-Context menu'
}

{ #category : #'element handlers' }
ToElementWithContextMenuEventHandler >> contextMenuClosedEvent: anEvent [

	anEvent windowManager = windowManager ifFalse: [ ^ self ].
	windowManager onWindowClosed 
]

{ #category : #'element handlers' }
ToElementWithContextMenuEventHandler >> contextMenuOpenedEvent: anEvent [

	anEvent windowManager = windowManager ifFalse: [ ^ self ].
	windowManager onWindowOpened
]

{ #category : #'event handling' }
ToElementWithContextMenuEventHandler >> elementPositionInSpaceChangedEvent: anEvent [

	windowManager currentWindowDo: [ :cw | cw close ] 
]
