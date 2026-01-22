Class {
	#name : #ToListSelectionContainer,
	#superclass : #ToOverlayElement,
	#instVars : [
		'beneath'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #configuration }
ToListSelectionContainer >> applyConfiguration [

	| e |
	super applyConfiguration.
	e := beneath
		     ifTrue: [ 5 ]
		     ifFalse: [ 15 ].
	self elevation: (BlRelativeElevation elevation: e)
]

{ #category : #accessing }
ToListSelectionContainer >> beneath: aBoolean [

	beneath = aBoolean ifTrue: [ ^ self ].
	beneath := aBoolean.
	self requestConfiguration 
]

{ #category : #initialization }
ToListSelectionContainer >> initialize [ 

	super initialize.
	beneath := true
]
