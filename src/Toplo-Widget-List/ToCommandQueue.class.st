Class {
	#name : #ToCommandQueue,
	#superclass : #Object,
	#instVars : [
		'commands'
	],
	#category : #'Toplo-Widget-List-Command-Support'
}

{ #category : #initialization }
ToCommandQueue >> initialize [ 

	super initialize.
	commands := OrderedCollection new
]

{ #category : #accessing }
ToCommandQueue >> nextOrNil [

	^ commands ifNotEmpty: [ commands removeFirst ] ifEmpty: [  ]
]

{ #category : #accessing }
ToCommandQueue >> nextPut: aCommand [

	commands add: aCommand
]
