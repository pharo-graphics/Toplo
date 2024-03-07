Class {
	#name : #ToBasicCommandApplier,
	#superclass : #Object,
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'command application' }
ToBasicCommandApplier >> applyCommand: aCommand in: aTarget [ 
	
	self applyCommand: aCommand in: aTarget withApplicationBlock: [ aCommand applyOn: self in: aTarget ]
]

{ #category : #'private command application' }
ToBasicCommandApplier >> applyCommand: aCommand in: aTarget withApplicationBlock: aBlock [

	aBlock value
]
