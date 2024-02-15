"
My class hierarchy models all the basic actions that can be made on a selection. 

"
Class {
	#name : #ToBasicCommand,
	#superclass : #Object,
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #hook }
ToBasicCommand >> applyOn: anObject [

	self applyOn: anObject for: nil
]

{ #category : #hook }
ToBasicCommand >> applyOn: anObject for: aTarget [
]
