Class {
	#name : #ToItemConstraints,
	#superclass : #Object,
	#instVars : [
		'disabled',
		'unselectable',
		'hidden'
	],
	#category : #'Toplo-Widget-List-ItemBar'
}

{ #category : #'updating list' }
ToItemConstraints >> constraintItem: anItem [ 

	disabled ifNotNil: [ anItem disabled: disabled ].
	unselectable ifNotNil: [ anItem unselectable: unselectable ].
	hidden ifNotNil: [ anItem hidden: hidden ]
]

{ #category : #accessing }
ToItemConstraints >> disabled [

	^ disabled ifNil: [ false ]
]

{ #category : #accessing }
ToItemConstraints >> disabled: aBoolean [

	disabled := aBoolean
]

{ #category : #accessing }
ToItemConstraints >> hidden [

	^ hidden ifNil: [ false ]
]

{ #category : #accessing }
ToItemConstraints >> hidden: aBoolean [

	hidden := aBoolean
]

{ #category : #accessing }
ToItemConstraints >> unselectable [

	^ unselectable ifNil: [ false ]
]

{ #category : #accessing }
ToItemConstraints >> unselectable: aBoolean [

	unselectable := aBoolean
]
