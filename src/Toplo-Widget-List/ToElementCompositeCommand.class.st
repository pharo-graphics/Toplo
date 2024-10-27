Class {
	#name : #ToElementCompositeCommand,
	#superclass : #ToElementBasicCommand,
	#instVars : [
		'commands'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'instance creation' }
ToElementCompositeCommand class >> withAll: commands [

	^ self new
		  addAll: commands;
		  yourself
]

{ #category : #accessing }
ToElementCompositeCommand >> add: aCommand [

	commands add: aCommand
]

{ #category : #accessing }
ToElementCompositeCommand >> addAll: aCommandArray [

	commands addAll: aCommandArray
]

{ #category : #'private - hook' }
ToElementCompositeCommand >> applyWithOperator: anOperator [

	super applyWithOperator: anOperator.
	commands do: [ :c | c applyWithOperator: anOperator ]
]

{ #category : #initialization }
ToElementCompositeCommand >> initialize [

	super initialize.
	commands := OrderedCollection new
]
