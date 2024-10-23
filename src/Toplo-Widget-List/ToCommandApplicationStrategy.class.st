Class {
	#name : #ToCommandApplicationStrategy,
	#superclass : #Object,
	#instVars : [
		'element',
		'commandApplier'
	],
	#category : #'Toplo-Widget-List-Command-Support'
}

{ #category : #accessing }
ToCommandApplicationStrategy >> addCommand: aCommand [ 

	self subclassResponsibility 
]

{ #category : #accessing }
ToCommandApplicationStrategy >> commandApplier: aCommandApplier element: anElement [

	commandApplier := aCommandApplier.
	element := anElement
]
