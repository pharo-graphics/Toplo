Class {
	#name : #ToBasicCommandApplier,
	#superclass : #Object,
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'command application' }
ToBasicCommandApplier >> applyCommand: aCommand for: aTarget [

	aCommand applyOn: self for: aTarget.

]
