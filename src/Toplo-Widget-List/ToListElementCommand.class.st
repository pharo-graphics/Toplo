Class {
	#name : #ToListElementCommand,
	#superclass : #ToBasicCommand,
	#instVars : [
		'silent'
	],
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #accessing }
ToListElementCommand >> silent [

	^ silent ifNil: [ silent := false ]
]

{ #category : #accessing }
ToListElementCommand >> silent: aBoolean [

	silent := aBoolean
]
