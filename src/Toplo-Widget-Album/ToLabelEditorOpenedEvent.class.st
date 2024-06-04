Class {
	#name : #ToLabelEditorOpenedEvent,
	#superclass : #ToAnchoredWindowOpenedEvent,
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #sending }
ToLabelEditorOpenedEvent >> sendTo: anObject [

	anObject labelEditorOpenedEvent: self
]
