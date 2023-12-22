Class {
	#name : 'ToElementWithContextMenuEventHandler',
	#superclass : 'ToElementWithPopupEventHandler',
	#category : 'Toplo-Widget-Menu-Context menu',
	#package : 'Toplo-Widget-Menu',
	#tag : 'Context menu'
}

{ #category : 'event handling' }
ToElementWithContextMenuEventHandler >> elementPositionInSpaceChangedEvent: anEvent [

	windowManager currentWindowDo: [ :cw | cw close ] 
]
