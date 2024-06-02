Class {
	#name : #ToCommandApplicationManager,
	#superclass : #Object,
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'command application' }
ToCommandApplicationManager >> applyCommand: aCommand withOperator: anOperator [

	aCommand applyWithOperator: anOperator.
	self notifyCommandApplied: aCommand  withOperator: anOperator
]

{ #category : #'command application' }
ToCommandApplicationManager >> notifyCommandApplied: aCommand withOperator: anOperator [

	anOperator dispatchEvent: (ToElementCommandAppliedEvent new
			 command: aCommand;
			 yourself)
]
