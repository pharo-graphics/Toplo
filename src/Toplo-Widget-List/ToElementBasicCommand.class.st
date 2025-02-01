"
My class hierarchy models all the basic actions that can be made on a selection. 

"
Class {
	#name : #ToElementBasicCommand,
	#superclass : #Object,
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'private - adding' }
ToElementBasicCommand >> addedIn: aCommandApplier [
]

{ #category : #application }
ToElementBasicCommand >> applicationResquestIn: aCommandApplier [

	aCommandApplier applyBasicCommand: self
]

{ #category : #'private - hook' }
ToElementBasicCommand >> applyWithOperator: anOperator [

	" ask the operator passed as argument to actually apply the command. "
]

{ #category : #application }
ToElementBasicCommand >> onAppliedIn: aCommandApplier [

	aCommandApplier onBasicCommandApplied: self
]
