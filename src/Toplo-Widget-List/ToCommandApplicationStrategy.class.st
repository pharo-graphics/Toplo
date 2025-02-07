Class {
	#name : #ToCommandApplicationStrategy,
	#superclass : #Object,
	#instVars : [
		'element'
	],
	#category : #'Toplo-Widget-List-Command-Support'
}

{ #category : #accessing }
ToCommandApplicationStrategy >> addCommand: aCommand from: aCommandApplier [

	self subclassResponsibility 
]

{ #category : #accessing }
ToCommandApplicationStrategy >> element: anElement [

	element := anElement
]
