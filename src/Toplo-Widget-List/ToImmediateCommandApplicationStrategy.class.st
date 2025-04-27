Class {
	#name : #ToImmediateCommandApplicationStrategy,
	#superclass : #ToCommandApplicationStrategy,
	#category : #'Toplo-Widget-List-Command-Support'
}

{ #category : #accessing }
ToImmediateCommandApplicationStrategy >> addCommand: aCommand from: aCommandApplier [

	aCommandApplier applyCommand: aCommand.
	element innerElement requestLayout
]
