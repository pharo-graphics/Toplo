Class {
	#name : #ToScrollCommand,
	#superclass : #ToListElementCommand,
	#instVars : [
		'index'
	],
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #'private - hook' }
ToScrollCommand >> applyOn: anOperator [ 

	anOperator scrollCommand: self.
	super applyOn: anOperator
]

{ #category : #accessing }
ToScrollCommand >> index [

	^ index
]

{ #category : #accessing }
ToScrollCommand >> index: anIndex [

	index := anIndex
]
