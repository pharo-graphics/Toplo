Class {
	#name : #ToContextMenuRequest,
	#superclass : #ToAnchoredWindowOpenRequest,
	#instVars : [
		'sourceEvent'
	],
	#category : #'Toplo-Widget-Menu-Context menu'
}

{ #category : #sending }
ToContextMenuRequest >> sendTo: anEvent [

	anEvent contextMenuRequest: self
]

{ #category : #accessing }
ToContextMenuRequest >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToContextMenuRequest >> sourceEvent: anEvent [

	sourceEvent := anEvent
]
