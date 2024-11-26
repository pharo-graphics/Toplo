Class {
	#name : #ToLabelEditorOpenedEvent,
	#superclass : #ToOpenedEvent,
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #sending }
ToLabelEditorOpenedEvent >> sendTo: anObject [

	anObject labelEditorOpenedEvent: self
]
