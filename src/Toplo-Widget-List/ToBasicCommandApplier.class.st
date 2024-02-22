Class {
	#name : #ToBasicCommandApplier,
	#superclass : #Object,
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'command application' }
ToBasicCommandApplier >> applyCommand: aCommand for: aTarget [ 
	
	self applyCommand: aCommand for: aTarget withApplicationBlock: [ aCommand applyOn: self for: aTarget ]
]

{ #category : #'private command application' }
ToBasicCommandApplier >> applyCommand: aCommand for: aTarget withApplicationBlock: aBlock [

	aBlock value
]
