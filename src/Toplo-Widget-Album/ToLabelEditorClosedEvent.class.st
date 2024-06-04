Class {
	#name : #ToLabelEditorClosedEvent,
	#superclass : #ToAnchoredWindowClosedEvent,
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #sending }
ToLabelEditorClosedEvent >> sendTo: anObject [

	anObject labelEditorClosedEvent: self
]
