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

	element commandAdded: aCommand fromApplier: aCommandApplier
]

{ #category : #accessing }
ToCommandApplicationStrategy >> element: anElement [

	element := anElement
]
