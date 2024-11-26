Class {
	#name : #ToLabelEditorClosedEvent,
	#superclass : #ToClosedEvent,
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #sending }
ToLabelEditorClosedEvent >> sendTo: anObject [

	anObject labelEditorClosedEvent: self
]
