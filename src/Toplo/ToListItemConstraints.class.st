Class {
	#name : #ToListItemConstraints,
	#superclass : #Object,
	#instVars : [
		'selected',
		'disabled',
		'unselectable',
		'hidden'
	],
	#category : #'Toplo-Core'
}

{ #category : #'updating list' }
ToListItemConstraints >> constraintItem: anItem [

	selected ifNotNil: [
			anItem selected: selected.
			selected := nil ].
	disabled ifNotNil: [
			anItem disabled: disabled.
			disabled := nil ].
	unselectable ifNotNil: [
			anItem unselectable: unselectable.
			unselectable := nil ].
	hidden ifNotNil: [
			anItem hidden: hidden.
			hidden := nil ]
]

{ #category : #accessing }
ToListItemConstraints >> disabled [

	^ disabled ifNil: [ false ]
]

{ #category : #accessing }
ToListItemConstraints >> disabled: aBoolean [

	disabled := aBoolean
]

{ #category : #accessing }
ToListItemConstraints >> hidden [

	^ hidden ifNil: [ false ]
]

{ #category : #accessing }
ToListItemConstraints >> hidden: aBoolean [

	hidden := aBoolean
]

{ #category : #accessing }
ToListItemConstraints >> selected [

	^ selected ifNil: [ false ]
]

{ #category : #accessing }
ToListItemConstraints >> selected: aBoolean [

	selected := aBoolean
]

{ #category : #accessing }
ToListItemConstraints >> unselectable [

	^ unselectable ifNil: [ false ]
]

{ #category : #accessing }
ToListItemConstraints >> unselectable: aBoolean [

	unselectable := aBoolean
]
