Class {
	#name : #ToBasicCommandApplier,
	#superclass : #Object,
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'command application' }
ToBasicCommandApplier >> applyCommand: aCommand in: aTarget [ 
	
	aCommand applyOn: aCommand operator in: aTarget
]
