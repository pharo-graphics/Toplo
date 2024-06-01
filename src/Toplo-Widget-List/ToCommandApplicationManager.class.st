Class {
	#name : #ToCommandApplicationManager,
	#superclass : #Object,
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'command application' }
ToCommandApplicationManager >> applyCommand: aCommand inOperator: anOperator [

	aCommand applyOnOperator: anOperator.
	self notifyCommandApplied: aCommand  inOperator: anOperator
]

{ #category : #'command application' }
ToCommandApplicationManager >> commandAppliedEventClass [

	^ ToElementCommandAppliedEvent
]

{ #category : #'command application' }
ToCommandApplicationManager >> notifyCommandApplied: aCommand inOperator: anOperator [

	anOperator dispatchEvent: (ToElementCommandAppliedEvent new
			 command: aCommand;
			 yourself)
]
