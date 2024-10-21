Class {
	#name : #ToImmediateCommandApplier,
	#superclass : #ToCommandApplier,
	#category : #'Toplo-Widget-List-Command-Support'
}

{ #category : #accessing }
ToImmediateCommandApplier >> command: aCommand addedIn: aSelecter [

	aSelecter applyCommand: aCommand
]
