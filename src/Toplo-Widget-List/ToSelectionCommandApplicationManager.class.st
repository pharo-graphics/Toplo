Class {
	#name : #ToSelectionCommandApplicationManager,
	#superclass : #ToCommandApplicationManager,
	#instVars : [
		'previousModel'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'command application' }
ToSelectionCommandApplicationManager >> applyCommand: aCommand withOperator: anOperator [

	previousModel := aCommand selectionModel copy.
	aCommand applyWithOperator: anOperator.
	aCommand selectionChanged: previousModel ~= aCommand selectionModel.
	aCommand selectionChanged ifFalse: [ ^ self ].
	self notifyCommandApplied: aCommand  withOperator: anOperator
]
