Class {
	#name : #ToScrollCommand,
	#superclass : #ToListElementCommand,
	#instVars : [
		'index'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'private - hook' }
ToScrollCommand >> applyOn: anOperator [

	" ask the operator passed as argument to actually apply the command. "

	self
		deprecated: 'Use applyOnOperator: instead'
		transformWith: '`@receiver applyOn: `@argument'
			-> '`@receiver applyOnOperator: `@argument'.
	self applyWithOperator: anOperator
]

{ #category : #'private - hook' }
ToScrollCommand >> applyWithOperator: anOperator [ 

	anOperator scrollCommand: self.
	super applyWithOperator: anOperator
]

{ #category : #accessing }
ToScrollCommand >> index [

	^ index
]

{ #category : #accessing }
ToScrollCommand >> index: anIndex [

	index := anIndex
]
