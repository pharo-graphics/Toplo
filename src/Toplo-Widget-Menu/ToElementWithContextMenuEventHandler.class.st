Class {
	#name : #ToElementWithContextMenuEventHandler,
	#superclass : #ToElementWithPopupEventHandler,
	#category : 'Toplo-Widget-Menu-Context menu'
}

{ #category : #'element handlers' }
ToElementWithContextMenuEventHandler >> contextMenuClosedEvent: anEvent [

	windowManager onWindowClosed 
]

{ #category : #'event handling' }
ToElementWithContextMenuEventHandler >> elementPositionInSpaceChangedEvent: anEvent [

	windowManager currentWindowDo: [ :cw | cw close ] 
]
