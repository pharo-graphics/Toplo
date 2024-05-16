Class {
	#name : #ToLabelEditorEventHandler,
	#superclass : #ToAnchorEventHandler,
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #'window opening - closing handlers' }
ToLabelEditorEventHandler >> labelEditorClosedEvent: anEvent [

	self windowClosedEvent: anEvent
]

{ #category : #'window opening - closing handlers' }
ToLabelEditorEventHandler >> labelEditorOpenedEvent: anEvent [

	self windowOpenedEvent: anEvent
]
