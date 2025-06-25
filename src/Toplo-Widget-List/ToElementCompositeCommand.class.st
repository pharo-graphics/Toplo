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
ToElementCompositeCommand >> addCommand: aCommand [

	commands add: aCommand
]

{ #category : #application }
ToElementCompositeCommand >> applicationResquestIn: aCommandApplier [

	aCommandApplier applyCompositeCommand: self
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

{ #category : #application }
ToElementCompositeCommand >> onAppliedOn: aCommandApplier [

	aCommandApplier onCompositeCommandApplied: self.
	commands do: [ :cmd | aCommandApplier onCommandApplied: cmd ]
]
