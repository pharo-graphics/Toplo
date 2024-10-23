Class {
	#name : #ToImmediateCommandApplicationStrategy,
	#superclass : #ToCommandApplicationStrategy,
	#category : #'Toplo-Widget-List-Command-Support'
}

{ #category : #accessing }
ToImmediateCommandApplicationStrategy >> addCommand: aCommand [ 

	commandApplier applyCommand: aCommand
]
