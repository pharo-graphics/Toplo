Class {
	#name : #ToScrollCommand,
	#superclass : #ToListElementCommand,
	#instVars : [
		'target',
		'index',
		'towardEnd'
	],
	#category : #'Toplo-Widget-List-Command'
}

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

{ #category : #accessing }
ToScrollCommand >> indexes [ 

	^ Array with: index
]

{ #category : #initialization }
ToScrollCommand >> initialize [ 

	super initialize.
	towardEnd := true
]

{ #category : #accessing }
ToScrollCommand >> target [

	^ target
]

{ #category : #accessing }
ToScrollCommand >> target: aTarget [

	target := aTarget
]

{ #category : #accessing }
ToScrollCommand >> towardEnd [

	^ towardEnd
]

{ #category : #accessing }
ToScrollCommand >> towardEnd: aBoolean [

	towardEnd := aBoolean
]
