Class {
	#name : #ToListCheckableNodeUseChanged,
	#superclass : #BlEvent,
	#category : #'Toplo-Widget-List'
}

{ #category : #sending }
ToListCheckableNodeUseChanged >> sendTo: anObject [

	anObject listCheckableNodeUseChanged: self
]
