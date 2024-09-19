Class {
	#name : #ToLabelEditorClosedEvent,
	#superclass : #ToWindowClosedEvent,
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #sending }
ToLabelEditorClosedEvent >> sendTo: anObject [

	anObject labelEditorClosedEvent: self
]
