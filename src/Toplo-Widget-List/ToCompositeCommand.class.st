Class {
	#name : #ToCompositeCommand,
	#superclass : #ToBasicCommand,
	#instVars : [
		'commands'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #hook }
ToCompositeCommand >> applyOn: anObject for: aTarget [

	self commands do: [ :cmd | cmd applyOn: anObject for: aTarget ]
]

{ #category : #accessing }
ToCompositeCommand >> commands [

	^ commands ifNil: [ commands := #(  ) ]
]

{ #category : #accessing }
ToCompositeCommand >> commands: aCommandArray [

	commands := aCommandArray
]

{ #category : #accessing }
ToCompositeCommand >> silent: aBoolean [

	self commands do: [ :c | c silent: aBoolean ].
	super silent: aBoolean
]
