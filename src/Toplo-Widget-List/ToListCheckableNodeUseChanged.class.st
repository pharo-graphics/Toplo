Class {
	#name : #ToListCheckableNodeUseChanged,
	#superclass : #BlEvent,
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #sending }
ToListCheckableNodeUseChanged >> sendTo: anObject [

	anObject listCheckableNodeUseChanged: self
]
