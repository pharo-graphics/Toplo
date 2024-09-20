Class {
	#name : #ToLabelEditorOpenedEvent,
	#superclass : #ToWindowOpenedEvent,
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #sending }
ToLabelEditorOpenedEvent >> sendTo: anObject [

	anObject labelEditorOpenedEvent: self
]
